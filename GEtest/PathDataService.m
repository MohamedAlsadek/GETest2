//
//  PathDataService.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/17/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "PathDataService.h"
#import "APIService.h"
#import "Path.h"
#import "AppDelegate.h"
#import "Reachability.h"

@implementation PathDataService

- (void)getTravelOptionsForTravelMode:(TravelMode)travelMode Success:(DataSuccessBlock)success failure:(DataFailureBlock)failure {
    
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        [self getServerTravelOptionsForTravelMode:travelMode Success:success failure:failure];
    }
    else {
        [self getOfflineTravelOptionsForTravelMode:travelMode Success:success failure:failure];
    }
}

- (void)getServerTravelOptionsForTravelMode:(TravelMode)travelMode Success:(DataSuccessBlock)success failure:(DataFailureBlock)failure {
    
    APIService *apiService = [[APIService alloc] init];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [apiService getTravelOptionsForTravelMode:travelMode :^(id result) {
        
        NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in result) {
            Path *tempPath = [Path pathWithParsedDictionary:dict travelMode:travelMode inManagedObjectContext:app.managedObjectContext];
            [resultsArray addObject:tempPath];
        }
        [app saveContext];
        
        success (resultsArray);
        
    } failure:^(NSString *errorMsg) {
        
        failure(errorMsg);
        
    }];
    
}

- (void)getOfflineTravelOptionsForTravelMode:(TravelMode)travelMode Success:(DataSuccessBlock)success failure:(DataFailureBlock)failure {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Path" inManagedObjectContext:app.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"travelMode = %@", [Path getTravelModeString:travelMode]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [app.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        failure(error.localizedDescription);
    }
    
    success(fetchedObjects);
}


@end


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

@implementation PathDataService

- (void)getTravelOptionsForTravelMode:(TravelMode)travelMode Success:(DataSuccessBlock)success failure:(DataFailureBlock)failure {
    
    APIService *apiService = [[APIService alloc] init];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [apiService getTravelOptionsForTravelMode:travelMode :^(id result) {
        
        NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in result) {
            Path* tempPath = [NSEntityDescription insertNewObjectForEntityForName:@"Path"
                                                           inManagedObjectContext:app.managedObjectContext];
            [tempPath initWithDict:dict andTravelMode:travelMode];
            [resultsArray addObject:tempPath];
        }
        
        success (resultsArray);
    
    } failure:^(NSString *errorMsg) {
        
        failure(errorMsg);
        
    }];
}


@end


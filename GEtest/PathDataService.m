//
//  PathDataService.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/17/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "PathDataService.h"
#import "APIService.h"

@implementation PathDataService

- (void)getTravelOptionsForTravelMode:(TravelMode)travelMode Success:(DataSuccessBlock)success failure:(DataFailureBlock)failure {
    
    APIService *apiService = [[APIService alloc] init];
    
    [apiService getTravelOptionsForTravelMode:travelMode :^(id result) {
        
        success (result);
    } failure:^(NSString *errorMsg) {
        
        failure(errorMsg);
        
    }];
}


@end


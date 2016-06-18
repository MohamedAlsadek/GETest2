//
//  PathDataService.h
//  GEtest
//
//  Created by Mohamed Alsadek on 6/17/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "APIParams.h"



#pragma mark - End blocks
typedef void(^DataFailureBlock)(NSString *errorMsg);
typedef void(^DataFailureBlockWithError)(NSError *error);
typedef void(^DataSuccessBlock)(id result);


@interface PathDataService : NSObject

// This method get travel mode pathes from server/offline
- (void)getTravelOptionsForTravelMode:(TravelMode)travelMode Success:(DataSuccessBlock)success failure:(DataFailureBlock)failure;

@end

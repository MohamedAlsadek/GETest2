//
//  APIService.h
//  GEtest
//
//  Created by Mohamed Alsadek on 6/17/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpSessionManager.h"
#import "APIParams.h"

@interface APIService : NSObject

- (void)getTravelOptionsForTravelMode:(TravelMode)travelMode :(APISuccessBlock)success failure:(APIFailureBlockWithErrorMessage)failure;

@end

//
//  APIService.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/17/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "APIService.h"
#import "HttpSessionManager.h"
#import "APIParams.h"

@interface APIService ()

@property (nonatomic, strong) HttpSessionManager *sessionManager;

@end

@implementation APIService

#pragma mark - INIT

- (instancetype)init {
    self  = [super init];
    
    if (self) {
        _sessionManager = [HttpSessionManager sharedHTTPSessionManagerWithBaseUrl:kBaseURL];
    }
    return self;
}

#pragma General Method
- (void)getTravelOptionsForTravelMode:(TravelMode)travelMode :(APISuccessBlock)success failure:(APIFailureBlockWithErrorMessage)failure {
    
    NSString *resourcePath;
    
    switch (travelMode) {
            
        case TravelModeFlight:
            resourcePath = kURLFlight;
            break;
            
        case TravelModeTrain:
            resourcePath = kURLTrain;
            break;
            
        case TravelModeBus:
            resourcePath = kURLBus;
            break;
            
        default:
            break;
    }
    
    [self.sessionManager getDataFromResource:resourcePath parameters:nil success:success failure:failure];
}

@end

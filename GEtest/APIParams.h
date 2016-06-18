//
//  APIParams.h
//  GEtest
//
//  Created by Mohamed Alsadek on 6/17/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#ifndef APIParams_h
#define APIParams_h

#pragma mark - Filter Types
typedef NS_ENUM(NSUInteger, TravelMode) {
    TravelModeFlight,
    TravelModeTrain,
    TravelModeBus
};

#pragma mark - Path Sorting Types
typedef NS_ENUM(NSUInteger, PathSorting) {
    PathSortingDepartureTime,
    PathSortingArrivalTime,
    PathSortingDuration
};


#pragma mark - URL pathes
static NSString* const kBaseURL             = @"https://api.myjson.com/bins";
static NSString* const kURLFlight           = @"/w60i";
static NSString* const kURLTrain            = @"/3zmcy";
static NSString* const kURLBus              = @"/37yzm";

#pragma mark - TravelModes
static NSString* const kTravelModeFlight    = @"flight";
static NSString* const kTravelModeTrain     = @"train";
static NSString* const kTravelModeBus       = @"bus";

#pragma mark - Error Handling
static const NSInteger KBadRequestError   = 400;
static const NSInteger KUnauthorizedError = 401;
static const NSInteger KForbiddenError    = 403;
static const NSInteger KNoUpdatesError    = 304;

static NSString * const kGEHttpSessionManagerErrorDomain  = @"GEErrorDomain";
static NSString * const kGEHttpSessionManagerErrorMessage = @"GEErrorMessage";

#endif /* APIParams_h */

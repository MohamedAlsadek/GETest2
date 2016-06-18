//
//  PathListViewModel.h
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Path.h"
#import "APIParams.h"

@interface PathListViewModel : NSObject


@property (nonatomic, readonly) NSArray *allPathes;

- (instancetype)initWithTravelMode:(TravelMode)travelMode delegate:(id)delegate;

// Fetching data 
- (void)fetchDataForTravelMode:(TravelMode)travelMode sortingType:(PathSorting)pathSorting;
- (void)fetchDataForTravelMode:(TravelMode)travelMode; 


@end

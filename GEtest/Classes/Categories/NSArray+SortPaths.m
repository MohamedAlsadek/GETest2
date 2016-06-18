//
//  NSArray+SortPaths.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "NSArray+SortPaths.h"

@implementation NSArray (SortPaths)

// sort search pathes according to search criteria
+ (NSArray *)sortPathes:(NSArray *)pathes :(PathSorting)sortingType {
    
    
    NSArray *sortedArray;
    sortedArray = [pathes sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        
        Path *firstObj = (Path *)a;
        Path *secondObj = (Path *)b;
        
        // parameters used for comparing objects
        id firstParam;
        id secondParam;
        
        switch (sortingType) {
            case PathSortingArrivalTime:{
                firstParam = firstObj.arrivalTime;
                secondParam = secondObj.arrivalTime;
                
            }
                break;
                
            case PathSortingDepartureTime:{
                firstParam = firstObj.departureTime;
                secondParam = secondObj.departureTime;
            }
                break;
                
            case PathSortingDuration:{
                firstParam = [Path calculatePathDuration:firstObj];
                secondParam = [Path calculatePathDuration:secondObj];
            }
                break;
                
            default:
                break;
        }
        
        return [firstParam compare:secondParam];
    }];
    
    
    return sortedArray;
}

@end

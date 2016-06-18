//
//  NSArray+SortPaths.h
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Path.h"

@interface NSArray (SortPaths)

// sort search pathes according to search criteria
+ (NSArray *)sortPathes:(NSArray *)pathes :(PathSorting)sortingType;

@end

//
//  NSString+Formatter.h
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Formatter)

// Format NSTimeInterval to hh:mm
- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval;

@end

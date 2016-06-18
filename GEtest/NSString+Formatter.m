//
//  NSString+Formatter.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "NSString+Formatter.h"

@implementation NSString (Formatter)


- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {

    NSInteger ti = (NSInteger)interval;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)hours, (long)minutes];
}

@end

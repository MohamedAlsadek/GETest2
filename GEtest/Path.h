//
//  Path.h
//  
//
//  Created by Mohamed Alsadek on 6/17/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "APIParams.h"

NS_ASSUME_NONNULL_BEGIN

@interface Path : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (void)initWithDict:(NSDictionary *)dict andTravelMode:(TravelMode)travelMoe;

@end

NS_ASSUME_NONNULL_END

#import "Path+CoreDataProperties.h"

//
//  Path+CoreDataProperties.h
//  
//
//  Created by Mohamed Alsadek on 6/17/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Path.h"

NS_ASSUME_NONNULL_BEGIN

@interface Path (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *pathId;
@property (nullable, nonatomic, retain) NSString *providerLogo;
@property (nullable, nonatomic, retain) NSNumber *priceInEuros;
@property (nullable, nonatomic, retain) NSString *departureTime;
@property (nullable, nonatomic, retain) NSString *arrivalTime;
@property (nullable, nonatomic, retain) NSNumber *numberOfStops;
@property (nullable, nonatomic, retain) NSString *travelMode;

@end

NS_ASSUME_NONNULL_END

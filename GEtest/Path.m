//
//  Path.m
//  
//
//  Created by Mohamed Alsadek on 6/17/16.
//
//

#import "Path.h"

static NSString* const kPathId              = @"id";
static NSString* const kPathPriceInEuro    = @"price_in_euros";
static NSString* const kPathProviderLogo    = @"provider_logo";
static NSString* const kPathDepartureTime   = @"departure_time";
static NSString* const kPathArrivalTime     = @"arrival_time";
static NSString* const kPathNumberOfStops   = @"number_of_stops";

@implementation Path

// Insert code here to add functionality to your managed object subclass
- (void)initWithDict:(NSDictionary *)dict andTravelMode:(TravelMode)travelMoe {
    
    if ([dict valueForKey:kPathId]) {
        self.pathId = [dict valueForKey:kPathId];
    }
    if ([dict valueForKey:kPathProviderLogo]) {
        self.providerLogo = [[dict valueForKey:kPathProviderLogo] stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
    }
    if ([dict valueForKey:kPathPriceInEuro]) {
        self.priceInEuros = [NSNumber numberWithDouble:[[dict valueForKey:kPathPriceInEuro] doubleValue]];
    }
    if ([dict valueForKey:kPathDepartureTime]) {
        self.departureTime = [dict valueForKey:kPathDepartureTime];
    }
    if ([dict valueForKey:kPathArrivalTime]) {
        self.arrivalTime = [dict valueForKey:kPathArrivalTime];
    }
    if ([dict valueForKey:kPathNumberOfStops]) {
        self.numberOfStops = [dict valueForKey:kPathNumberOfStops];
    }
    
    self.travelMode = [Path getTravelModeString:travelMoe];
}

#pragma mark - Helper Methods
// only insert new unique items (id)
+ (Path *)pathWithParsedDictionary:(NSDictionary *)parsedItem travelMode:(TravelMode)travelMode inManagedObjectContext:(NSManagedObjectContext *)context {
    
    Path *path;
    if (parsedItem) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Path"];
        request.predicate = [NSPredicate predicateWithFormat:@"pathId = %@", parsedItem[@"id"]];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || [matches count] > 1) {
            NSLog(@"Multiple copies of unique item detected in the document");
        } else if (![matches count]){
            path = [NSEntityDescription insertNewObjectForEntityForName:@"Path"
                                                 inManagedObjectContext:context];
            
            [path initWithDict:parsedItem andTravelMode:travelMode];
        } else {
            path = [matches lastObject];
        }
    }
    return path;
}

// map TravelMode Enum to string value
+ (NSString *)getTravelModeString:(TravelMode)travelMode {
    
    switch (travelMode) {
        case TravelModeFlight:
            return kTravelModeFlight;
            break;
            
        case TravelModeTrain:
            return kTravelModeTrain;
            break;
            
        case TravelModeBus:
            return kTravelModeBus;
            break;
            
        default:
            break;
    }
}

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
                secondParam = [Path calculatePathDuration:firstObj];
            }
                break;
                
            default:
                break;
        }
        
        return [firstParam compare:secondParam];
    }];
    
    
    return sortedArray;
}

// get path duration by (arrivalTime - departureTime)
+ (NSNumber *)calculatePathDuration:(Path *)path {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSDate *date1 = [dateFormatter dateFromString:path.departureTime];
    NSDate *date2 = [dateFormatter dateFromString:path.arrivalTime];
    
    NSTimeInterval timeInterval = [date2 timeIntervalSinceDate:date1];
    return [NSNumber numberWithInteger:timeInterval];;
}
@end

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
        self.providerLogo = [dict valueForKey:kPathProviderLogo];
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
    
    self.travelMode = [self getTravelModeString:travelMoe];
}

- (NSString *)getTravelModeString:(TravelMode)travelMode {
    
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


@end

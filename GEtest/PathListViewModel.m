//
//  PathListViewModel.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "PathListViewModel.h"
#import "PathDataService.h"
#import "ViewModelUpdateUIDelegate.h"
#import "NSArray+SortPaths.h"

@interface PathListViewModel ()

@property (nonatomic, strong) NSArray *allPathes;
@property (nonatomic, strong) id <ViewModelUpdateUIDelegate>updateUiDelegate;
@property (strong, nonatomic) PathDataService *pathDataService;

@end

@implementation PathListViewModel


#pragma mark - CustomInit

- (instancetype)initWithTravelMode:(TravelMode)travelMode delegate:(id)delegate {
    self = [super init];
    if (self) {
        _updateUiDelegate = delegate;
        _pathDataService = [[PathDataService alloc] init];
    }
    return self;
}

#pragma mark - fetching data
- (void)fetchDataForTravelMode:(TravelMode)travelMode {
   
    [self.pathDataService getTravelOptionsForTravelMode:travelMode Success:^(id result) {
        
        self.allPathes = (NSArray *) result;
        
    } failure:^(NSString *errorMsg) {
        
        NSLog(@"Failure");
        
    }];
}


- (void)fetchDataForTravelMode:(TravelMode)travelMode sortingType:(PathSorting)pathSorting {
    
    [self.pathDataService getTravelOptionsForTravelMode:travelMode Success:^(id result) {
        
        NSArray *tempResult = (NSArray *)result;
        self.allPathes = [NSArray sortPathes:tempResult :pathSorting];
        
    } failure:^(NSString *errorMsg) {
        
        NSLog(@"Failure");
        
    }];
    
}

#pragma mark - Setters
- (void)setAllPathes:(NSArray *)allPathes {
    _allPathes = allPathes;
    [self callUpdateUiDelegate];
}

#pragma mark - Update UI
- (void)callUpdateUiDelegate {
    if (self.updateUiDelegate && [self.updateUiDelegate respondsToSelector:@selector(updateUI)]) {
        [self.updateUiDelegate updateUI];
    }
}


@end

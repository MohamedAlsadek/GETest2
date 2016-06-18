//
//  PagerViewController.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "PagerViewController.h"
#import "PathListViewController.h"
#import "ViewModelUpdateUIDelegate.h"
#import "Path.h"

static NSString* const kScreenTitle = @"Berlin - Munich";

@interface PagerViewController () <ViewModelUpdateUIDelegate>

@end

@implementation PagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = kScreenTitle;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)updateUI    {
    // do something when updating UI
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private Helpers

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    PathListViewController *contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:kPathListViewConroller];
    contentViewController.travelMode = index;
    contentViewController.title = [[Path getTravelModeString:index] capitalizedString];
    
    return contentViewController;
}

#pragma mark - Second Level navigation
- (NSMutableArray *)getViewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    [viewControllers addObject:[self viewControllerAtIndex:TravelModeTrain]];
    [viewControllers addObject:[self viewControllerAtIndex:TravelModeBus]];
    [viewControllers addObject:[self viewControllerAtIndex:TravelModeFlight]];
    
    return viewControllers ;
}

#pragma mark - CAPSPageMenuDelegate
- (void)willMoveToPage:(UIViewController *)controller index:(NSInteger)index {
    
}

- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index {
    
}

@end

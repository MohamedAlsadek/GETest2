//
//  AbstractPagerViewController.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "AbstractPagerViewController.h"
#import "Contants.h"

@interface AbstractPagerViewController ()

@end

@implementation AbstractPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupPageMenu];
}

#pragma mark - Second Level navigation
- (void)setupPageMenu {
    
    NSMutableArray *viewControllers = [self getViewControllers] ;
    NSMutableDictionary *parameters = [self pagerParameters] ;
    
    if (viewControllers.count <= 3) {
        parameters[CAPSPageMenuOptionUseMenuLikeSegmentedControl] = @(YES);
    }
    
    _pageMenu = [[CAPSPageMenu alloc]
                 initWithViewControllers:viewControllers
                 frame:self.view.bounds
                 options:[parameters copy]];    
    _pageMenu.delegate = self ;
    
    [self addChildViewController:self.pageMenu];
    [self.view addSubview:self.pageMenu.view];
}

- (NSMutableDictionary *)pagerParameters {
    NSMutableDictionary *parameters = [@{CAPSPageMenuOptionMenuHeight: @(40.),
                                         CAPSPageMenuOptionSelectionIndicatorHeight: @(4.),
                                         CAPSPageMenuOptionMenuMargin:@(0),
                                         CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(YES),
                                         
                                         // title colors
                                         CAPSPageMenuOptionSelectedMenuItemLabelColor: [UIColor whiteColor],
                                         CAPSPageMenuOptionUnselectedMenuItemLabelColor: [UIColor whiteColor],
                                         
                                         // menu background color
                                         CAPSPageMenuOptionScrollMenuBackgroundColor: kAppBlueColor,
                                         
                                         // title fonts
                                         CAPSPageMenuOptionMenuItemFont: [UIFont systemFontOfSize:16.0],
                                         
                                         // bottom line and selector colors
                                         CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor clearColor],
                                         CAPSPageMenuOptionSelectionIndicatorColor: kAppOrangeColor,

                                         // main view background color
                                         CAPSPageMenuOptionViewBackgroundColor: [UIColor whiteColor]} mutableCopy];
    
    return parameters ;
}

- (NSMutableArray *)getViewControllers {
    return [[NSMutableArray alloc] init] ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

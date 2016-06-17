//
//  ViewController.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/17/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "ViewController.h"
#import "PathDataService.h"
#import "APIParams.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PathDataService *dataService = [[PathDataService alloc] init];
    
    [dataService getTravelOptionsForTravelMode:TravelModeFlight Success:^(id result) {
        NSLog(@"%@", result);
    } failure:^(NSString *errorMsg) {
        NSLog(@"%@" , errorMsg);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

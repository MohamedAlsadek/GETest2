//
//  AbstractNavigationController.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "AbstractNavigationController.h"
#import "Contants.h"

@interface AbstractNavigationController ()

@end

@implementation AbstractNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Hide bottom shadow of the navigation bar
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    
    self.navigationBarHidden = NO;
    self.navigationBar.barTintColor = kAppBlueColor;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    
    
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName : [UIColor whiteColor],
                                               NSFontAttributeName : [UIFont systemFontOfSize:14]
                                               };
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

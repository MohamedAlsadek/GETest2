//
//  AbstractPagerViewController.h
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAPSPageMenu.h"
#import "Contants.h"

@interface AbstractPagerViewController : UIViewController <CAPSPageMenuDelegate>

@property (strong, nonatomic) CAPSPageMenu *pageMenu;

- (NSMutableArray *)getViewControllers ;

@end

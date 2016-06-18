//
//  PathListTableViewCell.h
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Path.h"

@interface PathListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelCost;
@property (weak, nonatomic) IBOutlet UILabel *labelDuration;
@property (weak, nonatomic) IBOutlet UILabel *labelStartEndTime;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLogo;

- (void)initCellWithPath:(Path *)path;

@end

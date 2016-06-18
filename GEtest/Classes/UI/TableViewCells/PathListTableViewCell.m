//
//  PathListTableViewCell.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "PathListTableViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "NSString+Formatter.h"

@implementation PathListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)initCellWithPath:(Path *)path {
    [self setLabelStartEndTimeWithObject:path];
    [self setDurationLabelWithObject:path];
    [self setPriceLabelWithObject:path];
    [self setLogoWithObject:path];
}

- (void)setLabelStartEndTimeWithObject:(Path *)path {
    
    int departure = [self getHourValueFromStringFormat:path.departureTime];
    int arrival = [self getHourValueFromStringFormat:path.arrivalTime];
    
    if (arrival < departure) {
        self.labelStartEndTime.text = [NSString stringWithFormat:@"%@ - %@ (+1)", path.departureTime, path.arrivalTime];
    }else {
        self.labelStartEndTime.text = [NSString stringWithFormat:@"%@ - %@", path.departureTime, path.arrivalTime];
    }
}

// hh:mm
- (int)getHourValueFromStringFormat:(NSString *)format {
    NSArray *components = [format componentsSeparatedByString:@":"];
    if (components.count == 2) { // it means the string is valid
        return [components.firstObject intValue];
    }
    
    return -1;
}

- (void)setDurationLabelWithObject:(Path *)path {
    
    NSNumber *pathDuration = [Path calculatePathDuration:path];
    NSString *formattedDuration = [NSString stringWithFormat:@"%@ h", [NSString stringFromTimeInterval:pathDuration.floatValue]];
    if (path.numberOfStops.intValue == 0) {
        self.labelDuration.text = [NSString stringWithFormat:@"Direct %@" , formattedDuration];
    }else {
        self.labelDuration.text = [NSString stringWithFormat:@"(%@ stops) %@" , path.numberOfStops, formattedDuration];
    }
}

- (void)setPriceLabelWithObject:(Path *)path {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencyCode:@"EUR"];
    NSString *formattedCurrency = [numberFormatter stringFromNumber:path.priceInEuros];
    self.labelCost.text = formattedCurrency;
}

- (void)setLogoWithObject:(Path *)path {
    
    NSURL *imageURL = [NSURL URLWithString:path.providerLogo] ;
    if (imageURL) {
        [self.imageViewLogo setImageWithURL:imageURL placeholderImage:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] ;
    }
}

@end

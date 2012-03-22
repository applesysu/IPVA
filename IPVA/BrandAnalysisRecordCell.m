//
//  BrandAnalysisRecordCell.m
//  IpvaSheet
//
//  Created by Henry Tse on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BrandAnalysisRecordCell.h"

@implementation BrandAnalysisRecordCell

@synthesize rankNumber, brandName, storeCount, consumerCount, salesCount, avgConsumerCount, avgSalesCount;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

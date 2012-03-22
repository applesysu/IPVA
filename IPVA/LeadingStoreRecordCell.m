//
//  LeadingStoreRecordCell.m
//  IpvaSheet
//
//  Created by Henry Tse on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LeadingStoreRecordCell.h"

@implementation LeadingStoreRecordCell

@synthesize rankNumber, squareName, consumerCount, salesCount;

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

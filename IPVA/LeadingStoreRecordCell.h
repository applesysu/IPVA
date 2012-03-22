//
//  LeadingStoreRecordCell.h
//  IpvaSheet
//
//  Created by Henry Tse on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeadingStoreRecordCell : UITableViewCell
{
    UILabel *rankNumber, *squareName, *consumerConunt, *salesCount;
}

@property (nonatomic, retain) IBOutlet UILabel *rankNumber;
@property (nonatomic, retain) IBOutlet UILabel *squareName;
@property (nonatomic, retain) IBOutlet UILabel *consumerCount;
@property (nonatomic, retain) IBOutlet UILabel *salesCount;

@end

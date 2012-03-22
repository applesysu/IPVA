//
//  BrandAnalysisDetailRecordCell.h
//  IpvaSheet
//
//  Created by Henry Tse on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandAnalysisDetailRecordCell : UITableViewCell
{
    UILabel *rankNumber, *squareName, *storeNumber, *consumerCount, *salesCount;
}

@property (nonatomic, retain) IBOutlet UILabel *rankNumber;
@property (nonatomic, retain) IBOutlet UILabel *squareName;
@property (nonatomic, retain) IBOutlet UILabel *storeNumber;
@property (nonatomic, retain) IBOutlet UILabel *consumerCount;
@property (nonatomic, retain) IBOutlet UILabel *salesCount;

@end

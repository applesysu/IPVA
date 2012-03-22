//
//  BrandAnalysisRecordCell.h
//  IpvaSheet
//
//  Created by Henry Tse on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandAnalysisRecordCell : UITableViewCell
{
    UILabel *rankNumber, *brandName, *storeCount, *consumerCount, *salesCount, *avgConsumerCount, *avgSalesCount;
}

@property (nonatomic, retain) IBOutlet UILabel *rankNumber;
@property (nonatomic, retain) IBOutlet UILabel *brandName;
@property (nonatomic, retain) IBOutlet UILabel *storeCount;
@property (nonatomic, retain) IBOutlet UILabel *consumerCount;
@property (nonatomic, retain) IBOutlet UILabel *salesCount;
@property (nonatomic, retain) IBOutlet UILabel *avgConsumerCount;
@property (nonatomic, retain) IBOutlet UILabel *avgSalesCount;

@end

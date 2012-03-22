//
//  BrandAnalysisTitle.h
//  IpvaSheet
//
//  Created by again on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandAnalysisTitle : UIView
{
    UIButton *rankButton, *brandButton, *storeButton, *consumerCountButton, *salesCountButton, *avgConsumerButton, *avgSalesButton;
}

@property (nonatomic, retain) IBOutlet UIButton *rankButton;
@property (nonatomic, retain) IBOutlet UIButton *brandButton;
@property (nonatomic, retain) IBOutlet UIButton *storeButton;
@property (nonatomic, retain) IBOutlet UIButton *consumerCountButton;
@property (nonatomic, retain) IBOutlet UIButton *salesCountButton;
@property (nonatomic, retain) IBOutlet UIButton *avgConsumerButton;
@property (nonatomic, retain) IBOutlet UIButton *avgSalesButton;

@end

//
//  BrandAnalysisDetailTitle.h
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandAnalysisDetailTitle : UIView
{
    UIButton *rankButton, *sqaureButton, *storeButton, *consumerCountButton, *salesCountButton;
}

@property (nonatomic, retain) IBOutlet UIButton *rankButton;
@property (nonatomic, retain) IBOutlet UIButton *squareButton;
@property (nonatomic, retain) IBOutlet UIButton *storeButton;
@property (nonatomic, retain) IBOutlet UIButton *consumerCountButton;
@property (nonatomic, retain) IBOutlet UIButton *salesCountButton;

@end

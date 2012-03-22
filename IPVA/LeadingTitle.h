//
//  LeadingTitle.h
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeadingTitle : UIView
{
    UIButton *rankButton, *squareButton, *consumerCountButton, *salesCountButton;
}

@property (nonatomic, retain) IBOutlet UIButton *rankButton;
@property (nonatomic, retain) IBOutlet UIButton *squareButton;
@property (nonatomic, retain) IBOutlet UIButton *consumerCountButton;
@property (nonatomic, retain) IBOutlet UIButton *salesCountButton;

@end

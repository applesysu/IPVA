//
//  FirstViewController.h
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIPopoverControllerDelegate>

@property (nonatomic, retain) UIPopoverController *aeraPickPopover;

- (IBAction)pressAeraButton:(id)sender;

@end

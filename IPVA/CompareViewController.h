//
//  CompareViewController.h
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYCompareGraph.h"
#import "TKCalendarMonthView.h"


@interface CompareViewController : UIViewController <UIPopoverControllerDelegate, TKCalendarMonthViewDelegate>

@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;
@property (retain, nonatomic) IBOutlet UIView *compareView;


@property (retain, nonatomic) IBOutlet UILabel *squareALabel;
@property (retain, nonatomic) IBOutlet UILabel *squareBLabel;

@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *squareButton;

- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

- (IBAction)pressSquareButton:(id)sender;
@end

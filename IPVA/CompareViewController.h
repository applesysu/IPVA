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
//popoverControllers
@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

//the compare graph outlet
@property (retain, nonatomic) IBOutlet UIView *compareView;

@property (nonatomic, retain) IBOutlet UILabel *toolBarTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *pageTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

//use for calculate the date
@property (nonatomic, retain) IBOutlet UISegmentedControl *cycleSelection;
@property (nonatomic, retain) NSDate *selectedDate;

//selected square label
@property (retain, nonatomic) IBOutlet UILabel *squareALabel;
@property (retain, nonatomic) IBOutlet UILabel *squareBLabel;

//button for different squares
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *squareButton;

//toolbar item methods
- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;
- (IBAction)pressSquareButton:(id)sender;

//time display methods
-(void) presentCycleDay;
-(void) presentCycleWeek;
-(void) presentCycleMonth;

@end

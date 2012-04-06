//
//  FirstViewController.h
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"

@interface FirstViewController : UIViewController <UIPopoverControllerDelegate, TKCalendarMonthViewDelegate>

//view labels for display the overview of the company
@property (nonatomic, retain) IBOutlet UILabel *squareNumber;
@property (nonatomic, retain) IBOutlet UILabel *consumers;
@property (nonatomic, retain) IBOutlet UILabel *sales;
@property (nonatomic, retain) IBOutlet UILabel *date;

//for selecting the date cycle type
@property (nonatomic, retain) IBOutlet UISegmentedControl *cycleSelection;
@property (nonatomic, retain) NSDate *selectedDate;

//popover controllers
@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

//toolbar items methods
- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

//time display methods
-(void) presentCycleDay;
-(void) presentCycleWeek;
-(void) presentCycleMonth;

@end

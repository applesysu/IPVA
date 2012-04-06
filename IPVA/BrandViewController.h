//
//  BrandAnalysis.h
//  IpvaSheet
//
//  Created by again on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"

@class BrandSheetView;

@interface BrandViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate,TKCalendarMonthViewDelegate>

@property (nonatomic, retain) NSArray *data;

//datas for create the graph
@property (nonatomic, retain) UITableView *rightTableView;
@property (nonatomic, retain) NSArray *titleArray;
@property (nonatomic, retain) NSArray *propertyNames;
@property (nonatomic, retain) UIView *titleRowView;

//popover controller
@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

//the labels in the view
@property (nonatomic, retain) IBOutlet UILabel *pageTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

//the selection of the date cycle type
@property (nonatomic, retain) IBOutlet UISegmentedControl *cycleSelection;
@property (nonatomic, retain) NSDate *selectedDate;

//toolbar items methods
- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

// date cycle type selection
-(void) presentCycleDay;
-(void) presentCycleWeek;
-(void) presentCycleMonth;

-(void) initWithData;
-(void) buttonClick:(id) sender;

@end

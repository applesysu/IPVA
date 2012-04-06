//
//  LeadingStore.h
//  IpvaSheet
//
//  Created by Henry Tse on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreSheetView;

@interface StoreViewController : UIViewController <UIPopoverControllerDelegate>

@property (nonatomic, retain) NSArray *data;

//the sheet for the plot in the view
@property (nonatomic, retain) StoreSheetView *sheetView;

//popover controller
@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

//the labels in the view
@property (nonatomic, retain) IBOutlet UILabel *toolBarTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *pageTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

//the selection of the date cycle type 
@property (nonatomic, retain) IBOutlet UISegmentedControl *cycleSelection;
@property (nonatomic, retain) NSDate *selectedDate;

//toolbar items methods
- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

//date cycle type methods
-(void) presentCycleDay;
-(void) presentCycleWeek;
-(void) presentCycleMonth;

//method for generate the data using to the graph
-(void) initWithData;

@end

//
//  Consumer+SalesTrend.h
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "TKCalendarMonthView.h"

@class SheetView;


@interface TrendViewController : UIViewController <CPTPlotDataSource, UIPopoverControllerDelegate,TKCalendarMonthViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataForChart;
@property (nonatomic, retain) NSMutableArray *dataForPlot;

//the three sheet for different cycle type
@property (nonatomic, retain) SheetView *daySheet;
@property (nonatomic, retain) SheetView *weekSheet;
@property (nonatomic, retain) SheetView *yearSheet;

//garph layer for the scatter plot
@property (nonatomic, retain) CPTGraphHostingView *scatterPlotView;
@property (nonatomic, retain) CPTXYGraph *graph;

//the data use for generate the graph
@property (nonatomic, retain) NSMutableDictionary *dataFromCompanyDatabase;

//the selection segmentControl in the view
@property (nonatomic, retain) IBOutlet UISegmentedControl *categorySelection;
@property (nonatomic, retain) IBOutlet UISegmentedControl *timeSelection;

//configure the date cycle type
@property (nonatomic, retain) IBOutlet UISegmentedControl *cycleSelection;
@property (nonatomic, retain) NSDate *selectedDate;

//popover controllers
@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

//display labels in the view
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *pageTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *toolBarTitleLabel;

//toolbar items methods
- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

// date cycle type selection
-(void) presentCycleDay;
-(void) presentCycleWeek;
-(void) presentCycleMonth;

// generate the plot 
-(void) constructMonthScatterPlot;

@end

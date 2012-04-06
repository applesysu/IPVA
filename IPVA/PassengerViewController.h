//
//  ConsumerDistribution.h
//  IpvaSheet
//
//  Created by again on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "TKCalendarMonthView.h"

@class SheetView;

@interface PassengerViewController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate, UIPopoverControllerDelegate,TKCalendarMonthViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataForPlot;
@property (nonatomic, retain) NSMutableArray *dataForChart;

//configure the hosting view of the graph
@property (nonatomic, retain) CPTGraphHostingView *barChartView;
@property (nonatomic, retain) CPTXYGraph *barChartForConsumer, *barChartForSales;

//the data using to generating the graph
@property (nonatomic, retain) NSMutableDictionary *dataFromCompanyDatabase;

//selection of the category
@property (nonatomic, retain) IBOutlet UISegmentedControl *categorySelection;
@property (nonatomic, retain) SheetView *sheetView;

//the labels of the view
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *toolBarTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *pageTitleLabel;

//configure the selection the date cycle type
@property (nonatomic, retain) IBOutlet UISegmentedControl *cycleSelection;
@property (nonatomic, retain) NSDate *selectedDate;

//popover controllers
@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

//toolbar item methods
- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

// generating the graph of the page
-(void) constructConsumerBarChart;
-(void) constructSalesBarChart;

//date type display methods
-(void) presentCycleDay;
-(void) presentCycleWeek;
-(void) presentCycleMonth;

@end

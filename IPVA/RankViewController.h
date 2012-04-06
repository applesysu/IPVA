//
//  StoreRanking.h
//  IpvaSheet
//
//  Created by again on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "TKCalendarMonthView.h"

@class RankSheetView;

@interface RankViewController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate,UIPopoverControllerDelegate, TKCalendarMonthViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataForPlot;
@property (nonatomic, retain) NSMutableArray *dataForChart;

//the hosting layer of the graph
@property (nonatomic, retain) CPTGraphHostingView *barChartView;
@property (nonatomic, retain) CPTGraph *barChartForTop, *barChartForButtom;

//sheets for different ranking
@property (nonatomic, retain) RankSheetView *topTen;
@property (nonatomic, retain) RankSheetView *buttomTen;

//the selection of the ranking top ten or buttom ten
@property (nonatomic, retain) IBOutlet UISegmentedControl *topTenOrButtomTen;

//the data for genrating the graph
@property (nonatomic, retain) NSMutableArray *dataForGraph1, *dataForGraph2;

//the labels in the view
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *toolBarTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *pageTitleLabel;

//the selection of the date cycle type
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

//calculate the date cycle methods
-(void) presentCycleDay;
-(void) presentCycleWeek;
-(void) presentCycleMonth;

//generate the graphs
-(void) constructTopBarChart;
-(void) constructButtomBarChart;


@end

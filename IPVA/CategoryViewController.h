//
//  CategoryViewController.h
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface CategoryViewController : UIViewController <UIPopoverControllerDelegate, CPTScatterPlotDataSource, CPTScatterPlotDelegate>

@property (nonatomic, retain) NSMutableArray *dataForPlot, *dataForChart;

//the data use to configure the plot
@property (nonatomic, retain) NSMutableDictionary *dataFromCompanyDatabase;

//graph layer for the scatter plot
@property (nonatomic, retain) CPTGraph *graph;
@property (nonatomic, retain) CPTGraphHostingView *scatterPlotView;

//popoverControllers
@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

//display labels
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *pageTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *toolBarTitleLabel;

//date calculate 
@property (nonatomic, retain) IBOutlet UISegmentedControl *cycleSelection;
@property (nonatomic, retain) NSDate *selectedDate;

//the selected category buttons
@property (nonatomic, retain) IBOutlet UIButton *consumer, *sales, *effect, *collectConsumer, *convertRate, *bags;
@property (nonatomic, retain) NSMutableArray *selectedButton, *selectedTag;
@property (nonatomic, assign) int indexs;

//toolbar item methods
- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

//time display methods
-(void) presentCycleDay;
-(void) presentCycleWeek;
-(void) presentCycleMonth;

//scatter plot generating method
-(void) constructScatterPlot: (NSMutableArray *) selected;

@end

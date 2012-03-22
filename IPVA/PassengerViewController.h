//
//  ConsumerDistribution.h
//  IpvaSheet
//
//  Created by again on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@class SheetView;

@interface PassengerViewController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate, UIPopoverControllerDelegate>
{
    CPTGraphHostingView *barChartView;
    NSMutableArray *dataForPlot, *dataForChart;
    CPTXYGraph *barChartForConsumer, *barChartForSales;
    
    UISegmentedControl *categorySelection, *plotOrSheetSelection;
    
    SheetView *sheetView;
}

@property (nonatomic, retain) CPTGraphHostingView *barChartView;
@property (nonatomic, retain) CPTXYGraph *barChartForConsumer, *barChartForSales;
@property (nonatomic, retain) NSMutableArray *dataForPlot;
@property (nonatomic, retain) NSMutableArray *dataForChart;
@property (nonatomic, retain) IBOutlet UISegmentedControl *categorySelection;
@property (nonatomic, retain) SheetView *sheetView;

@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

-(void) constructConsumerBarChart;
-(void) constructSalesBarChart;

@end

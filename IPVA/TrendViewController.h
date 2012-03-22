//
//  Consumer+SalesTrend.h
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@class SheetView;


@interface TrendViewController : UIViewController <CPTPlotDataSource, UIPopoverControllerDelegate>
{
    SheetView *daySheet;
    SheetView *weekSheet;
    SheetView *yearSheet;
    CPTGraphHostingView *scatterPlotView;
    CPTXYGraph *graph;
    NSMutableArray *dataForChart, *dataForPlot;
    
    UISegmentedControl *categorySelection, *timeSelection;
}

@property (nonatomic, retain) SheetView *daySheet;
@property (nonatomic, retain) SheetView *weekSheet;
@property (nonatomic, retain) SheetView *yearSheet;
@property (nonatomic, retain) CPTGraphHostingView *scatterPlotView;
@property (nonatomic, retain) CPTXYGraph *graph;
@property (nonatomic, retain) NSMutableArray *dataForChart;
@property (nonatomic, retain) NSMutableArray *dataForPlot;
@property (nonatomic, retain) IBOutlet UISegmentedControl *categorySelection;
@property (nonatomic, retain) IBOutlet UISegmentedControl *timeSelection;

@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

-(void) constructScatterPlot;

@end

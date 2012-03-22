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
{
    NSMutableArray *dataForPlot, *dataForChart;
    CPTGraphHostingView *scatterPlotView;
    CPTGraph *graph;
    
}

@property (nonatomic, retain) NSMutableArray *dataForPlot, *dataForChart;
@property (nonatomic, retain) CPTGraph *graph;
@property (nonatomic, retain) CPTGraphHostingView *scatterPlotView;

@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

@end

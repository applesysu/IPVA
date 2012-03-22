//
//  StoreRanking.h
//  IpvaSheet
//
//  Created by again on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@class SheetView;

@interface RankViewController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate,UIPopoverControllerDelegate>
{
    CPTGraphHostingView *barChartView;
    CPTXYGraph *barChartForTop, *barChartForButtom;
    NSMutableArray *dataForPlot, *dataForChart;
    
    UISegmentedControl *categorySelection, *topTenOrButtomTen;
    
    SheetView *topTen;
    SheetView *buttomTen;
}

@property (nonatomic, retain) CPTGraphHostingView *barChartView;
@property (nonatomic, retain) CPTGraph *barChartForTop, *barChartForButtom;
@property (nonatomic, retain) NSMutableArray *dataForPlot;
@property (nonatomic, retain) NSMutableArray *dataForChart;
@property (nonatomic, retain) IBOutlet UISegmentedControl *topTenOrButtomTen;
@property (nonatomic, retain) SheetView *topTen;
@property (nonatomic, retain) SheetView *buttomTen;

@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

-(void) constructTopBarChart;
-(void) constructButtomBarChart;

@end

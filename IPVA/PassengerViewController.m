//
//  ConsumerDistribution.m
//  IpvaSheet
//
//  Created by again on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "PassengerViewController.h"
#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"

#import "SheetView.h"

@implementation PassengerViewController

@synthesize barChartView, barChartForSales, barChartForConsumer, dataForPlot, dataForChart, categorySelection, sheetView;

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;

- (void)dealloc
{
    [super dealloc];
    [_aeraPickPopover release];
    [_datePickPopover release];
    [_cyclePickPopover release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.barChartView = [[[CPTGraphHostingView alloc] initWithFrame:CGRectMake(35, 50, 700, 500)] autorelease];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) controlValueChanged
{
    switch (self.categorySelection.selectedSegmentIndex) {
        case 0:
        {
            [self constructConsumerBarChart];
        }
            break;
            
        case 1:
        {
            [self constructSalesBarChart];
        }
            break;
    }
}

-(void) setUpSegmentControl
{
    [self.categorySelection setSelectedSegmentIndex:0];
    
    [self.categorySelection setHidden:YES];
    
//    [self.categorySelection addTarget:self action:@selector(controlValueChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)constructSalesBarChart
{
	// Create barChart for Consumer Statscis
	barChartForSales = [[[CPTXYGraph alloc] initWithFrame:CGRectZero] autorelease];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTSlateTheme];
	[barChartForSales applyTheme:theme];
    barChartForSales.plotAreaFrame.masksToBorder = NO;
    
    barChartForSales.paddingLeft   = 70.0;
	barChartForSales.paddingTop	   = 70.0;
	barChartForSales.paddingRight  = 70.0;
	barChartForSales.paddingBottom = 80.0;
    
    //Create barView For the charts
	barChartView.hostedGraph			 = barChartForSales;
    barChartView.layer.masksToBounds = YES;
    barChartView.layer.cornerRadius = 20;
    [self.view addSubview:barChartView];
    
    //configure the chart title
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 25.0;
    
    barChartForSales.title = @"销售情况与客流情况";
    barChartForSales.titleTextStyle = textStyle;
    barChartForSales.titleDisplacement = CGPointMake(0.0, -20.0);
    barChartForSales.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    
	// Add plot space for horizontal bar charts
	CPTXYPlotSpace *plotSpaceForSales = (CPTXYPlotSpace *)barChartForSales.defaultPlotSpace;
	plotSpaceForSales.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(200.0f)];
	plotSpaceForSales.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(10.0f)];
    
	CPTXYAxisSet *axisSetForSales = (CPTXYAxisSet *)barChartForSales.axisSet;
    
    //configure the x axis for Consumer sheet
    CPTXYAxis *x		  = axisSetForSales.xAxis;
	x.axisLineStyle				  = nil;
	x.majorTickLineStyle		  = nil;
	x.minorTickLineStyle		  = nil;
	x.majorIntervalLength		  = CPTDecimalFromString(@"5");
	x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	x.title						  = @"广场名称";
	x.titleLocation				  = CPTDecimalFromFloat(8.0f);
	x.titleOffset				  = 30.0f;
    
    CPTMutableTextStyle *AxisTitiletextStyle = [CPTMutableTextStyle textStyle];
    AxisTitiletextStyle.color = [CPTColor blackColor];
    AxisTitiletextStyle.fontSize = 20;
    AxisTitiletextStyle.fontName = @"Helvetica-Bold";
    
    //configure the label of the axis, define some custom labels for the data elements
	x.labelRotation	 = M_PI / 4;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	NSArray *customTickLocations = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:2], [NSDecimalNumber numberWithInt:4], [NSDecimalNumber numberWithInt:6], nil];
	NSArray *xAxisLabels		 = [NSArray arrayWithObjects:@"广州万达广场", @"北京万达广场", @"上海万达广场", nil];
	NSUInteger labelLocation	 = 0;
	NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[xAxisLabels count]];
	for ( NSNumber *tickLocation in customTickLocations ) {
		CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:[xAxisLabels objectAtIndex:labelLocation++] textStyle:x.labelTextStyle];
		newLabel.tickLocation = [tickLocation decimalValue];
		newLabel.offset		  = x.labelOffset + x.majorTickLength;
		newLabel.rotation	  = M_PI / 4;
		[customLabels addObject:newLabel];
		[newLabel release];
	}
	x.axisLabels = [NSSet setWithArray:customLabels];
    x.titleTextStyle = AxisTitiletextStyle;
    
    
    
    //configure the y axis for Consumer Sheet
	CPTXYAxis *y = axisSetForSales.yAxis;
	y.axisLineStyle				  = nil;
	y.majorTickLineStyle		  = nil;
	y.minorTickLineStyle		  = nil;
	y.majorIntervalLength		  = CPTDecimalFromString(@"50");
	y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	y.title						  = @"数量";
	y.titleOffset				  = 40.0f;
	y.titleLocation				  = CPTDecimalFromFloat(180.0f);
    y.titleRotation = M_PI * 2;
    y.titleTextStyle = AxisTitiletextStyle;
    
	// First bar plot
	CPTBarPlot *barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor darkGrayColor] horizontalBars:NO];
	barPlot.baseValue  = CPTDecimalFromString(@"0");
	barPlot.dataSource = self;
	barPlot.barOffset  = CPTDecimalFromFloat(1.0f);
	barPlot.identifier = @"客流量";
	[barChartForSales addPlot:barPlot toPlotSpace:plotSpaceForSales];
    
	// Second bar plot
	barPlot					= [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
	barPlot.dataSource		= self;
	barPlot.baseValue		= CPTDecimalFromString(@"0");
	barPlot.barOffset		= CPTDecimalFromFloat(0.1f);
	barPlot.barCornerRadius = 2.0f;
	barPlot.identifier		= @"销售额";
	barPlot.delegate		= self;
	[barChartForSales addPlot:barPlot toPlotSpace:plotSpaceForSales];
    
    barChartForSales.legend				 = [CPTLegend legendWithGraph:barChartForSales];
	barChartForSales.legend.textStyle		 = x.titleTextStyle;
	barChartForSales.legend.fill			 = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
	barChartForSales.legend.borderLineStyle = x.axisLineStyle;
	barChartForSales.legend.cornerRadius	 = 5.0;
	barChartForSales.legend.swatchSize		 = CGSizeMake(25.0, 25.0);
	barChartForSales.legendDisplacement	 = CGPointMake(150.0, 350.0);
    
}
-(void) createTableView
{
    NSArray *titles = [[NSArray alloc] initWithObjects:@"1月", @"2月", @"3月", @"4月", @"5月", @"6月",@"7月", @"8月", nil] ;
    NSArray *nameLabels = [[NSArray alloc] initWithObjects:@"月份", @"广州万达广场", @"上海万达广场", @"北京万达广场", nil];
    self.sheetView = [[[SheetView alloc] initWithFrame:CGRectMake(30, 550, 700, 200) andTitles:titles andNamelabels:nameLabels] autorelease];
    
    [self.view addSubview:sheetView];
    
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpSegmentControl];
    [self constructSalesBarChart];
    [self createTableView];
    
    // configure popover;
    AeraPickViewController *aeraPickVC = [[[AeraPickViewController alloc] initWithNibName:@"AeraPickViewController" bundle:nil] autorelease];
    self.aeraPickPopover = [[UIPopoverController alloc] initWithContentViewController:aeraPickVC];
    [self.aeraPickPopover setPopoverContentSize:CGSizeMake(320, 320)];
    [self.aeraPickPopover setDelegate:self];
    
    DatePickViewController *datePickVC = [[[DatePickViewController alloc] initWithNibName:@"DateViewController" bundle:nil] autorelease];
    self.datePickPopover = [[UIPopoverController alloc] initWithContentViewController:datePickVC];
    [self.datePickPopover setPopoverContentSize:CGSizeMake(320, 265)];
    [self.datePickPopover setDelegate:self];
    
    CycleViewController *cyclePickVC = [[[CycleViewController alloc] init] autorelease];
    self.cyclePickPopover = [[UIPopoverController alloc] initWithContentViewController:cyclePickVC];
    [self.cyclePickPopover setPopoverContentSize:CGSizeMake(320, 480)];
    [self.cyclePickPopover setDelegate:self];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.aeraPickPopover = nil;
    self.datePickPopover = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return NO;
}

#pragma mark CPTBarPlot delegate method

-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)index
{
	NSLog(@"barWasSelectedAtRecordIndex %d", index);
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return 7;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
	NSDecimalNumber *num = nil;
    
	switch ( fieldEnum ) {
        case CPTBarPlotFieldBarLocation:
            if ( index % 2 == 0 && [plot.identifier isEqual:@"Bar Plot 2"]) {
                num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index];
            }
            
            if (index % 2 != 0 && ![plot.identifier isEqual:@"Bar Plot 2"])
            {
                num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index + 1];
            }
            break;
            
        case CPTBarPlotFieldBarTip:
            if ( index == 8 ) {
                num = [NSDecimalNumber notANumber];
            }
            else {
                num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:(index + 1) * (index + 1)];
                if ( [plot.identifier isEqual:@"Bar Plot 2"] ) {
                    num = [num decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"1"]];
                }
            }
            break;
    }

    
	return num;
}

- (IBAction)pressAeraButton:(id)sender 
// show a popover table view
{
    if ([self.datePickPopover isPopoverVisible])
    {
        [self.datePickPopover dismissPopoverAnimated:YES];
    }
    
    if ([self.cyclePickPopover isPopoverVisible])
    {
        [self.cyclePickPopover dismissPopoverAnimated:YES];
    }
    
    if ([self.aeraPickPopover isPopoverVisible])
    {
        [self.aeraPickPopover dismissPopoverAnimated:YES];
    }
    else {
        UIBarButtonItem *tappedButton = (UIBarButtonItem *)sender;
        [self.aeraPickPopover presentPopoverFromBarButtonItem:tappedButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }
}

- (IBAction)pressDateButton:(id)sender 
{
    if ([self.datePickPopover isPopoverVisible])
    {
        [self.datePickPopover dismissPopoverAnimated:YES];
    }
    else {
        UIBarButtonItem *tappedButton = (UIBarButtonItem *)sender;
        [self.datePickPopover presentPopoverFromBarButtonItem:tappedButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }
}

- (IBAction)pressCycleButton:(id)sender; 
{
    if ([self.cyclePickPopover isPopoverVisible])
    {
        [self.cyclePickPopover dismissPopoverAnimated:YES];
    }
    else {
        UIBarButtonItem *tappedButton = (UIBarButtonItem *)sender;
        [self.cyclePickPopover presentPopoverFromBarButtonItem:tappedButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }
}

@end

//
//  StoreRanking.m
//  IpvaSheet
//
//  Created by again on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RankViewController.h"
#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"

#import "RankSheetView.h"

@implementation RankViewController

@synthesize barChartView, barChartForTop, barChartForButtom, dataForPlot, dataForChart, topTenOrButtomTen, topTen, buttomTen, dataForGraph1, dataForGraph2;

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
        self.barChartView.layer.masksToBounds = YES;
        self.barChartView.layer.cornerRadius = 20;
        
        self.dataForGraph1 = [[NSMutableArray alloc] init];
        self.dataForGraph2 = [[NSMutableArray alloc] init]; 
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
    switch (self.topTenOrButtomTen.selectedSegmentIndex) {
        case 0:
        {
            [self constructTopBarChart];
            [self.topTen setHidden:NO];
            [self.buttomTen setHidden:YES];
        }
            break;
            
        case 1:
        {
            [self constructButtomBarChart];
            [self.topTen setHidden: NO];
            [self.buttomTen setHidden:YES];
        }
            break;
    }
}

-(void) setUpSegmentControl
{
    [self.topTenOrButtomTen setSelectedSegmentIndex:0];
    
    [self.topTenOrButtomTen addTarget:self action:@selector(controlValueChanged) forControlEvents:UIControlEventValueChanged];
}



-(void)constructTopBarChart
{
	// Create barChart from theme
	barChartForTop = [[[CPTXYGraph alloc] initWithFrame:CGRectZero] autorelease];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTSlateTheme];
	[barChartForTop applyTheme:theme];
	barChartView.hostedGraph			 = barChartForTop;
	barChartForTop.plotAreaFrame.masksToBorder = NO;
    barChartForTop.plotAreaFrame.cornerRadius = 0.0f;
    barChartForTop.plotAreaFrame.borderLineStyle = nil;
    [self.view addSubview:barChartView];
    
	barChartForTop.paddingLeft   = 70.0;
	barChartForTop.paddingTop	   = 20.0;
	barChartForTop.paddingRight  = 20.0;
	barChartForTop.paddingBottom = 80.0;
    
    //configure the chart title
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 25.0;
    
    barChartForTop.title = @"店铺排名前10位";
    barChartForTop.titleTextStyle = textStyle;
    barChartForTop.titleDisplacement = CGPointMake(0.0, -20.0);
    barChartForTop.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
	// Add plot space for horizontal bar charts
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)barChartForTop.defaultPlotSpace;
	plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(300.0f)];
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(11.0f)];
    
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)barChartForTop.axisSet;
	CPTXYAxis *x		  = axisSet.xAxis;
	x.axisLineStyle				  = nil;
	x.majorTickLineStyle		  = nil;
	x.minorTickLineStyle		  = nil;
	x.majorIntervalLength		  = CPTDecimalFromString(@"5");
	x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	x.title						  = @"店铺名称";
	x.titleLocation				  = CPTDecimalFromFloat(7.5f);
	x.titleOffset				  = 55.0f;
    
    CPTMutableTextStyle *AxisTitiletextStyle = [CPTMutableTextStyle textStyle];
    AxisTitiletextStyle.color = [CPTColor blackColor];
    AxisTitiletextStyle.fontSize = 20;
    AxisTitiletextStyle.fontName = @"Helvetica-Bold";
    
	// Define some custom labels for the data elements
	x.labelRotation	 = M_PI / 4;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	NSArray *customTickLocations = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:1], [NSDecimalNumber numberWithInt:2], [NSDecimalNumber numberWithInt:3], [NSDecimalNumber numberWithInt:4], [NSDecimalNumber numberWithInt:5], [NSDecimalNumber numberWithInt:6], [NSDecimalNumber numberWithInt:7], [NSDecimalNumber numberWithInt:8], [NSDecimalNumber numberWithInt:9], [NSDecimalNumber numberWithInt:10], nil];
	NSArray *xAxisLabels		 = [NSArray arrayWithObjects:@"店铺1", @"店铺2", @"店铺3", @"店铺4", @"店铺5",@"店铺6", @"店铺7", @"店铺8", @"店铺9", @"店铺10", nil];
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
    
	CPTXYAxis *y = axisSet.yAxis;
	y.axisLineStyle				  = nil;
	y.majorTickLineStyle		  = nil;
	y.minorTickLineStyle		  = nil;
	y.majorIntervalLength		  = CPTDecimalFromString(@"50");
	y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	y.title						  = @"销售额";
	y.titleOffset				  = 35.0f;
	y.titleLocation				  = CPTDecimalFromFloat(270.0f);
    y.titleRotation = M_PI * 2;
    y.titleTextStyle = AxisTitiletextStyle;
    
	// First bar plot
	CPTBarPlot *barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor darkGrayColor] horizontalBars:NO];
	barPlot.baseValue  = CPTDecimalFromString(@"1");
	barPlot.dataSource = self;
	barPlot.barOffset  = CPTDecimalFromFloat(0.4f);
	barPlot.identifier = @"Bar Plot 1";
    barPlot.barWidth = [[NSDecimalNumber numberWithFloat:0.8] decimalValue];
	[barChartForTop addPlot:barPlot toPlotSpace:plotSpace];
}


-(void)constructButtomBarChart
{
	// Create barChart from theme
	barChartForButtom = [[[CPTXYGraph alloc] initWithFrame:CGRectZero] autorelease];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTSlateTheme];
	[barChartForButtom applyTheme:theme];
	barChartView.hostedGraph			 = barChartForButtom;
	barChartForButtom.plotAreaFrame.masksToBorder = NO;
    barChartForButtom.plotAreaFrame.borderLineStyle = nil;
    barChartForButtom.plotAreaFrame.cornerRadius = 0.0f;
    [self.view addSubview:barChartView];
    
	barChartForButtom.paddingLeft   = 70.0;
	barChartForButtom.paddingTop	   = 20.0;
	barChartForButtom.paddingRight  = 20.0;
	barChartForButtom.paddingBottom = 80.0;
    
    //configure the chart title
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 25.0;
    
    barChartForButtom.title = @"店铺排名后10位";
    barChartForButtom.titleTextStyle = textStyle;
    barChartForButtom.titleDisplacement = CGPointMake(0.0, -20.0);
    barChartForButtom.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
	// Add plot space for horizontal bar charts
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)barChartForButtom.defaultPlotSpace;
	plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(150.0f)];
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(11.0f)];
    
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)barChartForButtom.axisSet;
	CPTXYAxis *x		  = axisSet.xAxis;
	x.axisLineStyle				  = nil;
	x.majorTickLineStyle		  = nil;
	x.minorTickLineStyle		  = nil;
	x.majorIntervalLength		  = CPTDecimalFromString(@"5");
	x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	x.title						  = @"店铺名称";
	x.titleLocation				  = CPTDecimalFromFloat(7.5f);
	x.titleOffset				  = 55.0f;
    
    CPTMutableTextStyle *AxisTitiletextStyle = [CPTMutableTextStyle textStyle];
    AxisTitiletextStyle.color = [CPTColor blackColor];
    AxisTitiletextStyle.fontSize = 20;
    AxisTitiletextStyle.fontName = @"Helvetica-Bold";
    
	// Define some custom labels for the data elements
	x.labelRotation	 = M_PI / 4;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	NSArray *customTickLocations = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:1], [NSDecimalNumber numberWithInt:2], [NSDecimalNumber numberWithInt:3], [NSDecimalNumber numberWithInt:4], [NSDecimalNumber numberWithInt:5], [NSDecimalNumber numberWithInt:6], [NSDecimalNumber numberWithInt:7], [NSDecimalNumber numberWithInt:8], [NSDecimalNumber numberWithInt:9], [NSDecimalNumber numberWithInt:10], nil];
	NSArray *xAxisLabels		 = [NSArray arrayWithObjects:@"店铺11", @"店铺12", @"店铺13", @"店铺14", @"店铺15",@"店铺16", @"店铺17", @"店铺18", @"店铺19", @"店铺20", nil];
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
    
	CPTXYAxis *y = axisSet.yAxis;
	y.axisLineStyle				  = nil;
	y.majorTickLineStyle		  = nil;
	y.minorTickLineStyle		  = nil;
	y.majorIntervalLength		  = CPTDecimalFromString(@"50");
	y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	y.title						  = @"销售额";
	y.titleOffset				  = 35.0f;
	y.titleLocation				  = CPTDecimalFromFloat(135.0f);
    y.titleRotation = M_PI * 2;
    y.titleTextStyle = AxisTitiletextStyle;
    
	// First bar plot
	CPTBarPlot *barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor darkGrayColor] horizontalBars:NO];
	barPlot.baseValue  = CPTDecimalFromString(@"1");
	barPlot.dataSource = self;
	barPlot.barOffset  = CPTDecimalFromFloat(0.4f);
	barPlot.identifier = @"Bar Plot 2";
    barPlot.barWidth = [[NSDecimalNumber numberWithFloat:0.8] decimalValue];
	[barChartForButtom addPlot:barPlot toPlotSpace:plotSpace];
}

-(void) createTable
{
    NSArray *titles = [[NSArray alloc] initWithObjects:@"第一名", @"第二名", @"第三名", @"第四名", @"第五名", @"第六名",@"第七名", @"第八名", @"第九名", @"第十名", nil] ;
    NSArray *nameLabels = [[NSArray alloc] initWithObjects:@"名次", @"店铺名称", nil];
    self.topTen = [[[RankSheetView alloc] initWithFrame:CGRectMake(30, 550, 700, 200) andTitles:titles andNamelabels:nameLabels andDatas:self.dataForGraph1] autorelease];
    NSLog(@"%d", [dataForGraph1 count]);
    
    [self.view addSubview:topTen];
    
    NSArray *titles1 = [[NSArray alloc] initWithObjects:@"倒数1", @"倒数2", @"倒数3", @"倒数4", @"倒数5", @"倒数6",@"倒数7", @"倒数8", @"倒数9", @"倒数10", nil] ;
    NSArray *nameLabels1 = [[NSArray alloc] initWithObjects:@"名次", @"店铺名称", nil];
    self.buttomTen = [[[RankSheetView alloc] initWithFrame:CGRectMake(30, 530, 700, 200) andTitles:titles1 andNamelabels:nameLabels1 andDatas:self.dataForGraph2] autorelease];
     NSLog(@"%d", [dataForGraph1 count]);
    
    [self.view addSubview:buttomTen];
    [self.buttomTen setHidden:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpSegmentControl];
    [self constructTopBarChart];
    [self createTable];
    
    // configure popover;
    AeraPickViewController *aeraPickVC = [[[AeraPickViewController alloc] init] autorelease];
    self.aeraPickPopover = [[UIPopoverController alloc] initWithContentViewController:aeraPickVC];
    [self.aeraPickPopover setPopoverContentSize:CGSizeMake(320, 320)];
    [self.aeraPickPopover setDelegate:self];
    
    DatePickViewController *datePickVC = [[[DatePickViewController alloc] init] autorelease];
    self.datePickPopover = [[UIPopoverController alloc] initWithContentViewController:datePickVC];
    [self.datePickPopover setPopoverContentSize:CGSizeMake(320, 480)];
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
	return 11;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
	NSDecimalNumber *num = nil;
    
	switch ( fieldEnum ) {
        case CPTBarPlotFieldBarLocation:
            if ( index == 0 ) {
                num = [NSDecimalNumber notANumber];
            }
            else {
                num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index];
            }
            break;
            
        case CPTBarPlotFieldBarTip:
            if ( index == 0 ) {
                num = [NSDecimalNumber notANumber];
            }
            else 
            {
                if ([plot.identifier isEqual:@"Bar Plot 2"])
                {
                    num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:70- index * 5];
                    [dataForGraph2 addObject:[NSNumber numberWithInt:(50 -index * 6)] ];
                }
                else
                {
                    num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:200- index * 7];
                    [dataForGraph1 addObject:[NSNumber numberWithInt:(50 -index * 6)]];
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
    if ([self.aeraPickPopover isPopoverVisible])
    {
        [self.aeraPickPopover dismissPopoverAnimated:YES];
    }
    
    if ([self.cyclePickPopover isPopoverVisible])
    {
        [self.cyclePickPopover dismissPopoverAnimated:YES];
    }
    
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
    if ([self.aeraPickPopover isPopoverVisible])
    {
        [self.aeraPickPopover dismissPopoverAnimated:YES];
    }
    
    if ([self.datePickPopover isPopoverVisible]) 
    {
        [self.datePickPopover dismissPopoverAnimated:YES];
    }
    
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

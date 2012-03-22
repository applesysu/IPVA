//
//  Consumer+SalesTrend.m
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TrendViewController.h"
#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"

#import "SheetView.h"


@implementation TrendViewController

@synthesize daySheet, weekSheet, yearSheet, scatterPlotView, categorySelection, timeSelection, graph, dataForChart, dataForPlot;

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil)
    {
        self.scatterPlotView = [[[CPTGraphHostingView alloc] initWithFrame:CGRectMake(35, 50, 700, 500)] autorelease];
        self.scatterPlotView.layer.masksToBounds = YES;
        self.scatterPlotView.layer.cornerRadius = 20;
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
    [self constructScatterPlot];
}


-(void) initTheSegmentControl
{
    [self.categorySelection setSelectedSegmentIndex:0];
    [self.timeSelection setSelectedSegmentIndex:0];
    
    [self.categorySelection addTarget:self action:@selector(controlValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.timeSelection addTarget:self action:@selector(controlValueChanged) forControlEvents:UIControlEventValueChanged];
    
}

-(void)generateData
{
	NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:100];
	NSUInteger i;
	for ( i = 0; i < 12; i++ ) {
		id x = [NSNumber numberWithFloat:i];
		id y = [NSNumber numberWithFloat:1.2 * arc4random()/RAND_MAX*10];
		[contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
	}
	self.dataForPlot = contentArray;
}

-(void) constructScatterPlot
{
    graph = [[[CPTXYGraph alloc] initWithFrame:CGRectZero] autorelease];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTSlateTheme];
	[graph applyTheme:theme];
	scatterPlotView.hostedGraph = graph;
    [self.view addSubview:self.scatterPlotView];
    
    graph.plotAreaFrame.paddingLeft = 70.0 ;
    graph.plotAreaFrame.paddingTop = 70.0 ;
    graph.plotAreaFrame.paddingRight = 70.0 ;
    graph.plotAreaFrame.paddingBottom = 70.0 ;
    
    graph.paddingLeft	= 0.0;
	graph.paddingTop	= 0.0;
	graph.paddingRight	= 0.0;
	graph.paddingBottom = 0.0;
    
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 25.0;
    
    graph.title = @"客流分布";
    graph.titleTextStyle = textStyle;
    graph.titleDisplacement = CGPointMake(0.0, -20.0);
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    if (self.categorySelection.selectedSegmentIndex == 0)
    {
        self.graph.title = @"客流量";
        self.graph.titleTextStyle = textStyle;
    }
    else
    {
        self.graph.title = @"销售额";
        self.graph.titleTextStyle = textStyle;
    }
    
    switch (self.timeSelection.selectedSegmentIndex) {
        case 0:
        {
            [self.daySheet setHidden: NO];
            [self.weekSheet setHidden:YES];
            [self.yearSheet setHidden:YES];
        }
            break;
            
        case 1:
        {
            [self.daySheet setHidden: YES];
            [self.weekSheet setHidden:NO];
            [self.yearSheet setHidden:YES];
        }
            break;
            
        case 2:
        {
            [self.daySheet setHidden: YES];
            [self.weekSheet setHidden:YES];
            [self.yearSheet setHidden:NO];
        }
            break;
    }
    
	// Setup plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
	plotSpace.allowsUserInteraction = YES;
	plotSpace.xRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(12.0f)];
	plotSpace.yRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(50.0f)];
    
    
	// Axes
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
	CPTXYAxis *x		  = axisSet.xAxis;
	x.majorIntervalLength		  = CPTDecimalFromString(@"1");
	x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    x.visibleRange = plotSpace.xRange;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    NSArray *customTickLocations;
	NSArray *xAxisLabels;
    
    customTickLocations = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:1], [NSDecimalNumber numberWithInt:2], [NSDecimalNumber numberWithInt:3], [NSDecimalNumber numberWithInt:4], [NSDecimalNumber numberWithInt:5], [NSDecimalNumber numberWithInt:6], [NSDecimalNumber numberWithInt:7], [NSDecimalNumber numberWithInt:8], [NSDecimalNumber numberWithInt:9], [NSDecimalNumber numberWithInt:10],[NSDecimalNumber numberWithInt:11],[NSDecimalNumber numberWithInt:12], nil];
    
    xAxisLabels = [NSArray arrayWithObjects:@"1月", @"2月", @"3月", @"4月", @"5月",@"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月", nil];
    
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
    x.title = @"时间周期";
    x.titleOffset = 45.0f;
    x.titleLocation = CPTDecimalFromFloat(8.0f); 
    
    CPTXYAxis *y = axisSet.yAxis;
    y.visibleRange = plotSpace.yRange;
    y.majorIntervalLength = CPTDecimalFromString (@"5");
    y.orthogonalCoordinateDecimal = CPTDecimalFromString (@"0");
    y.title = @"数量";
    y.titleOffset = 45.0f ;
    y.titleLocation = CPTDecimalFromFloat ( 46.0f );
    y.titleRotation = M_PI * 2;
    
    // Create a green plot area
	CPTScatterPlot *dataSourceLinePlot = [[[CPTScatterPlot alloc] init] autorelease];
    
	CPTMutableLineStyle *lineStyle = [[dataSourceLinePlot.dataLineStyle mutableCopy] autorelease];
	lineStyle.lineWidth				 = 3.f;
	lineStyle.lineColor				 = [CPTColor greenColor];
	lineStyle.dashPattern			 = [NSArray arrayWithObjects:[NSNumber numberWithFloat:5.0f], [NSNumber numberWithFloat:5.0f], nil];
	dataSourceLinePlot.dataLineStyle = lineStyle;
    
	dataSourceLinePlot.dataSource = self;
    
	// Animate in the new plot, as an example
	[graph addPlot:dataSourceLinePlot];
    
    [self generateData];
}


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
	NSNumber *num = nil;
    
    NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
    num = [[dataForPlot objectAtIndex:index] valueForKey:key];
    // Green plot gets shifted above the blue
    
    if ( fieldEnum == CPTScatterPlotFieldY ) 
    {
        num = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:[num doubleValue]];
    }
    
	return num;
}

-(NSUInteger) numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [dataForPlot count];
}


-(void) constructTable
{
    NSArray *titles = [[NSArray alloc] initWithObjects:@"1号", @"2号", @"3号", @"4号", @"5号", @"6号",@"7号", @"8号", nil] ;
    NSArray *nameLabels = [[NSArray alloc] initWithObjects:@"日期", @"本月", @"上月", @"去年同月", nil];
    self.daySheet = [[[SheetView alloc] initWithFrame:CGRectMake(30, 550, 700, 200) andTitles:titles andNamelabels:nameLabels] autorelease];
    
    [self.view addSubview:daySheet];
    
    NSArray *titles2 = [[NSArray alloc] initWithObjects:@"1周", @"2周", @"3周", @"4周", @"5周", @"6周",@"7周", @"8周", nil] ;
    NSArray *nameLabels2 = [[NSArray alloc] initWithObjects:@"周数", @"今年", @"去年", nil];
    self.weekSheet = [[[SheetView alloc] initWithFrame:CGRectMake(30, 550, 700, 200) andTitles:titles2 andNamelabels:nameLabels2] autorelease];
    
    [self.view addSubview:weekSheet];
    [self.weekSheet setHidden:YES];
    
    NSArray *titles3 = [[NSArray alloc] initWithObjects:@"1月", @"2月", @"3月", @"4月", @"5月", @"6月",@"7月", @"8月", nil] ;
    NSArray *nameLabels3 = [[NSArray alloc] initWithObjects:@"月份", @"今年", @"去年", nil];
    self.yearSheet = [[[SheetView alloc] initWithFrame:CGRectMake(30, 550, 700, 200) andTitles:titles3 andNamelabels:nameLabels3] autorelease];
    
    [self.view addSubview:yearSheet];
    [self.yearSheet setHidden:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTheSegmentControl];
    [self constructScatterPlot];
    [self constructTable];
    
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.aeraPickPopover = nil;
    self.datePickPopover = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)pressAeraButton:(id)sender 
// show a popover table view
{
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

-(void) dealloc
{
    [super dealloc];
    [self.aeraPickPopover release];
    [self.datePickPopover release];
    [self.cyclePickPopover release];
}

@end

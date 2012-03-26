//
//  CategoryViewController.m
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController.h"

#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

@synthesize graph,scatterPlotView,dataForPlot,dataForChart;

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;

@synthesize consumer, sales, collectConsumer, convertRate, bags, effect, selectedButton, generateGraph; 

- (void)dealloc
{
    [super dealloc];
    [_aeraPickPopover release];
    [_datePickPopover release];
    [_cyclePickPopover release];
}

-(IBAction) buttonClick:(id)sender
{
    NSLog(@"buttonclick");
    if ([selectedButton count] < 2)
    {
        [selectedButton addObject:[(UIButton *)sender titleLabel].text];
        [(UIButton *)sender setEnabled:NO];
        if ([selectedButton count] == 2)
        {
            [self.generateGraph setEnabled:YES];
            [self.consumer setEnabled:NO];
            [self.sales setEnabled:NO];
            [self.collectConsumer setEnabled:NO];
            [self.convertRate setEnabled:NO];
            [self.bags setEnabled:NO];
            [self.effect setEnabled:NO];
        }
    }
}
-(IBAction) generateCG
{
    NSLog(@"hihi  generate");
    [self constructScatterPlot:self.selectedButton];
    
    [self.selectedButton removeAllObjects];
    [self.generateGraph setEnabled:NO];
    [self.consumer setEnabled:YES];
    [self.sales setEnabled:YES];
    [self.collectConsumer setEnabled:YES];
    [self.convertRate setEnabled:YES];
    [self.bags setEnabled:YES];
    [self.effect setEnabled:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.scatterPlotView = [[[CPTGraphHostingView alloc] initWithFrame:CGRectMake(35, 100, 700, 500)] autorelease];
        self.scatterPlotView.layer.masksToBounds = YES;
        self.scatterPlotView.layer.cornerRadius = 20;
        [self.view addSubview:self.scatterPlotView];
        self.selectedButton = [[NSMutableArray alloc] initWithCapacity:2];
        [self.generateGraph setEnabled:NO];
    }
    return self;
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

-(void) constructScatterPlot:(NSMutableArray *)selected
{
    graph = [[[CPTXYGraph alloc] initWithFrame:CGRectZero] autorelease];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTSlateTheme];
	[graph applyTheme:theme];
	scatterPlotView.hostedGraph = graph;
    
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
    
    graph.title = @"类别分析";
    graph.titleTextStyle = textStyle;
    graph.titleDisplacement = CGPointMake(0.0, -20.0);
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
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
    x.title = [selected objectAtIndex:0];
    x.titleOffset = 45.0f;
    x.titleLocation = CPTDecimalFromFloat(8.0f); 
    
    CPTXYAxis *y = axisSet.yAxis;
    y.visibleRange = plotSpace.yRange;
    y.majorIntervalLength = CPTDecimalFromString (@"5");
    y.orthogonalCoordinateDecimal = CPTDecimalFromString (@"0");
    y.title = [selected objectAtIndex:1];
    y.titleOffset = 45.0f ;
    y.titleLocation = CPTDecimalFromFloat ( 46.0f );
    y.titleRotation = M_PI * 2;
    
    // Create a green plot area
	CPTScatterPlot *dataSourceLinePlot = [[[CPTScatterPlot alloc] init] autorelease];
    dataSourceLinePlot.identifier = @"DataLine";
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill = [CPTFill fillWithColor:[CPTColor yellowColor]];
    plotSymbol.size = CGSizeMake(20, 20);
    dataSourceLinePlot.plotSymbol = plotSymbol;
	dataSourceLinePlot.dataLineStyle = nil;
	dataSourceLinePlot.dataSource = self;
    dataSourceLinePlot.delegate = self;
    
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
        num = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:[num doubleValue] + 20];
        
    }
    
	return num;
}

-(NSUInteger) numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [dataForPlot count];
}

-(CPTPlotSymbol *) symbolForScatterPlot:(CPTScatterPlot *)plot recordIndex:(NSUInteger)index
{
    CPTPlotSymbol  *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    
    if (index % 2 == 0 && index % 5 == 0 && index != 0 )
    {
        plotSymbol.size = CGSizeMake(100, 100);
        plotSymbol.fill = [CPTFill fillWithColor:[CPTColor blueColor]];
    }
    else if (index % 3 == 0 && index != 0 && index != 9)
    {
        plotSymbol.size = CGSizeMake(50,50);
        plotSymbol.fill = [CPTFill fillWithColor:[CPTColor greenColor]];
    }
    else if(index == 1)
    {
        plotSymbol.size = CGSizeMake(70,70);
        plotSymbol.fill = [CPTFill fillWithColor:[CPTColor redColor]];
    }
    else if (index == 9)
    {
        plotSymbol.size = CGSizeMake(30,30);
        plotSymbol.fill = [CPTFill fillWithColor:[CPTColor orangeColor]];
    }
    
    return plotSymbol;
}

-(void) scatterPlot:(CPTScatterPlot *)plot plotSymbolWasSelectedAtRecordIndex:(NSUInteger)index
{
    NSLog(@"hihihihi");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"详情" message:@"客户数是XXX， 店铺总数是XXX" delegate:self cancelButtonTitle:@"了解完毕" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
	return NO;
}

- (IBAction)pressAeraButton:(id)sender 
// show a popover table view
{
    if ([self.cyclePickPopover isPopoverVisible])
    {
        [self.cyclePickPopover dismissPopoverAnimated:YES];
    }
    
    if ([self.datePickPopover isPopoverVisible]) 
    {
        [self.datePickPopover dismissPopoverAnimated:YES];
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

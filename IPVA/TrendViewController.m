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

#import "AppDelegate.h"

#import "SheetView.h"

@implementation TrendViewController

@synthesize daySheet, weekSheet, yearSheet;
@synthesize scatterPlotView, categorySelection, timeSelection,  graph, dataForChart, dataForPlot;

@synthesize cycleSelection, selectedDate;

@synthesize dataFromCompanyDatabase;

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;

@synthesize timeLabel, toolBarTitleLabel, pageTitleLabel;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil)
    {
        //configure the hosting view
        self.scatterPlotView = [[[CPTGraphHostingView alloc] initWithFrame:CGRectMake(35, 130, 700, 500)] autorelease];
        self.scatterPlotView.layer.masksToBounds = YES;
        self.scatterPlotView.layer.cornerRadius = 20;
    }
    
    return self;
}

-(void) dealloc
{
    [super dealloc];
    [self.aeraPickPopover release];
    [self.datePickPopover release];
    [self.cyclePickPopover release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(void) controlValueChanged
{
    [self constructMonthScatterPlot];
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
    NSUInteger dataNumber;
    if (self.timeSelection.selectedSegmentIndex == 0)
    {
        dataNumber = 31;
    }
    else if (self.timeSelection.selectedSegmentIndex == 1)
    {
        dataNumber = 52;
    }
    else
    {
        dataNumber = 12;
    }
	for ( i = 0; i < dataNumber; i++ ) {
		id x = [NSNumber numberWithFloat:i];
		id y = [NSNumber numberWithFloat:1.2 * arc4random()/RAND_MAX*10];
		[contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
	}
	self.dataForPlot = contentArray;
}

-(void) constructMonthScatterPlot
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
    
    //set the text style for the graph title
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 25.0;
    
    //set the location of the title
    graph.titleTextStyle = textStyle;
    graph.titleDisplacement = CGPointMake(0.0, -40.0);
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
	// Setup plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
	plotSpace.allowsUserInteraction = NO;
    
	// Axes
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
	CPTXYAxis *x		  = axisSet.xAxis;
    
    CPTMutableTextStyle *mts = [[CPTMutableTextStyle.textStyle mutableCopy] autorelease];
	
    NSArray *customTickLocations;
	NSArray *xAxisLabels;
    NSMutableArray *tempArray = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *tempArray2 = [[[NSMutableArray alloc] init] autorelease];
    switch (self.timeSelection.selectedSegmentIndex) {
        case 0:
        {
            [self.daySheet setHidden: NO];
            [self.weekSheet setHidden:YES];
            [self.yearSheet setHidden:YES];
            
            plotSpace.xRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(31.0f)];
            plotSpace.yRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(50.0f)];
            
            x.majorIntervalLength		  = CPTDecimalFromString(@"1");
            x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
            x.visibleRange = plotSpace.xRange;
            x.labelingPolicy = CPTAxisLabelingPolicyNone;
            
            for (int i = 0; i < 31; i++)
            {
                [tempArray addObject:[NSDecimalNumber numberWithInt:(i+1)]];
            }
            customTickLocations = tempArray;
            
            
            for (int i = 0; i < 31; i++)
            {
                [tempArray2 addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            xAxisLabels = tempArray2;
            
            NSUInteger labelLocation = 0;
            NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[xAxisLabels count]];
            for ( NSNumber *tickLocation in customTickLocations ) 
            {
                CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:[xAxisLabels objectAtIndex:labelLocation++] textStyle:mts];
                newLabel.tickLocation = [tickLocation decimalValue];
                newLabel.offset		  = x.labelOffset + x.majorTickLength;
                newLabel.rotation	  = M_PI / 4;
                [customLabels addObject:newLabel];
                [newLabel release];
            }
            
            x.axisLabels = [NSSet setWithArray:customLabels];
            CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
            axisTitleStyle.color = [CPTColor blackColor];
            axisTitleStyle.fontSize = 14;
            CPTAxisTitle *title = [[[CPTAxisTitle alloc] initWithText:@"时间周期（日）" textStyle:axisTitleStyle] autorelease];
            x.axisTitle = title;
            x.titleOffset = 40.0f;
            
            CPTXYAxis *y = axisSet.yAxis;
            y.visibleRange = plotSpace.yRange;
            y.majorIntervalLength = CPTDecimalFromString (@"5");
            y.orthogonalCoordinateDecimal = CPTDecimalFromString (@"0");
            
            
            if (self.categorySelection.selectedSegmentIndex == 0)
            {
                self.graph.title = @"客流量";
                y.title = @"客流量（万人）";
                y.titleOffset = -60.0f ;
                y.titleLocation = CPTDecimalFromFloat ( 46.0f );
                y.titleRotation = M_PI * 2;
                self.graph.titleTextStyle = textStyle;
            }
            else
            {
                self.graph.title = @"销售额";
                y.title = @"销售额（万元）";
                y.titleOffset = -60.0f ;
                y.titleLocation = CPTDecimalFromFloat ( 46.0f );
                y.titleRotation = M_PI * 2;
                self.graph.titleTextStyle = textStyle;
            }
            
            // Create a green plot area
            CPTScatterPlot *dataSourceLinePlot1 = [[[CPTScatterPlot alloc] init] autorelease];
            
            CPTMutableLineStyle *lineStyle1 = [[dataSourceLinePlot1.dataLineStyle mutableCopy] autorelease];
            lineStyle1.lineWidth				 = 3.f;
            lineStyle1.lineColor				 = [CPTColor greenColor];
            lineStyle1.dashPattern = nil;
            dataSourceLinePlot1.dataLineStyle = lineStyle1;
            dataSourceLinePlot1.identifier = @"本月";
            dataSourceLinePlot1.dataSource = self;
            
            // Animate in the new plot, as an example
            [graph addPlot:dataSourceLinePlot1];
            
            // Create a green plot area
            CPTScatterPlot *dataSourceLinePlot2 = [[[CPTScatterPlot alloc] init] autorelease];
            
            CPTMutableLineStyle *lineStyle2 = [[dataSourceLinePlot2.dataLineStyle mutableCopy] autorelease];
            lineStyle2.lineWidth				 = 3.f;
            lineStyle2.lineColor				 = [CPTColor yellowColor];
            lineStyle2.dashPattern			 = nil;
            dataSourceLinePlot2.dataLineStyle = lineStyle2;
            dataSourceLinePlot2.identifier = @"上月";
            dataSourceLinePlot2.dataSource = self;
            
            // Animate in the new plot, as an example
            [graph addPlot:dataSourceLinePlot2];
            
            // Create a green plot area
            CPTScatterPlot *dataSourceLinePlot3 = [[[CPTScatterPlot alloc] init] autorelease];
            
            CPTMutableLineStyle *lineStyle3 = [[dataSourceLinePlot3.dataLineStyle mutableCopy] autorelease];
            lineStyle3.lineWidth				 = 3.f;
            lineStyle3.lineColor				 = [CPTColor redColor];
            lineStyle3.dashPattern			 = nil;
            dataSourceLinePlot3.dataLineStyle = lineStyle3;
            dataSourceLinePlot3.identifier = @"上年同月";
            dataSourceLinePlot3.dataSource = self;
            
            // Animate in the new plot, as an example
            [graph addPlot:dataSourceLinePlot3];
            
            graph.legend				 = [CPTLegend legendWithGraph:graph];
            graph.legend.textStyle		 = x.titleTextStyle;
            graph.legend.fill			 = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
            graph.legend.borderLineStyle = x.axisLineStyle;
            graph.legend.cornerRadius	 = 5.0;
            graph.legend.swatchSize		 = CGSizeMake(25.0, 25.0);
            graph.legendDisplacement	 = CGPointMake(150.0, 370.0);
            
        }
            break;
            
        case 1:
        {
            [self.daySheet setHidden: YES];
            [self.weekSheet setHidden:NO];
            [self.yearSheet setHidden:YES];
            
            plotSpace.xRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(52.0f)];
            plotSpace.yRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(50.0f)];
            
            x.majorIntervalLength		  = CPTDecimalFromString(@"1");
            x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
            x.visibleRange = plotSpace.xRange;
            x.labelingPolicy = CPTAxisLabelingPolicyNone;
            
            for (int i = 0; i < 52; i++)
            {
                [tempArray addObject:[NSDecimalNumber numberWithInt:(i+1)]];
            }
            customTickLocations = tempArray;
            
            
            for (int i = 0; i < 52; i++)
            {
                [tempArray2 addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            xAxisLabels = tempArray2;
            
            mts.fontSize = 7.0f;
            
            NSUInteger labelLocation = 0;
            NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[xAxisLabels count]];
            for ( NSNumber *tickLocation in customTickLocations ) 
            {
                CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:[xAxisLabels objectAtIndex:labelLocation++] textStyle:mts];
                newLabel.tickLocation = [tickLocation decimalValue];
                newLabel.offset		  = x.labelOffset + x.majorTickLength;
                newLabel.rotation	  = M_PI / 4;
                [customLabels addObject:newLabel];
                [newLabel release];
            }
            
            x.axisLabels = [NSSet setWithArray:customLabels];
            CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
            axisTitleStyle.color = [CPTColor blackColor];
            axisTitleStyle.fontSize = 14;
            CPTAxisTitle *title = [[[CPTAxisTitle alloc] initWithText:@"时间周期（周）" textStyle:axisTitleStyle] autorelease];
            x.axisTitle = title;
            x.titleOffset = 40.0f;
            
            CPTXYAxis *y = axisSet.yAxis;
            y.visibleRange = plotSpace.yRange;
            y.majorIntervalLength = CPTDecimalFromString (@"5");
            y.orthogonalCoordinateDecimal = CPTDecimalFromString (@"0");
            
            
            if (self.categorySelection.selectedSegmentIndex == 0)
            {
                self.graph.title = @"客流量";
                y.title = @"客流量（万人）";
                y.titleOffset = -60.0f ;
                y.titleLocation = CPTDecimalFromFloat ( 46.0f );
                y.titleRotation = M_PI * 2;
                self.graph.titleTextStyle = textStyle;
            }
            else
            {
                self.graph.title = @"销售额";
                y.title = @"销售额（万元）";
                y.titleOffset = -60.0f ;
                y.titleLocation = CPTDecimalFromFloat ( 46.0f );
                y.titleRotation = M_PI * 2;
                self.graph.titleTextStyle = textStyle;
            }
            
            // Create a green plot area
            CPTScatterPlot *dataSourceLinePlot1 = [[[CPTScatterPlot alloc] init] autorelease];
            
            CPTMutableLineStyle *lineStyle1 = [[dataSourceLinePlot1.dataLineStyle mutableCopy] autorelease];
            lineStyle1.lineWidth				 = 3.f;
            lineStyle1.lineColor				 = [CPTColor greenColor];
            lineStyle1.dashPattern			 =  nil;
            dataSourceLinePlot1.dataLineStyle = lineStyle1;
            dataSourceLinePlot1.identifier = @"今年";
            dataSourceLinePlot1.dataSource = self;
            
            // Animate in the new plot, as an example
            [graph addPlot:dataSourceLinePlot1];
            
            // Create a green plot area
            CPTScatterPlot *dataSourceLinePlot2 = [[[CPTScatterPlot alloc] init] autorelease];
            
            CPTMutableLineStyle *lineStyle2 = [[dataSourceLinePlot2.dataLineStyle mutableCopy] autorelease];
            lineStyle2.lineWidth				 = 3.f;
            lineStyle2.lineColor				 = [CPTColor yellowColor];
            lineStyle2.dashPattern			 =  nil;
            dataSourceLinePlot2.dataLineStyle = lineStyle2;
            dataSourceLinePlot2.identifier = @"去年";
            dataSourceLinePlot2.dataSource = self;
            
            // Animate in the new plot, as an example
            [graph addPlot:dataSourceLinePlot2];
            
            graph.legend				 = [CPTLegend legendWithGraph:graph];
            graph.legend.textStyle		 = x.titleTextStyle;
            graph.legend.fill			 = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
            graph.legend.borderLineStyle = x.axisLineStyle;
            graph.legend.cornerRadius	 = 5.0;
            graph.legend.swatchSize		 = CGSizeMake(25.0, 25.0);
            graph.legendDisplacement	 = CGPointMake(150.0, 370.0);
            
        }
            break;
            
        case 2:
        {
            [self.daySheet setHidden: YES];
            [self.weekSheet setHidden:YES];
            [self.yearSheet setHidden:NO];
            
            plotSpace.xRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(12.0f)];
            plotSpace.yRange				= [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(50.0f)];
            
            x.majorIntervalLength		  = CPTDecimalFromString(@"1");
            x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
            x.visibleRange = plotSpace.xRange;
            x.labelingPolicy = CPTAxisLabelingPolicyNone;
            
            
            for (int i = 0; i < 12; i++)
            {
                [tempArray addObject:[NSDecimalNumber numberWithInt:(i+1)]];
            }
            customTickLocations = tempArray;
            
            
            for (int i = 0; i < 12; i++)
            {
                [tempArray2 addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            xAxisLabels = tempArray2;
            
            NSUInteger labelLocation = 0;
            NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[xAxisLabels count]];
            for ( NSNumber *tickLocation in customTickLocations ) 
            {
                CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:[xAxisLabels objectAtIndex:labelLocation++] textStyle:mts];
                newLabel.tickLocation = [tickLocation decimalValue];
                newLabel.offset		  = x.labelOffset + x.majorTickLength;
                newLabel.rotation	  = M_PI / 4;
                [customLabels addObject:newLabel];
                [newLabel release];
            }
            
            x.axisLabels = [NSSet setWithArray:customLabels];
            CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
            axisTitleStyle.color = [CPTColor blackColor];
            axisTitleStyle.fontSize = 14;
            CPTAxisTitle *title = [[[CPTAxisTitle alloc] initWithText:@"时间周期（月）" textStyle:axisTitleStyle] autorelease];
            x.axisTitle = title;
            x.titleOffset = 40.0f;
            
            CPTXYAxis *y = axisSet.yAxis;
            y.visibleRange = plotSpace.yRange;
            y.majorIntervalLength = CPTDecimalFromString (@"5");
            y.orthogonalCoordinateDecimal = CPTDecimalFromString (@"0");
            
            if (self.categorySelection.selectedSegmentIndex == 0)
            {
                self.graph.title = @"客流量";
                y.title = @"客流量（万人）";
                y.titleOffset = -60.0f ;
                y.titleLocation = CPTDecimalFromFloat ( 46.0f );
                y.titleRotation = M_PI * 2;
                self.graph.titleTextStyle = textStyle;
            }
            else
            {
                self.graph.title = @"销售额";
                y.title = @"销售额（万元）";
                y.titleOffset = -60.0f ;
                y.titleLocation = CPTDecimalFromFloat ( 46.0f );
                y.titleRotation = M_PI * 2;
                self.graph.titleTextStyle = textStyle;
            }
            
            // Create a green plot area
            CPTScatterPlot *dataSourceLinePlot1 = [[[CPTScatterPlot alloc] init] autorelease];
            
            CPTMutableLineStyle *lineStyle1 = [[dataSourceLinePlot1.dataLineStyle mutableCopy] autorelease];
            lineStyle1.lineWidth				 = 3.f;
            lineStyle1.lineColor				 = [CPTColor greenColor];
            lineStyle1.dashPattern			 = nil;
            dataSourceLinePlot1.dataLineStyle = lineStyle1;
            dataSourceLinePlot1.identifier = @"今年";
            dataSourceLinePlot1.dataSource = self;
            
            // Animate in the new plot, as an example
            [graph addPlot:dataSourceLinePlot1];
            
            // Create a green plot area
            CPTScatterPlot *dataSourceLinePlot2 = [[[CPTScatterPlot alloc] init] autorelease];
            
            CPTMutableLineStyle *lineStyle2 = [[dataSourceLinePlot2.dataLineStyle mutableCopy] autorelease];
            lineStyle2.lineWidth				 = 3.f;
            lineStyle2.lineColor				 = [CPTColor yellowColor];
            lineStyle2.dashPattern			 = nil;
            dataSourceLinePlot2.dataLineStyle = lineStyle2;
            dataSourceLinePlot2.identifier = @"明年";
            dataSourceLinePlot2.dataSource = self;
            
            // Animate in the new plot, as an example
            [graph addPlot:dataSourceLinePlot2];
        }
            graph.legend				 = [CPTLegend legendWithGraph:graph];
            graph.legend.textStyle		 = x.titleTextStyle;
            graph.legend.fill			 = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
            graph.legend.borderLineStyle = x.axisLineStyle;
            graph.legend.cornerRadius	 = 5.0;
            graph.legend.swatchSize		 = CGSizeMake(25.0, 25.0);
            graph.legendDisplacement	 = CGPointMake(150.0, 370.0);
            break;
    }
    
    
    
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
        if (self.timeSelection.selectedSegmentIndex == 0)
        {
            if ([plot.identifier isEqual:@"本月"])
            {
                if (index > 30)
                {
                    num = [NSDecimalNumber notANumber];
                    
                }
                else
                {
                    num = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:[num doubleValue]];
                }
            }
            else if ([plot.identifier isEqual:@"上月"])
            {
                if (index > 30)
                {
                    num = [NSDecimalNumber notANumber];
                }
                else
                {
                    num = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:([num doubleValue]+10)];
                }
                
            }
            else if ([plot.identifier isEqual:@"上年同月"])
            {
                if (index > 30)
                {
                    num = [NSDecimalNumber notANumber];
                }
                else
                {
                    num = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:([num doubleValue]+20)];
                }
            }
        }
        else if (self.timeSelection.selectedSegmentIndex == 1)
        {
            
            if ([plot.identifier isEqual:@"今年"])
            {
                if (index > 14)
                {
                    num = [NSDecimalNumber notANumber];
                }
                else
                {
                    num = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:[num doubleValue]];
                }
            }
            else if ([plot.identifier isEqual:@"去年"])
            {
                
                num = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:([num doubleValue]+10)];
                
            }
        }
        else
        {
            
            if ([plot.identifier isEqual:@"今年"])
            {
                if (index > 3)
                {
                    num = [NSDecimalNumber notANumber];
                }
                else
                {
                    num = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:[num doubleValue]];
                }
            }
            else if ([plot.identifier isEqual:@"去年"])
            {
                
                num = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble:([num doubleValue]+10)];
            }
            
        }
    }
    
	return num;
}

-(NSUInteger) numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [dataForPlot count];
}


-(void) constructTable
{
    NSMutableArray *titlesDays = [[NSMutableArray alloc] initWithCapacity:31];
    NSMutableArray *titlesMonths = [[NSMutableArray alloc] initWithCapacity:12];
    NSMutableArray *titlesWeeks = [[NSMutableArray alloc] initWithCapacity:52];
    
    for (int i = 0; i < 31; i++)
    {
        [titlesDays addObject:[NSString stringWithFormat:@"%d日", i+1]];
    }
    
    for (int i = 0; i < 12; i++)
    {
        [titlesMonths addObject:[NSString stringWithFormat:@"%d月", i+1]];
    }
    
    for (int i = 0; i < 52; i++)
    {
        [titlesWeeks addObject:[NSString stringWithFormat:@"%d周", i+1]];
    }
    
    NSArray *nameLabels = [[NSArray alloc] initWithObjects:@"日期", @"本月", @"上月", @"去年同月", nil];
    self.daySheet = [[[SheetView alloc] initWithFrame:CGRectMake(30, 620, 700, 200) andTitles:titlesDays andNamelabels:nameLabels] autorelease];
    
    [self.view addSubview:daySheet];
    
    NSArray *nameLabels2 = [[NSArray alloc] initWithObjects:@"周数", @"今年", @"去年", nil];
    self.weekSheet = [[[SheetView alloc] initWithFrame:CGRectMake(30, 640, 700, 200) andTitles:titlesWeeks andNamelabels:nameLabels2] autorelease];
    
    [self.view addSubview:weekSheet];
    [self.weekSheet setHidden:YES];
    
    NSArray *nameLabels3 = [[NSArray alloc] initWithObjects:@"月份", @"今年", @"去年", nil];
    self.yearSheet = [[[SheetView alloc] initWithFrame:CGRectMake(30, 640, 700, 200) andTitles:titlesMonths andNamelabels:nameLabels3] autorelease];
    
    [self.view addSubview:yearSheet];
    [self.yearSheet setHidden:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTheSegmentControl];
    [self constructMonthScatterPlot];
    [self constructTable];
    
    self.selectedDate = [NSDate date];
    [self.cycleSelection setSelectedSegmentIndex:0];
    [self presentCycleDay];
    
    // configure popover;
    AeraPickViewController *aeraPickVC = [[[AeraPickViewController alloc] initWithNibName:@"AeraPickViewController" bundle:nil] autorelease];
    self.aeraPickPopover = [[UIPopoverController alloc] initWithContentViewController:aeraPickVC];
    [self.aeraPickPopover setPopoverContentSize:CGSizeMake(320, 320)];
    [self.aeraPickPopover setDelegate:self];
    
    DatePickViewController *datePickVC = [[[DatePickViewController alloc] initWithNibName:@"DateViewController" bundle:nil] autorelease];
    [datePickVC.calendar setDelegate:self];
    self.datePickPopover = [[UIPopoverController alloc] initWithContentViewController:datePickVC];
    [self.datePickPopover setPopoverContentSize:CGSizeMake(320, 265)];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.pageTitleLabel setText:
     [NSString stringWithFormat:@"%@趋势分析", ((AppDelegate *)[[UIApplication sharedApplication] delegate]).chosenSquare]
     ];
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

-(void) presentCycleDay
{
    NSMutableString *dateString = [[NSMutableString alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self.selectedDate];
    NSInteger year = [comps year];    
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    
    [dateString appendFormat:@"日期：%d-%d-%d", year, month, day];
    self.timeLabel.text = dateString;
    
    [dateString release];
}

-(void) presentCycleWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit) fromDate:self.selectedDate];
    
    NSInteger week = [comps week]; // 今年的第几周
    
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    NSDate *beginningOfWeek = nil;
    [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek
                 interval:NULL forDate: self.selectedDate];
    beginningOfWeek = [beginningOfWeek dateByAddingTimeInterval:24*60*60];
    NSDate *endOfWeek = [beginningOfWeek dateByAddingTimeInterval:24*60*60*6];
    
    if (weekday == 1)
    {
        beginningOfWeek = [beginningOfWeek dateByAddingTimeInterval:-24*60*60*7];
        endOfWeek = self.selectedDate;
        week--;
    }
    
    NSMutableString *dateString = [[NSMutableString alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:beginningOfWeek];
    NSInteger year = [comps year];    
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    [dateString appendFormat:@"%d-%d-%d~",year, month, day];
    
    comps = [calendar components:unitFlags fromDate:endOfWeek];
    year = [comps year];    
    month = [comps month];
    day = [comps day];
    [dateString appendFormat:@"%d-%d-%d",year, month, day];
    
    [dateString appendFormat:@" 第%d周", week];
    
    self.timeLabel.text = dateString;
    
    [dateString release];
    
}

-(void) presentCycleMonth
{
    NSMutableString *dateString = [[NSMutableString alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self.selectedDate];
    NSInteger year = [comps year];    
    NSInteger month = [comps month];
    
    [dateString appendFormat:@"%d年%d月", year, month];
    self.timeLabel.text = dateString;
    
    [dateString release];
}

-(void) setTheDateCycle
{
    if (self.cycleSelection.selectedSegmentIndex == 0)
    {
        [self presentCycleDay];
    }
    else if (self.cycleSelection.selectedSegmentIndex == 1)
    {
        [self presentCycleWeek];
    }
    else
    {
        [self presentCycleMonth];
    }
    
}

- (IBAction)pressCycleButton:(id)sender; 
{
    [self setTheDateCycle];
}

#pragma mark - TKCalendarMonthViewDelegate methods



- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
    self.selectedDate = d;
    
    [self setTheDateCycle];
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	self.selectedDate = d;
    
    [self setTheDateCycle];
}

@end

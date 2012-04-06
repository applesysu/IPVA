//
//  CompareViewController.m
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CompareViewController.h"

#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"
#import "CYCompareGraph.h"

#import "AppDelegate.h"

@interface CompareViewController () {
}

@property (strong, nonatomic) NSMutableDictionary *dataFromCompanyDatabase;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) CYCompareGraph *compareGraph;

@end

@implementation CompareViewController

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;
@synthesize compareView = _compareView;
@synthesize compareGraph = _compareGraph;
@synthesize squareALabel = _squareALabel;
@synthesize squareBLabel = _squareBLabel;
@synthesize squareButton = _squareButton;
@synthesize dataFromCompanyDatabase = _dataFromCompanyDatabase;

@synthesize dataArray = _dataArray;

@synthesize timeLabel, toolBarTitleLabel, pageTitleLabel;

@synthesize cycleSelection, selectedDate;

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (CYCompareGraph *)compareGraph
{
    if (_compareGraph == nil) {
        _compareGraph = [[CYCompareGraph alloc] init];
    }
    return _compareGraph;
}

-(NSMutableDictionary *) dataFromCompanyDatabase
{
    if (_dataFromCompanyDatabase == nil)
    {
        _dataFromCompanyDatabase = [[NSMutableDictionary alloc] init];
    }
    return _dataFromCompanyDatabase;
}

- (void)dealloc
{
    [_dataArray release];
    [_dataFromCompanyDatabase release];
    [_compareView release];
    [_squareALabel release];
    [_squareBLabel release];
    [_squareButton release];
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
        
        // test data;
        for (int i = 0; i < 23; i++) 
        {
            NSMutableArray *currentArray = [[[NSMutableArray alloc] init] autorelease];
            for (int j = 0;j < 8; j++)
            {
               [currentArray addObject:[NSNumber numberWithDouble:((CGFloat)(arc4random() % 100) / 100)]];
            }
            [self.dataArray addObject:currentArray];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    
    // the default date is today, and the cycle is day-cycle
    self.selectedDate =  [NSDate date];
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
    
    // configure compare graph
    CYCompareGraph *compareGraph = [[[CYCompareGraph alloc] initWithFrame:CGRectMake(0, 0, 300, 300)] autorelease];
    self.compareGraph = compareGraph;
    
    [self.compareGraph setFirstObjectValuesArray:[self.dataArray objectAtIndex:0]];
    [self.compareGraph setSecondObjectValuesArray:[self.dataArray objectAtIndex:1]];
    
    [self.compareView addSubview:self.compareGraph];

}

- (void)viewDidUnload
{
    [self setCompareView:nil];
    [self setSquareALabel:nil];
    [self setSquareBLabel:nil];
    [self setSquareButton:nil];
    [super viewDidUnload];
    self.aeraPickPopover = nil;
    self.datePickPopover = nil;
    self.dataArray = nil;
    self.dataFromCompanyDatabase = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.pageTitleLabel setText:
     [NSString stringWithFormat:@"%@对比分析", ((AppDelegate *)[[UIApplication sharedApplication] delegate]).chosenSquare]
     ];
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

- (IBAction)pressSquareButton:(id)sender {
    
    static int lastButtonID = 1;
    if ([(UIButton *)sender isSelected])
        return;

    for (UIButton *button in self.squareButton)
    {
        [button setSelected:NO];
    }
    
    [[self.squareButton objectAtIndex:lastButtonID] setSelected:YES];
    [self.squareALabel setText:[[[self.squareButton objectAtIndex:lastButtonID] titleLabel] text]];
    [self.compareGraph setFirstObjectValuesArray:[self.dataArray objectAtIndex:lastButtonID]];
    
    [[self.squareButton objectAtIndex:([sender tag] - 10)] setSelected:YES];
    [self.squareBLabel setText:[[[self.squareButton objectAtIndex:([sender tag] - 10)] titleLabel] text]];
    [self.compareGraph setSecondObjectValuesArray:[self.dataArray objectAtIndex:([sender tag] - 10)]];
    
    lastButtonID = [sender tag] - 10;
    [self.compareGraph setNeedsDisplay];
    
}


#pragma mark - TKCalendarMonthViewDelegate methods

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

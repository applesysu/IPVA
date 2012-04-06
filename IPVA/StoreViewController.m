//
//  LeadingStore.m
//  IpvaSheet
//
//  Created by Henry Tse on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreSheetView.h"
#import "LeadingStoreData.h"
#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"

#import "AppDelegate.h"

#import <QuartzCore/QuartzCore.h>

@implementation StoreViewController

@synthesize data;
@synthesize selectedDate;
@synthesize sheetView;
@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;

@synthesize timeLabel, toolBarTitleLabel, pageTitleLabel;

@synthesize cycleSelection;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil)
    {
        
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [_aeraPickPopover release];
    [_datePickPopover release];
    [_cyclePickPopover release];
    [self.sheetView release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) initWithData
{
    LeadingStoreData *data1 = [[[LeadingStoreData alloc] init] autorelease];
    data1.rankNumber = 1;
    data1.squareName = @"square2";
    data1.consumerCount =  30000;
    data1.salesCount = 40000;
    
    LeadingStoreData *data2 = [[[LeadingStoreData alloc] init] autorelease];
    data2.rankNumber = 2;
    data2.squareName = @"square3";
    data2.consumerCount =  40000;
    data2.salesCount = 10000;
    
    LeadingStoreData *data3 = [[[LeadingStoreData alloc] init] autorelease];
    data3.rankNumber = 3;
    data3.squareName = @"square4";
    data3.consumerCount =  10000;
    data3.salesCount = 20000;
    
    LeadingStoreData *data4 = [[[LeadingStoreData alloc] init] autorelease];
    data4.rankNumber = 4;
    data4.squareName = @"square1";
    data4.consumerCount = 20000;
    data4.salesCount = 30000;
    
    NSArray *array = [[[NSArray alloc] initWithObjects:data1, data2, data3, data4, nil] autorelease];
    self.data = array;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedDate = [NSDate date];
    [self.cycleSelection setSelectedSegmentIndex:0];
    [self presentCycleDay];
    
    //生成表视图
    [self initWithData];
    NSArray *titles = [[NSArray alloc] initWithObjects:@"排名", @"广场名称", @"客流量", @"销售额", nil];
    NSArray *propertyNames = [[NSArray alloc] initWithObjects:@"rankNumber", @"squareName", @"consumerCount", @"salesCount", nil];
    self.sheetView = [[StoreSheetView alloc] initWithFrame:CGRectMake(74, 130, 620, 570) andTitles:titles andPropertyname:propertyNames andData:self.data];
    
    [self.view addSubview:self.sheetView];
    
    
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
    
    self.sheetView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.pageTitleLabel setText:
     [NSString stringWithFormat:@"%@客流分析", ((AppDelegate *)[[UIApplication sharedApplication] delegate]).chosenSquare]
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

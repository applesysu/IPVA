//
//  FirstViewController.m
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstSheetView.h"
#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;

@synthesize sales, consumers, squareNumber, date;
@synthesize cycleSelection;
@synthesize selectedDate;

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //the default date cycle type is today and day_type 
    [self.cycleSelection setSelectedSegmentIndex:0];
    self.selectedDate = [NSDate date];
    [self presentCycleDay];
    
    //configure the the sheet in the first view controller
    NSArray *titles = [[NSArray alloc] initWithObjects:@"序号", @"广场名称", @"客流量", @"销售额", @"天气", @"活动",nil] ;
    NSArray *property = [[[NSArray alloc] initWithObjects:@"rankNumber", @"squareName", @"consumerCount", @"salesCount", @"weather", @"activity", nil] autorelease];
    NSArray *areaArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"厦门湖里万达广场"],[NSString stringWithFormat:@"福州金融街万达广场"],[NSString stringWithFormat:@"宁波江北万达广场"],[NSString stringWithFormat:@"宁波鄞州万达广场"],[NSString stringWithFormat:@"泰州万达广场"],[NSString stringWithFormat:@"合肥天鹅湖万达广场"],[NSString stringWithFormat:@"石家庄裕华万达广场"],[NSString stringWithFormat:@"天津河东区万达广场"],[NSString stringWithFormat:@"呼和浩特万达广场"],[NSString stringWithFormat:@"包头青山万达广场"],[NSString stringWithFormat:@"济南魏家庄万达广场"],[NSString stringWithFormat:@"武汉经开万达广场"],[NSString stringWithFormat:@"武汉菱角湖万达广场"],[NSString stringWithFormat:@"武汉汉街万达广场"],[NSString stringWithFormat:@"宜昌万达广场"],[NSString stringWithFormat:@"襄阳万达广场"],[NSString stringWithFormat:@"重庆万州万达广场"],[NSString stringWithFormat:@"武汉汉街万达广场"],[NSString stringWithFormat:@"沈阳太原街(城中城)万达广场"],[NSString stringWithFormat:@"沈阳铁西万达广场"],[NSString stringWithFormat:@"长春红旗街万达广场"],[NSString stringWithFormat:@"大庆萨尔图万达广场"],[NSString stringWithFormat:@"合肥包河万达广场"], nil];
    FirstSheetView *fsw = [[FirstSheetView alloc] initWithFrame:CGRectMake(40, 300, 620, 570) andTitles:titles andPropertyname:property andData:areaArray];    
    [self.view addSubview:fsw];
    
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
    if ([self.cyclePickPopover isPopoverVisible])
    {
        [self.cyclePickPopover dismissPopoverAnimated:YES];
    }
    
    if ([self.aeraPickPopover isPopoverVisible])
    {
        [self.aeraPickPopover dismissPopoverAnimated:YES];
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
    self.date.text = dateString;
    
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
    
    self.date.text = dateString;
    
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
    self.date.text = dateString;
    
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

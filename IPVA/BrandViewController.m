//
//  BrandAnalysis.m
//  IpvaSheet
//
//  Created by again on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandViewController.h"
#import "BrandAnalysisData.h"
#import "BrandAnalysisDetail.h"
#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"

#import "AppDelegate.h"

#import <QuartzCore/QuartzCore.h>

@implementation BrandViewController

@synthesize titleRowView,titleArray, rightTableView, propertyNames, data;

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;

@synthesize timeLabel, pageTitleLabel;

@synthesize cycleSelection, selectedDate;

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
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) buttonClick:(id)sender
{
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:[self.propertyNames objectAtIndex:[(UIButton *)sender tag]] ascending:YES] autorelease];
    NSArray *array = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
    self.data = sortedArray;
    
    [self.rightTableView reloadData];
}

-(void) initWithData
{
    BrandAnalysisData *data1 = [[[BrandAnalysisData alloc] init] autorelease];
    data1.rankNumber = 1;
    data1.brandName = @"brand2";
    data1.storeNumber = 3;
    data1.consumerCount = 40000;
    data1.salesCount = 500000;
    data1.avgConsumerCount = 6000;
    data1.avgSalesCount = 7000;
    
    BrandAnalysisData *data2 = [[[BrandAnalysisData alloc] init] autorelease];
    data2.rankNumber = 2;
    data2.brandName = @"brand3";
    data2.storeNumber = 4;
    data2.consumerCount = 50000;
    data2.salesCount = 600000;
    data2.avgConsumerCount = 7000;
    data2.avgSalesCount = 1000;
    
    BrandAnalysisData *data3 = [[[BrandAnalysisData alloc] init] autorelease];
    data3.rankNumber = 3;
    data3.brandName = @"brand4";
    data3.storeNumber = 5;
    data3.consumerCount = 60000;
    data3.salesCount = 700000;
    data3.avgConsumerCount = 1000;
    data3.avgSalesCount = 2000;
    
    BrandAnalysisData *data4 = [[[BrandAnalysisData alloc] init] autorelease];
    data4.rankNumber = 4;
    data4.brandName = @"brand5";
    data4.storeNumber = 6;
    data4.consumerCount = 70000;
    data4.salesCount = 100000;
    data4.avgConsumerCount = 2000;
    data4.avgSalesCount = 3000;
    
    BrandAnalysisData *data5 = [[[BrandAnalysisData alloc] init] autorelease];
    data5.rankNumber = 5;
    data5.brandName = @"brand6";
    data5.storeNumber = 7;
    data5.consumerCount = 10000;
    data5.salesCount = 200000;
    data5.avgConsumerCount = 3000;
    data5.avgSalesCount = 4000;
    
    BrandAnalysisData *data6 = [[[BrandAnalysisData alloc] init] autorelease];
    data6.rankNumber = 6;
    data6.brandName = @"brand7";
    data6.storeNumber = 1;
    data6.consumerCount = 20000;
    data6.salesCount = 300000;
    data6.avgConsumerCount = 4000;
    data6.avgSalesCount = 5000;
    
    BrandAnalysisData *data7 = [[[BrandAnalysisData alloc] init] autorelease];
    data7.rankNumber = 7;
    data7.brandName = @"brand1";
    data7.storeNumber = 2;
    data7.consumerCount = 30000;
    data7.salesCount = 400000;
    data7.avgConsumerCount = 5000;
    data7.avgSalesCount = 6000;
    
    NSArray *array = [[[NSArray alloc] initWithObjects:data1, data2, data3, data4, data5, data6, data7, nil] autorelease];
    self.data = array;
    
}

-(void) initTheTableView
{
    NSArray *titles = [[NSArray alloc] initWithObjects:@"排名", @"品牌名", @"店铺号", @"客流量", @"销售额", @"平均客流量", @"平均销售额", nil];
    NSArray *propertyName = [[NSArray alloc] initWithObjects:@"rankNumber", @"brandName", @"storeNumber", @"consumerCount", @"salesCount", @"avgConsumerCount", @"avgSalesCount", nil];
    self.titleArray = titles;
    self.propertyNames = propertyName;
    [self initWithData];
    
    [titles release];
    [propertyName release];
    
    //初始化表头行的各个数据名目
    titleRowView = [[UIView alloc] initWithFrame:CGRectMake(64, 130, [self.titleArray count] * 90, 50)];
    titleRowView.backgroundColor = [UIColor grayColor];
    for(int i=0;i<[titleArray count];i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10 + 90*i, 10, 70, 30)];
        button.backgroundColor = [UIColor blackColor];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:[self.titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
        button.titleLabel.textAlignment = UITextAlignmentCenter;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        [titleRowView addSubview:button];
        [button release];
    }
    [self.view addSubview:titleRowView];
    
    //每个记录的table
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(64, 180, [self.titleArray count] * 90, 500)];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.rowHeight = 50;
    rightTableView.separatorColor=	[[UIColor alloc] initWithRed:0.337 green:0.337 blue:0.337 alpha:1];
    rightTableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rightTableView];
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTheTableView];
    
    self.navigationController.navigationBarHidden = YES;
    
    //configure the date type of the view
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
    
    [self.pageTitleLabel setText:
     [NSString stringWithFormat:@"%@品牌分析", ((AppDelegate *)[[UIApplication sharedApplication] delegate]).chosenSquare]
     ];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdetify = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdetify] autorelease];
        CGFloat labelLocation = 0;
        int index = 0;
        for (int i = 0; i < [self.titleArray count]; i++)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelLocation, 10, 90, 30)];
            label.backgroundColor = [UIColor blackColor];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = UITextAlignmentCenter;
            label.tag = 100 + index;
            [cell.contentView addSubview:label];
            labelLocation += 90;
            index++;
            [label release];
        }
    }
    
    //设置每一个cell的内容
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    BrandAnalysisData *tempData = (BrandAnalysisData *)[self.data objectAtIndex:indexPath.row];
    label.text = [NSString stringWithFormat:@"%ld", tempData.rankNumber];
    
    label = (UILabel *)[cell.contentView viewWithTag:101];
    tempData = (BrandAnalysisData *)[self.data objectAtIndex:indexPath.row];
    label.text = tempData.brandName;
    
    label = (UILabel *)[cell.contentView viewWithTag:102];
    tempData = (BrandAnalysisData *)[self.data objectAtIndex:indexPath.row];
    label.text = [NSString stringWithFormat:@"%ld", tempData.storeNumber];
    
    label = (UILabel *)[cell.contentView viewWithTag:103];
    tempData = (BrandAnalysisData *)[self.data objectAtIndex:indexPath.row];
    label.text = [NSString stringWithFormat:@"%ld", tempData.consumerCount];
    
    label = (UILabel *)[cell.contentView viewWithTag:104];
    tempData = (BrandAnalysisData *)[self.data objectAtIndex:indexPath.row];
    label.text = [NSString stringWithFormat:@"%f", tempData.salesCount];
    
    label = (UILabel *)[cell.contentView viewWithTag:105];
    tempData = (BrandAnalysisData *)[self.data objectAtIndex:indexPath.row];
    label.text = [NSString stringWithFormat:@"%f", tempData.avgConsumerCount];
    
    label = (UILabel *)[cell.contentView viewWithTag:106];
    tempData = (BrandAnalysisData *)[self.data objectAtIndex:indexPath.row];
    label.text = [NSString stringWithFormat:@"%f", tempData.avgSalesCount];
    
    
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    NSString *brandName = [(UILabel *)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:101] text];
    
    self.navigationController.navigationBarHidden = NO;
    BrandAnalysisDetail *brandAnalysisDetail = [[BrandAnalysisDetail alloc] initWithNibName:@"BrandAnalysisDetail" bundle:nil andTheData:brandName];
    [self.navigationController pushViewController:brandAnalysisDetail animated:YES];
    
    [brandAnalysisDetail release];
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

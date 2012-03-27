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
#import <QuartzCore/QuartzCore.h>

@implementation BrandViewController

@synthesize titleRowView,titleArray, rightTableView, propertyNames, data;

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;

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
    data1.brandName = @"b2";
    data1.storeNumber = 3;
    data1.consumerCount = 4;
    data1.salesCount = 5;
    data1.avgConsumerCount = 6;
    data1.avgSalesCount = 7;
    
    BrandAnalysisData *data2 = [[[BrandAnalysisData alloc] init] autorelease];
    data2.rankNumber = 2;
    data2.brandName = @"b3";
    data2.storeNumber = 4;
    data2.consumerCount = 5;
    data2.salesCount = 6;
    data2.avgConsumerCount = 7;
    data2.avgSalesCount = 1;
    
    BrandAnalysisData *data3 = [[[BrandAnalysisData alloc] init] autorelease];
    data3.rankNumber = 3;
    data3.brandName = @"b4";
    data3.storeNumber = 5;
    data3.consumerCount = 6;
    data3.salesCount = 7;
    data3.avgConsumerCount = 1;
    data3.avgSalesCount = 2;
    
    BrandAnalysisData *data4 = [[[BrandAnalysisData alloc] init] autorelease];
    data4.rankNumber = 4;
    data4.brandName = @"b5";
    data4.storeNumber = 6;
    data4.consumerCount = 7;
    data4.salesCount = 1;
    data4.avgConsumerCount = 2;
    data4.avgSalesCount = 3;
    
    BrandAnalysisData *data5 = [[[BrandAnalysisData alloc] init] autorelease];
    data5.rankNumber = 5;
    data5.brandName = @"b6";
    data5.storeNumber = 7;
    data5.consumerCount = 1;
    data5.salesCount = 2;
    data5.avgConsumerCount = 3;
    data5.avgSalesCount = 4;
    
    BrandAnalysisData *data6 = [[[BrandAnalysisData alloc] init] autorelease];
    data6.rankNumber = 6;
    data6.brandName = @"b7";
    data6.storeNumber = 1;
    data6.consumerCount = 2;
    data6.salesCount = 3;
    data6.avgConsumerCount = 4;
    data6.avgSalesCount = 5;
    
    BrandAnalysisData *data7 = [[[BrandAnalysisData alloc] init] autorelease];
    data7.rankNumber = 7;
    data7.brandName = @"b1";
    data7.storeNumber = 2;
    data7.consumerCount = 3;
    data7.salesCount = 4;
    data7.avgConsumerCount = 5;
    data7.avgSalesCount = 6;
    
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
    titleRowView = [[UIView alloc] initWithFrame:CGRectMake(64, 100, [self.titleArray count] * 90, 50)];
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
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(64, 150, [self.titleArray count] * 90, 500)];
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
    self.navigationItem.title = @"万达集团品牌分析";
    [self initTheTableView];
    
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
	return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
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

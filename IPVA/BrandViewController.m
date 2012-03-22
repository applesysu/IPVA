//
//  BrandAnalysis.m
//  IpvaSheet
//
//  Created by again on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandViewController.h"
#import "BrandAnalysisTitle.h"
#import "BrandAnalysisRecordCell.h"
#import "BrandAnalysisDetail.h"
#import "BrandAnalysisData.h"
#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"

@implementation BrandViewController

@synthesize recordTableView, analysisTitle, data;

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil)
    {
        //初始化title
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BrandAnalysisTitle" owner:self options:nil];
        self.analysisTitle = [array objectAtIndex:0];
        [self.analysisTitle setFrame:CGRectMake(0, 0, 768, 44)];
        [self.view addSubview:self.analysisTitle];
        
        self.recordTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 44, 768, 980) style:UITableViewStylePlain] autorelease];
        [self.recordTableView setDelegate:self];
        [self.recordTableView setDataSource:self];
        [self.view addSubview:self.recordTableView];
        
        [self initWithData];
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

-(void) buttonClick : (id) sender
{
    switch ([(UIButton *)sender tag]) {
        case 1:
        {
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"rankNumber" ascending:YES] autorelease];
            NSArray *array = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
            self.data = sortedArray;
            
            [self.recordTableView reloadData];
        }
            break;
            
        case 2:
        {
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"brandName" ascending:YES] autorelease];
            NSArray *array = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
            self.data = sortedArray;
            
            [self.recordTableView reloadData];
        }
            break;
            
        case 3:
        {
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"storeNumber" ascending:YES] autorelease];
            NSArray *array = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
            self.data = sortedArray;
            
            [self.recordTableView reloadData];
        }
            break;
            
        case 4:
        {
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"consumerCount" ascending:YES] autorelease];
            NSArray *array = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
            self.data = sortedArray;
            
            [self.recordTableView reloadData];
        }
            break;
            
        case 5:
        {
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"salesCount" ascending:YES] autorelease];
            NSArray *array = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
            self.data = sortedArray;
            
            [self.recordTableView reloadData];
        }
            break;
            
        case 6:
        {
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"avgConsumerCount" ascending:YES] autorelease];
            NSArray *array = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
            self.data = sortedArray;
            
            [self.recordTableView reloadData];
        }
            break;
            
        case 7:
        {
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"avgSalesCount" ascending:YES] autorelease];
            NSArray *array = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
            self.data = sortedArray;
            
            [self.recordTableView reloadData];
        }
            break;
    }
}

-(void) bindingActionsForButtons
{
    [self.analysisTitle.rankButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.analysisTitle.brandButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.analysisTitle.storeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.analysisTitle.consumerCountButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.analysisTitle.salesCountButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.analysisTitle.avgConsumerButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.analysisTitle.avgSalesButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self bindingActionsForButtons];
    
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BrandAnalysisRecordCell";
    
    BrandAnalysisRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BrandAnalysisRecordCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    // Configure the cell...
    BrandAnalysisData *cellData = [self.data objectAtIndex:indexPath.row];
    cell.rankNumber.text = [NSString stringWithFormat:@"%ld", cellData.rankNumber];
    cell.brandName.text = cellData.brandName;
    cell.storeCount.text = [NSString stringWithFormat:@"%ld", cellData.storeNumber];
    cell.consumerCount.text = [NSString stringWithFormat:@"%ld", cellData.consumerCount];
    cell.salesCount.text = [NSString stringWithFormat:@"%f", cellData.salesCount];
    cell.avgConsumerCount.text = [NSString stringWithFormat:@"%f", cellData.avgConsumerCount];
    cell.avgSalesCount.text = [NSString stringWithFormat:@"%f", cellData.avgSalesCount];
    
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
    
//    BrandAnalysisRecordCell *cell = (BrandAnalysisRecordCell *)[self tableView:self.recordTableView cellForRowAtIndexPath:indexPath];
    
    
    BrandAnalysisDetail *brandAnalysisDetail = [[BrandAnalysisDetail alloc] initWithNibName:@"BrandAnalysisDetail" bundle:nil];
    [self.navigationController pushViewController:brandAnalysisDetail animated:YES];
    [brandAnalysisDetail release];
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

@end

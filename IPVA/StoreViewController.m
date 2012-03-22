//
//  LeadingStore.m
//  IpvaSheet
//
//  Created by Henry Tse on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StoreViewController.h"
#import "LeadingTitle.h"
#import "LeadingStoreRecordCell.h"
#import "LeadingStoreData.h"
#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"

@implementation StoreViewController

@synthesize recordTableView, leadingStore, data;

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil)
    {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LeadingTitle" owner:self options:nil];
        self.leadingStore = [array objectAtIndex:0];
        [self.leadingStore setFrame:CGRectMake(0, 44, 768, 44)];
        [self.view addSubview:self.leadingStore];
        
        self.recordTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 88, 768, 980) style:UITableViewStylePlain] autorelease];
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
    [self.recordTableView release];
    [self.leadingStore release];
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
    data1.squareName = @"s2";
    data1.consumerCount =  3;
    data1.salesCount = 4;
    
    LeadingStoreData *data2 = [[[LeadingStoreData alloc] init] autorelease];
    data2.rankNumber = 2;
    data2.squareName = @"s3";
    data2.consumerCount =  4;
    data2.salesCount = 1;
    
    LeadingStoreData *data3 = [[[LeadingStoreData alloc] init] autorelease];
    data3.rankNumber = 3;
    data3.squareName = @"s4";
    data3.consumerCount =  1;
    data3.salesCount = 2;
    
    LeadingStoreData *data4 = [[[LeadingStoreData alloc] init] autorelease];
    data4.rankNumber = 4;
    data4.squareName = @"s1";
    data4.consumerCount = 2;
    data4.salesCount = 3;
    
    NSArray *array = [[[NSArray alloc] initWithObjects:data1, data2, data3, data4, nil] autorelease];
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
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"squareName" ascending:YES] autorelease];
            NSArray *array = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
            self.data = sortedArray;
            
            [self.recordTableView reloadData];
        }
            break;
            
        case 3:
        {
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"consumerCount" ascending:YES] autorelease];
            NSArray *array = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
            self.data = sortedArray;
            
            [self.recordTableView reloadData];
        }
            break;
            
        case 4:
        {
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"salesCount" ascending:YES] autorelease];
            NSArray *array = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
            self.data = sortedArray;
            
            [self.recordTableView reloadData];
        }
            break;
    }
}

-(void) bindingActionsForButton
{
    [self.leadingStore.rankButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.leadingStore.squareButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.leadingStore.consumerCountButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.leadingStore.salesCountButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self bindingActionsForButton];
    
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
    
    self.recordTableView = nil;
    self.leadingStore = nil;
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeadingStoreRecordCell";
    
    LeadingStoreRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LeadingStoreRecordCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    // Configure the cell...
    
    LeadingStoreData *cellData = [self.data objectAtIndex:indexPath.row];
    
    cell.rankNumber.text = [NSString stringWithFormat:@"%ld", cellData.rankNumber];
    cell.squareName.text = cellData.squareName;
    cell.consumerCount.text = [NSString stringWithFormat:@"%ld", cellData.consumerCount];
    cell.salesCount.text = [NSString stringWithFormat:@"%f", cellData.salesCount];
    
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

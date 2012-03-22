//
//  BrandAnalysisDetail.m
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandAnalysisDetail.h"
#import "BrandAnalysisDetailTitle.h"
#import "BrandAnalysisDetailRecordCell.h"
#import "BrandAnalysisDetailData.h"

@implementation BrandAnalysisDetail

@synthesize recordTableView, analysisDetailTitle, data;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil)
    {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BrandAnalysisDetailTitle" owner:self options:nil];
        self.analysisDetailTitle = [array objectAtIndex:0];
        [self.analysisDetailTitle setFrame:CGRectMake(0, 0, 768, 44)];
        [self.view addSubview:self.analysisDetailTitle];
        
        self.recordTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 44, 768, 980) style:UITableViewStylePlain] autorelease];
        [self.recordTableView setDelegate:self];
        [self.recordTableView setDataSource:self];
        [self.view addSubview: self.recordTableView];
        
        [self initWithData];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) initWithData
{
    BrandAnalysisDetailData *data1 = [[[BrandAnalysisDetailData alloc] init] autorelease];
    data1.rankNumber = 1;
    data1.squareName = @"s2";
    data1.storeID = 3;
    data1.consumerCount = 4;
    data1.salesCount = 5;
    
    BrandAnalysisDetailData *data2 = [[[BrandAnalysisDetailData alloc] init] autorelease];
    data2.rankNumber = 2;
    data2.squareName = @"s3";
    data2.storeID = 4;
    data2.consumerCount = 5;
    data2.salesCount = 1;
    
    BrandAnalysisDetailData *data3 = [[[BrandAnalysisDetailData alloc] init] autorelease];
    data3.rankNumber = 3;
    data3.squareName = @"s4";
    data3.storeID = 5;
    data3.consumerCount = 1;
    data3.salesCount = 2;
    
    BrandAnalysisDetailData *data4 = [[[BrandAnalysisDetailData alloc] init] autorelease];
    data4.rankNumber = 4;
    data4.squareName = @"s5";
    data4.storeID = 1;
    data4.consumerCount = 2;
    data4.salesCount = 3;
    
    BrandAnalysisDetailData *data5 = [[[BrandAnalysisDetailData alloc] init] autorelease];
    data5.rankNumber = 5;
    data5.squareName = @"s1";
    data5.storeID = 2;
    data5.consumerCount = 3;
    data5.salesCount = 4;
    
    NSArray *array = [[[NSArray alloc] initWithObjects:data1, data2, data3, data4, data5, nil] autorelease];
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
            NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"storeID" ascending:YES] autorelease];
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
    }
}

-(void) bindingTheActionsForButtons
{
    [self.analysisDetailTitle.rankButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.analysisDetailTitle.squareButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.analysisDetailTitle.storeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.analysisDetailTitle.consumerCountButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.analysisDetailTitle.salesCountButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self bindingTheActionsForButtons];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BrandAnalysisDetailRecordCell";
    
    BrandAnalysisDetailRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BrandAnalysisDetailRecordCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    // Configure the cell...
    BrandAnalysisDetailData *cellData = [self.data objectAtIndex:indexPath.row];
    
    cell.rankNumber.text = [NSString stringWithFormat:@"%ld", cellData.rankNumber];
    cell.squareName.text = cellData.squareName;
    cell.storeNumber.text = [NSString stringWithFormat:@"%ld", cellData.storeID];
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

@end

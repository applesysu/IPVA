//
//  AeraPickViewController.m
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AeraPickViewController.h"
#import "AppDelegate.h"

@interface AeraPickViewController ()


@end


@implementation AeraPickViewController

@synthesize aeraArray = _aeraArray;
@synthesize greatArray, segment;

- (void)dealloc
{
    [super dealloc];
    [_aeraArray release];
    [greatArray release];
    [segment release];
}


-(IBAction)toFirst
{
    NSLog(@"hihi");
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _aeraArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"万达广场"], [NSString stringWithFormat:@"华东区"], [NSString stringWithFormat:@"华北区"], [NSString stringWithFormat:@"华南区"], nil];
    
    greatArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"厦门湖里万达广场"],[NSString stringWithFormat:@"福州金融街万达广场"],[NSString stringWithFormat:@"宁波江北万达广场"],[NSString stringWithFormat:@"宁波鄞州万达广场"],[NSString stringWithFormat:@"泰州万达广场"],[NSString stringWithFormat:@"合肥天鹅湖万达广场"],[NSString stringWithFormat:@"石家庄裕华万达广场"],[NSString stringWithFormat:@"天津河东区万达广场"],[NSString stringWithFormat:@"呼和浩特万达广场"],[NSString stringWithFormat:@"包头青山万达广场"],[NSString stringWithFormat:@"济南魏家庄万达广场"],[NSString stringWithFormat:@"武汉经开万达广场"],[NSString stringWithFormat:@"武汉菱角湖万达广场"],[NSString stringWithFormat:@"武汉汉街万达广场"],[NSString stringWithFormat:@"宜昌万达广场"],[NSString stringWithFormat:@"襄阳万达广场"],[NSString stringWithFormat:@"重庆万州万达广场"],[NSString stringWithFormat:@"武汉汉街万达广场"],[NSString stringWithFormat:@"沈阳太原街(城中城)万达广场"],[NSString stringWithFormat:@"沈阳铁西万达广场"],[NSString stringWithFormat:@"长春红旗街万达广场"],[NSString stringWithFormat:@"大庆萨尔图万达广场"],[NSString stringWithFormat:@"合肥包河万达广场"], nil];
    NSLog(@"%@", _aeraArray);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.aeraArray = nil;
    self.greatArray = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    if (self.segment.selectedSegmentIndex == 0)
    {
        return [_aeraArray count];
    }
    else
    {
        return [greatArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"aeraCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    // Configure the cell...
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    if(self.segment.selectedSegmentIndex == 0)
    {
        [[cell textLabel] setText:[_aeraArray objectAtIndex:indexPath.row]];
    }
    else
    {
        [[cell textLabel] setText:[greatArray objectAtIndex:indexPath.row]];
    }

    NSLog(@"%@", cell);
    
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
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).chosenSquare = [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    NSLog(@"%@", ((AppDelegate *)[[UIApplication sharedApplication] delegate]).chosenSquare);
    
    int areaNumber = 0;
    
    if(self.segment.selectedSegmentIndex == 0) 
    {
        areaNumber = [_aeraArray count];
    }
    else
    {
        areaNumber = [greatArray count];
    }
    
    for (int i = 0; i < areaNumber; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if ([cell accessoryType] == UITableViewCellAccessoryCheckmark)
        {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:NO];
    
    if (indexPath.row == 0) {
        id delegate = [[UIApplication sharedApplication] delegate];
        [delegate setTabBarControllerShowHeadOffice:YES];
    } else {
        id delegate = [[UIApplication sharedApplication] delegate];
        [delegate setTabBarControllerShowHeadOffice:NO];
    }
        
}

@end

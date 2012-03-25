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

#import <QuartzCore/QuartzCore.h>

@implementation StoreViewController

@synthesize data;
@synthesize sheetView;
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //生成表视图
    [self initWithData];
    NSArray *titles = [[NSArray alloc] initWithObjects:@"排名", @"广场名称", @"客流量", @"销售额", nil];
    NSArray *propertyNames = [[NSArray alloc] initWithObjects:@"rankNumber", @"squareName", @"consumerCount", @"salesCount", nil];
    self.sheetView = [[StoreSheetView alloc] initWithFrame:CGRectMake(74, 100, 620, 570) andTitles:titles andPropertyname:propertyNames andData:self.data];
    
    [self.view addSubview:self.sheetView];
    
    
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
    
    self.sheetView = nil;
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

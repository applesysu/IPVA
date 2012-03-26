//
//  BrandAnalysisDetail.m
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandAnalysisDetail.h"
#import "BrandAnalysisDetailData.h"
#import "BrandDetailSheetView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BrandAnalysisDetail

@synthesize brandDetailSheetView, data;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTheData:(NSString *)dataName
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil)
    {
        self.navigationItem.title = dataName;
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


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initWithData];
    NSArray *titles = [[NSArray alloc] initWithObjects:@"排名",@"广场名称",@"铺位号",@"客流量",@"销售额", nil];
    NSArray *propertyNames = [[NSArray alloc] initWithObjects:@"rankNumber", @"squareName",@"storeID", @"consumerCount",@"salesCount",nil];
    self.brandDetailSheetView  = [[BrandDetailSheetView alloc] initWithFrame:CGRectMake(50, 50, 700, 500) andTitles:titles andPropertyname:propertyNames andData:self.data];
    [self.view addSubview:brandDetailSheetView];
    
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
	return NO;
}


@end

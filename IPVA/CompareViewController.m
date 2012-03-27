//
//  CompareViewController.m
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CompareViewController.h"

#import "AeraPickViewController.h"
#import "DatePickViewController.h"
#import "CycleViewController.h"
#import "CYCompareGraph.h"

@interface CompareViewController () {
}

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) CYCompareGraph *compareGraph;

@end

@implementation CompareViewController

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;
@synthesize compareView = _compareView;
@synthesize compareGraph = _compareGraph;
@synthesize squareALabel = _squareALabel;
@synthesize squareBLabel = _squareBLabel;
@synthesize squareButton = _squareButton;
@synthesize dataArray = _dataArray;


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (CYCompareGraph *)compareGraph
{
    if (_compareGraph == nil) {
        _compareGraph = [[CYCompareGraph alloc] init];
    }
    return _compareGraph;
}

- (void)dealloc
{
    [_dataArray release];
    [_compareView release];
    [_squareALabel release];
    [_squareBLabel release];
    [_squareButton release];
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
        
        // test data;
        for (int i = 0; i < 5; i++) 
        {
            NSMutableArray *currentArray = [[[NSMutableArray alloc] init] autorelease];
            for (int j = 0;j < 8; j++)
            {
               [currentArray addObject:[NSNumber numberWithDouble:((CGFloat)(arc4random() % 100) / 100)]];
            }
            [self.dataArray addObject:currentArray];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    
    
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
    
    
    
    // configure compare graph
    CYCompareGraph *compareGraph = [[[CYCompareGraph alloc] initWithFrame:CGRectMake(0, 0, 300, 300)] autorelease];
    self.compareGraph = compareGraph;
    
    [self.compareGraph setFirstObjectValuesArray:[self.dataArray objectAtIndex:0]];
    [self.compareGraph setSecondObjectValuesArray:[self.dataArray objectAtIndex:1]];
    
    [self.compareView addSubview:self.compareGraph];

}

- (void)viewDidUnload
{
    [self setCompareView:nil];
    [self setSquareALabel:nil];
    [self setSquareBLabel:nil];
    [self setSquareButton:nil];
    [super viewDidUnload];
    self.aeraPickPopover = nil;
    self.datePickPopover = nil;
    self.dataArray = nil;
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

- (NSMutableArray *)arrayWithCStyleDoubleArray:(double *) array count:(int)count
{
    NSMutableArray *resultArray = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < count; i++) {
        [resultArray addObject:[NSNumber numberWithDouble:array[i]]];
    }
    return resultArray;
}

- (IBAction)pressSquareButton:(id)sender {
    static int lastButtonID = 1;
    if ([(UIButton *)sender isSelected])
        return;

    for (UIButton *button in self.squareButton)
    {
        [button setSelected:NO];
    }
    [[self.squareButton objectAtIndex:lastButtonID] setSelected:YES];
    [self.squareALabel setText:[[[self.squareButton objectAtIndex:lastButtonID] titleLabel] text]];
    [self.compareGraph setFirstObjectValuesArray:[self.dataArray objectAtIndex:lastButtonID]];
    
    [[self.squareButton objectAtIndex:([sender tag] - 10)] setSelected:YES];
    [self.squareBLabel setText:[[[self.squareButton objectAtIndex:([sender tag] - 10)] titleLabel] text]];
    [self.compareGraph setSecondObjectValuesArray:[self.dataArray objectAtIndex:([sender tag] - 10)]];


    
    lastButtonID = [sender tag] - 10;
    [self.compareGraph setNeedsDisplay];
}

@end

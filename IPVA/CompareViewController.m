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

@interface CompareViewController ()

@end

@implementation CompareViewController

@synthesize aeraPickPopover = _aeraPickPopover;
@synthesize datePickPopover = _datePickPopover;
@synthesize cyclePickPopover = _cyclePickPopover;
@synthesize compareView = _compareView;

- (void)dealloc
{
    [_compareView release];
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

    [self.compareView addSubview:compareGraph];
    

    
    
}

- (void)viewDidUnload
{
    [self setCompareView:nil];
    [super viewDidUnload];
    self.aeraPickPopover = nil;
    self.datePickPopover = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
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

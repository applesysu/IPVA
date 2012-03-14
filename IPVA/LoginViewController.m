//
//  LoginViewController.m
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"


@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize tabBarController = _tabBarController;

- (void)dealloc
{
    [super dealloc];
    [_tabBarController release];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


- (IBAction)pressLoginButton:(id)sender {
    [self.tabBarController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:self.tabBarController animated:YES];
}
@end

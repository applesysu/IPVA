//
//  AppDelegate.m
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"



@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize firstViewController = _firstViewController;
@synthesize trendViewController = _trendViewController;
@synthesize categoryViewController = _categoryViewController;
@synthesize compareViewController = _compareViewController;
@synthesize brandViewController = _brandViewController;
@synthesize storeViewController = _storeViewController;
@synthesize passengerViewController = _passengerViewController;
@synthesize rankViewController = _rankViewController;



- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [_firstViewController release];
    [_trendViewController release];
    [_categoryViewController release];
    [_compareViewController release];
    [_brandViewController release];
    [_storeViewController release];
    [_passengerViewController release];
    [_rankViewController release];

    [super dealloc];
}

- (void)configureViewController;
{
    FirstViewController *fvc = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    self.firstViewController = fvc;
    [fvc release];
    
    TrendViewController *tvc = [[TrendViewController alloc] initWithNibName:@"TrendViewController" bundle:nil];
    self.trendViewController = tvc;
    [tvc release];
    
    CategoryViewController *cavc = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    self.categoryViewController = cavc;
    [cavc release];
    
    CompareViewController *covc = [[CompareViewController alloc] initWithNibName:@"CompareViewController" bundle:nil];
    self.compareViewController = covc;
    [covc release];
    
    BrandViewController *bvc = [[BrandViewController alloc] initWithNibName:@"BrandViewController" bundle:nil];
    self.brandViewController = bvc;
    [bvc release];
    
    StoreViewController *svc = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
    self.storeViewController = svc;
    [svc release];
    
    PassengerViewController *pvc = [[PassengerViewController alloc] initWithNibName:@"PassengerViewController" bundle:nil];
    self.passengerViewController = pvc;
    [pvc release];
    
    RankViewController *rvc = [[RankViewController alloc] initWithNibName:@"RankViewController" bundle:nil];
    self.rankViewController = rvc;
    [rvc release];
     NSLog(@"%@", self.firstViewController);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIViewController *loginViewController = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
    [self.window setRootViewController:loginViewController];
    UITabBarController *tabC = [[UITabBarController alloc] init];
    self.tabBarController = tabC;
    [tabC release];
    [self configureViewController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
                                              
                                              
- (void)setTabBarControllerShowHeadOffice:(BOOL)toggle
{
    if (toggle == YES)
    {
        [self.tabBarController setViewControllers:[NSArray arrayWithObjects:_firstViewController, _trendViewController, _categoryViewController, _compareViewController, _brandViewController, _storeViewController, nil] animated:YES];
        [[[[self.tabBarController tabBar] items] objectAtIndex:0] setTitle:@"概述"];
        [[[[self.tabBarController tabBar] items] objectAtIndex:1] setTitle:@"趋势"];
        [[[[self.tabBarController tabBar] items] objectAtIndex:2] setTitle:@"类别"];
        [[[[self.tabBarController tabBar] items] objectAtIndex:3] setTitle:@"对比"];
        [[[[self.tabBarController tabBar] items] objectAtIndex:4] setTitle:@"品牌"];
        [[[[self.tabBarController tabBar] items] objectAtIndex:5] setTitle:@"主力店"];
        [self.tabBarController setSelectedIndex:0];
    } else {
        [self.tabBarController setViewControllers:[NSArray arrayWithObjects:_firstViewController, _trendViewController, _passengerViewController, _rankViewController, nil] animated:YES];
        [[[[self.tabBarController tabBar] items] objectAtIndex:0] setTitle:@"概述"];
        [[[[self.tabBarController tabBar] items] objectAtIndex:1] setTitle:@"趋势"];
        [[[[self.tabBarController tabBar] items] objectAtIndex:2] setTitle:@"客流"];
        [[[[self.tabBarController tabBar] items] objectAtIndex:3] setTitle:@"排名"];
        [self.tabBarController setSelectedIndex:0];
    }
    
    NSLog(@"%@", self.tabBarController);
    
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end

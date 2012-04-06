//
//  AppDelegate.h
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FirstViewController.h"
#import "TrendViewController.h"
#import "CategoryViewController.h"
#import "CompareViewController.h"
#import "BrandViewController.h"
#import "StoreViewController.h"
#import "PassengerViewController.h"
#import "RankViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) FirstViewController *firstViewController;
@property (strong, nonatomic) TrendViewController *trendViewController;
@property (strong, nonatomic) CategoryViewController *categoryViewController;
@property (strong, nonatomic) CompareViewController *compareViewController;
@property (strong, nonatomic) BrandViewController *brandViewController;
@property (strong, nonatomic) StoreViewController *storeViewController;
@property (strong, nonatomic) PassengerViewController *passengerViewController;
@property (strong, nonatomic) RankViewController *rankViewController;

@property (strong, nonatomic) NSString *chosenSquare;

- (void) setTabBarControllerShowHeadOffice:(BOOL) toggle;

@end

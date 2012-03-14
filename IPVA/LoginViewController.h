//
//  LoginViewController.h
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITabBarController *tabBarController;

- (IBAction)pressLoginButton:(id)sender;

@end

//
//  AeraPickViewController.h
//  IPVA
//
//  Created by Lancy on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AeraPickViewController : UITableViewController

@property (nonatomic, retain) NSArray *aeraArray;
@property (nonatomic, retain) NSArray *greatArray;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segment;

@end

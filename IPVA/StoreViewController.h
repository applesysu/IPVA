//
//  LeadingStore.h
//  IpvaSheet
//
//  Created by Henry Tse on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeadingTitle;

@interface StoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>
{
    UITableView *recordTableView;
    LeadingTitle *leadingSotre;
    NSArray *data;
}

@property (nonatomic, retain) UITableView *recordTableView;
@property (nonatomic, retain) LeadingTitle *leadingStore;
@property (nonatomic, retain) NSArray *data;

@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

-(void) initWithData;

@end

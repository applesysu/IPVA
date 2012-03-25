//
//  BrandAnalysis.h
//  IpvaSheet
//
//  Created by again on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandSheetView;

@interface BrandViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate>
{
    NSArray *data;
}

@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) UITableView *rightTableView;
@property (nonatomic, retain) NSArray *titleArray;
@property (nonatomic, retain) NSArray *propertyNames;
@property (nonatomic, retain) UIView *titleRowView;

@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

-(void) initWithData;
-(void) buttonClick:(id) sender;

@end

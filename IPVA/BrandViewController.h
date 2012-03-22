//
//  BrandAnalysis.h
//  IpvaSheet
//
//  Created by again on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandAnalysisTitle;

@interface BrandViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>
{
    UITableView *recordTableView;
    BrandAnalysisTitle *analysisTitle;
    NSArray *data;
}

@property (nonatomic, retain) UITableView *recordTableView;
@property (nonatomic, retain) BrandAnalysisTitle *analysisTitle;
@property (nonatomic, retain) NSArray *data;

@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

-(void) initWithData;

@end

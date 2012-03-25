//
//  LeadingStore.h
//  IpvaSheet
//
//  Created by Henry Tse on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreSheetView;

@interface StoreViewController : UIViewController <UIPopoverControllerDelegate>
{
    NSArray *data;
    StoreSheetView *sheetView;
}

@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) StoreSheetView *sheetView;
@property (nonatomic, retain) UIPopoverController *aeraPickPopover;
@property (nonatomic, retain) UIPopoverController *datePickPopover;
@property (nonatomic, retain) UIPopoverController *cyclePickPopover;

- (IBAction)pressAeraButton:(id)sender;
- (IBAction)pressDateButton:(id)sender;
- (IBAction)pressCycleButton:(id)sender;

-(void) initWithData;

@end

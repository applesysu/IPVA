//
//  BrandAnalysisDetail.h
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandDetailSheetView;

@interface BrandAnalysisDetail : UIViewController

@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) BrandDetailSheetView *brandDetailSheetView;

@property (nonatomic, retain) IBOutlet UILabel *pageTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

-(void) initWithData;
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTheData:(NSString *)dataName;

@end

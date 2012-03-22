//
//  BrandAnalysisDetail.h
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandAnalysisDetailTitle;

@interface BrandAnalysisDetail : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *recordTableView;
    BrandAnalysisDetailTitle *analysisDetailTitle;
    NSArray *data;
}

@property (nonatomic, retain) UITableView *recordTableView;
@property (nonatomic, retain) BrandAnalysisDetailTitle *analysisDetailTitle;
@property (nonatomic, retain) NSArray *data;

-(void) initWithData;

@end

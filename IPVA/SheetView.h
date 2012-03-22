//
//  SheetView.h
//  IPVA
//
//  Created by Henry Tse on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetView : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
	UIScrollView *leftScrollView;
	UIScrollView *rightScrollView;
	
	UITableView *leftTableView;
	UITableView *rightTableView;
	
	NSArray *titleArray;
    NSArray *nameLabels;
	
	UIView *view2;
	
}

@property (nonatomic, retain) UIScrollView *leftScrollView;
@property (nonatomic, retain) UIScrollView *rightScrollView;
@property (nonatomic, retain) UITableView *leftTableView;
@property (nonatomic, retain) UITableView *rightTableView;
@property (nonatomic, retain) NSArray *titleArray;
@property (nonatomic, retain) NSArray *nameLabels;
@property (nonatomic, retain) UIView *view2;

-(id) initWithFrame:(CGRect)frame andTitles:(NSArray *) titles andNamelabels:(NSArray *) namelabels;

@end

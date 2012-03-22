//
//  tableViewController.h
//  table
//
//  Created by zengwu on 10-11-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
	UIScrollView *leftScrollView;
	UIScrollView *rightScrollView;
	
	UITableView *leftTableView;
	UITableView *rightTableView;
	
	NSArray *titleArray;
	
	UIView *view2;
	
}

@property (nonatomic, retain) UIScrollView *leftScrollView;
@property (nonatomic, retain) UIScrollView *rightScrollView;
@property (nonatomic, retain) UITableView *leftTableView;
@property (nonatomic, retain) UITableView *rightTableView;
@property (nonatomic, retain) NSArray *titleArray;
@property (nonatomic, retain) UIView *view2;

@end


//
//  RankSheetView.h
//  IPVA
//
//  Created by Henry Tse on 12-3-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankSheetView : UIView<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *leftScrollView;
@property (nonatomic, retain) UIScrollView *rightScrollView;
@property (nonatomic, retain) UITableView *leftTableView;
@property (nonatomic, retain) UITableView *rightTableView;
@property (nonatomic, retain) NSArray *titleArray;
@property (nonatomic, retain) NSArray *nameLabels;
@property (nonatomic, retain) UIView *titleRowView;
@property (nonatomic, retain) NSArray *datas;

-(id) initWithFrame:(CGRect)frame andTitles:(NSArray *) titles andNamelabels:(NSArray *) namelabels andDatas:(NSArray *)mydata;

@end

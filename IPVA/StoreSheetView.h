//
//  SortSheetView.h
//  IPVA
//
//  Created by Henry Tse on 12-3-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreSheetView : UIView <UITableViewDelegate, UITableViewDataSource>
{
	UITableView *rightTableView;
	NSArray *titleArray;
    NSArray *propertyNames;
	UIView *titleRowView;
	NSArray *data;
}

@property (nonatomic, retain) UITableView *rightTableView;
@property (nonatomic, retain) NSArray *titleArray;
@property (nonatomic, retain) NSArray *propertyNames;
@property (nonatomic, retain) UIView *titleRowView;
@property (nonatomic, retain) NSArray *data;

-(id) initWithFrame:(CGRect)frame andTitles:(NSArray *) titles andPropertyname:(NSArray *) propertyName andData:(NSArray *)mydata;
-(void) buttonClick:(id) sender;

@end

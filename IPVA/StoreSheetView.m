//
//  SortSheetView.m
//  IPVA
//
//  Created by Henry Tse on 12-3-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StoreSheetView.h"
#import "LeadingStoreData.h"

#import <QuartzCore/QuartzCore.h>

@implementation StoreSheetView

@synthesize rightTableView, titleArray, titleRowView, propertyNames, data;

- (id)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andPropertyname:(NSArray *)propertyName andData:(NSArray *)mydata
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //得到需要的表头项和每行要求显示的项目
        self.titleArray = titles;
        self.propertyNames = propertyName;
        self.data = mydata;
        
        //初始化表头行的各个数据名目
        titleRowView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, [self.titleArray count] * 150, 50)];
        titleRowView.backgroundColor = [UIColor grayColor];
        
        for(int i = 0;i < [titleArray count];i++)
        {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10 + 150*i, 10, 130, 30)];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
            [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = UITextAlignmentCenter;
            button.backgroundColor = [UIColor blackColor];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
            [titleRowView addSubview:button];
            [button release];
        }
        [self addSubview:titleRowView];
        
        //每个记录的table
        rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 60, [self.titleArray count] * 150, 500)];
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        rightTableView.rowHeight = 50;
        rightTableView.separatorColor=	[[UIColor alloc] initWithRed:0.337 green:0.337 blue:0.337 alpha:1];
        rightTableView.backgroundColor = [UIColor blackColor];
        [self addSubview:rightTableView];
        
    }
    return self;
}

-(void) buttonClick:(id)sender
{
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:[self.propertyNames objectAtIndex:[(UIButton *)sender tag]] ascending:YES] autorelease];
    NSArray *array = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [self.data sortedArrayUsingDescriptors:array];
    self.data = sortedArray;
    
    [self.rightTableView reloadData];
}


#pragma mark 
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	 return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
		static NSString *cellIdetify = @"cell1";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
		if(!cell)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdetify] autorelease];
            CGFloat labelLocation = 0;
            int index = 0;
            for (int i = 0; i < [self.titleArray count]; i++)
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelLocation, 10, 150, 30)];
                label.backgroundColor = [UIColor blackColor];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = UITextAlignmentCenter;
                label.tag = 100 + index;
                [cell.contentView addSubview:label];
                labelLocation += 150;
                index++;
                [label release];
            }
		}
		
        //设置每一个cell的内容
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    LeadingStoreData *tempData = (LeadingStoreData *)[self.data objectAtIndex:indexPath.row];
    label.text = [NSString stringWithFormat:@"%ld", tempData.rankNumber];
    
    label = (UILabel *)[cell.contentView viewWithTag:101];
    tempData = (LeadingStoreData *)[self.data objectAtIndex:indexPath.row];
    label.text = tempData.squareName;
    
    label = (UILabel *)[cell.contentView viewWithTag:102];
    tempData = (LeadingStoreData *)[self.data objectAtIndex:indexPath.row];
    label.text = [NSString stringWithFormat:@"%ld", tempData.consumerCount];
    
    label = (UILabel *)[cell.contentView viewWithTag:103];
    tempData = (LeadingStoreData *)[self.data objectAtIndex:indexPath.row];
    label.text = [NSString stringWithFormat:@"%f", tempData.salesCount];
		
		return cell;
	
}


@end

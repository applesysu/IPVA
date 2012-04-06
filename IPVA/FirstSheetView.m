//
//  FirstSheetView.m
//  IPVA
//
//  Created by Henry Tse on 12-3-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstSheetView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@implementation FirstSheetView

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
        titleRowView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, [self.titleArray count] * 110, 50)];
        titleRowView.backgroundColor = [UIColor grayColor];
        
        int buttonLoaction = 10;
        for(int i = 0;i < [titleArray count];i++)
        {
            UIButton *button;
            if (i != 1)
            {
                button = [[UIButton alloc] initWithFrame:CGRectMake(buttonLoaction +30, 10, 60, 30)];
                buttonLoaction += 100;
            }
            else
            {
                button = [[UIButton alloc] initWithFrame:CGRectMake(buttonLoaction+ 40, 10, 90, 30)];
                buttonLoaction += 150;
            }
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
            [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = UITextAlignmentCenter;
            button.backgroundColor = [UIColor blackColor];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
            [titleRowView addSubview:button];
            [button setEnabled:NO];
            [button release];
        }
        [self addSubview:titleRowView];
        
        //每个记录的table
        rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 60, [self.titleArray count] * 110, 500)];
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
            UILabel *label;
            
            if (i != 1)
            {
                label = [[UILabel alloc] initWithFrame:CGRectMake(labelLocation, 10, 110, 30)];
                labelLocation += 110;
            }
            else
            {
                label = [[UILabel alloc] initWithFrame:CGRectMake(labelLocation, 10, 180, 30)];
                labelLocation += 180;
            }
            label.backgroundColor = [UIColor blackColor];
            label.textColor = [UIColor whiteColor];
            label.tag = 100 + index;
            [cell.contentView addSubview:label];
            
            index++;
            [label release];
        }
    }
    
    //设置每一个cell的内容
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    label.text = [NSString stringWithFormat:@"%d", indexPath.row+1];
    label.textAlignment = UITextAlignmentCenter;
    
    label = (UILabel *)[cell.contentView viewWithTag:101];
    label.text = [self.data objectAtIndex:indexPath.row];
    label.textAlignment = UITextAlignmentLeft;
    
    return cell;
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).chosenSquare = [self.data objectAtIndex:indexPath.row];
    
    for (int i = 0; i < [self.data count]; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [self.rightTableView cellForRowAtIndexPath:indexPath];
        if ([cell accessoryType] == UITableViewCellAccessoryCheckmark)
        {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    [[self.rightTableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    [[self.rightTableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:NO];
    
    if (indexPath.row == 0) {
        id delegate = [[UIApplication sharedApplication] delegate];
        [delegate setTabBarControllerShowHeadOffice:YES];
    } else {
        id delegate = [[UIApplication sharedApplication] delegate];
        [delegate setTabBarControllerShowHeadOffice:NO];
    }

}


@end

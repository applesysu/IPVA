//
//  SheetView.m
//  IPVA
//
//  Created by Henry Tse on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SheetView.h"

@implementation SheetView

@synthesize leftTableView, leftScrollView, rightTableView, rightScrollView, titleArray, titleRowView, nameLabels;

- (id)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andNamelabels:(NSArray *)namelabelarray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //得到需要的表头项和每行要求显示的项目
        titleArray = titles;
        self.nameLabels = namelabelarray;
        
        //初始化表头项
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 80, 50)];
        titleView.backgroundColor = [UIColor grayColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = [self.nameLabels objectAtIndex:0];
        [titleView addSubview:titleLabel];
        [self addSubview:titleView];
        [titleLabel release];
        [titleView release];
        
        //初始化表头行的各个数据名目
        titleRowView = [[UIView alloc] initWithFrame:CGRectMake(80, 30, self.frame.size.width- 80, 50)];
        titleRowView.backgroundColor = [UIColor grayColor];
        for(int i=0;i<[titleArray count];i++)
        {
            UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(80*i, 10, 80, 30)];
            tmpLabel.backgroundColor = [UIColor clearColor];
            tmpLabel.font = [UIFont systemFontOfSize:15];
            tmpLabel.text = [titleArray objectAtIndex:i];
            tmpLabel.textAlignment = UITextAlignmentCenter;
            [titleRowView addSubview:tmpLabel];
            [tmpLabel release];
        }
        [self addSubview:titleRowView];
        
        //这里使用了两个不能滚动的tableView，把他们加到两个scrollView上
        leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, frame.size.width, ([self.nameLabels count]-1)*50)];
        leftScrollView.backgroundColor = [UIColor whiteColor];
        leftScrollView.bounces = YES;
        
        rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(80, 0, frame.size.width-80, ([self.nameLabels count]-1)*50)];
        rightScrollView.backgroundColor = [UIColor grayColor];
        rightScrollView.alwaysBounceHorizontal = FALSE;
        rightScrollView.bounces = YES;
        rightScrollView.delegate = self;
        rightScrollView.directionalLockEnabled = YES;
        
        [self addSubview:leftScrollView];
        [leftScrollView addSubview:rightScrollView];
        rightScrollView.directionalLockEnabled = YES;
        
        //设置两个scrollView所包含的内容的位置大小
        leftScrollView.contentSize = CGSizeMake(self.frame.size.width, ([self.nameLabels count] -1)*50);
        rightScrollView.contentSize = CGSizeMake([self.titleArray count] * 80, ([self.nameLabels count] -1)*50);
        rightScrollView.directionalLockEnabled = YES;
        
        //每个对比项的项目的table
        leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, [self.nameLabels count]*50)];
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        leftTableView.rowHeight = 50;
        leftTableView.scrollEnabled = NO;
        leftTableView.alwaysBounceHorizontal = FALSE;
        leftTableView.bounces = NO;
        [leftScrollView addSubview:leftTableView];
        leftTableView.backgroundColor = [UIColor blackColor];
        leftTableView.separatorColor=	[[UIColor alloc] initWithRed:0.337 green:0.337 blue:0.337 alpha:1];
        
        //每个记录的table
        rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [self.titleArray count] * 80, ([self.nameLabels count]-1)*50)];
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        rightTableView.rowHeight = 50;
        rightTableView.scrollEnabled = NO;
        rightTableView.bounces = NO;
        rightTableView.alwaysBounceHorizontal = NO;
        [rightScrollView addSubview:rightTableView];
        rightTableView.separatorColor=	[[UIColor alloc] initWithRed:0.337 green:0.337 blue:0.337 alpha:1];
        rightTableView.backgroundColor = [UIColor blackColor];
    }
    return self;
}

#pragma mark Scroll View Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	//重新布局表头行
	titleRowView.frame = CGRectMake(80, 30, self.frame.size.width - 80, 50);
	titleRowView.bounds = CGRectMake(scrollView.contentOffset.x, 0, self.frame.size.width - 80, 50);
	titleRowView.clipsToBounds = YES;	
	titleRowView.backgroundColor = [UIColor grayColor];
	[self addSubview:titleRowView];
    
	rightScrollView.frame =CGRectMake(80, 0, self.frame.size.width - 80, ([self.nameLabels count] - 1) *50); 
	[leftScrollView addSubview:rightScrollView];
	
	rightTableView.frame = CGRectMake(0, 0, [self.titleArray count] * 80,([self.nameLabels count] - 1) * 50);
	[rightScrollView addSubview:rightTableView];
	leftTableView.frame = CGRectMake(0, 0, 80, ([self.nameLabels count] - 1) * 50);
	[leftScrollView addSubview:leftTableView];
	
	[rightTableView reloadData];
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:0.0];
	titleRowView.frame = CGRectMake(80, 30, self.frame.size.width - 80, 50);
	titleRowView.bounds = CGRectMake(scrollView.contentOffset.x, 0, self.frame.size.width - 80, 50);
	titleRowView.clipsToBounds = YES;
	[self addSubview:titleRowView];
	[UIView commitAnimations];
	
}
//防止滑动过程中锁定方向不让滑动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if(!decelerate)
		[self scrollViewDidEndDecelerating:scrollView];
}




#pragma mark 
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [self.nameLabels count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView == leftTableView)
	{
		static NSString *cellIdetify = @"cell1";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
		if(!cell)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdetify] autorelease];
		}
		
        //设置每行头的内容
		cell.textLabel.text = [self.nameLabels objectAtIndex:indexPath.row + 1];
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.backgroundColor = [UIColor clearColor];
        
		return cell;
	}
	else {
		static NSString *cellIdetify = @"cell2";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
		if(!cell)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdetify] autorelease];
            CGFloat labelLocation = 0;
            int index = 0;
            for (int i = 0; i < [self.titleArray count]; i++)
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelLocation, 10, 80, 30)];
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = UITextAlignmentCenter;
                label.tag = 100 + index;
                [cell.contentView addSubview:label];
                labelLocation += 80;
                index++;
                [label release];
            }
		}
		
        //设置每一个cell的内容
        for (int i  =0; i < [self.titleArray count]; i++)
        {
            UILabel *label = (UILabel *)[cell.contentView viewWithTag:(100+i)];
            label.text = [self.titleArray objectAtIndex:i];
        }
		
		return cell;
	}
	
}

@end

//
//  SheetView.m
//  IPVA
//
//  Created by Henry Tse on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SheetView.h"

@implementation SheetView

@synthesize leftTableView, leftScrollView, rightTableView, rightScrollView, titleArray, view2, nameLabels;

- (id)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andNamelabels:(NSArray *)namelabelarray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 80, 50)];
        view1.backgroundColor = [UIColor grayColor];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.text = [namelabelarray objectAtIndex:0];
        [view1 addSubview:nameLabel];
        [nameLabel release];
        [self addSubview:view1];
        
        titleArray = titles;
        self.nameLabels = namelabelarray;
        
        view2 = [[UIView alloc] initWithFrame:CGRectMake(80, 30, 620, 50)];
        view2.backgroundColor = [UIColor grayColor];
        for(int i=0;i<[titleArray count];i++)
        {
            UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(80*i, 10, 80, 30)];
            tmpLabel.backgroundColor = [UIColor clearColor];
            tmpLabel.font = [UIFont systemFontOfSize:15];
            tmpLabel.text = [titleArray objectAtIndex:i];
            tmpLabel.textAlignment = UITextAlignmentCenter;
            [view2 addSubview:tmpLabel];
            [tmpLabel release];
        }
        [self addSubview:view2];
        
        leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, 700, 200)];
        leftScrollView.backgroundColor = [UIColor whiteColor];
        leftScrollView.bounces = NO;
        rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(80, 0, 700-80, 200)];
        rightScrollView.backgroundColor = [UIColor grayColor];
        rightScrollView.alwaysBounceHorizontal = FALSE;
        rightScrollView.bounces = NO;
        rightScrollView.delegate = self;
        
        [self addSubview:leftScrollView];
        [leftScrollView addSubview:rightScrollView];
        
        rightScrollView.directionalLockEnabled = YES;
        
        
        leftScrollView.contentSize = CGSizeMake(320, 200);
        rightScrollView.contentSize = CGSizeMake(640, 200);
        rightScrollView.directionalLockEnabled = YES;
        
        
        leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, 200)];
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        leftTableView.rowHeight = 50;
        leftTableView.scrollEnabled = NO;
        leftTableView.alwaysBounceHorizontal = FALSE;
        leftTableView.bounces = NO;
        [leftScrollView addSubview:leftTableView];
        leftTableView.backgroundColor = [UIColor blackColor];
        leftTableView.separatorColor=	[[UIColor alloc] initWithRed:0.337 green:0.337 blue:0.337 alpha:1];
        
        rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 880, 200)];
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        rightTableView.rowHeight = 50;
        rightTableView.scrollEnabled = NO;
        rightTableView.bounces = NO;
        rightTableView.alwaysBounceHorizontal = FALSE;
        [rightScrollView addSubview:rightTableView];
        rightTableView.separatorColor=	[[UIColor alloc] initWithRed:0.337 green:0.337 blue:0.337 alpha:1];
        rightTableView.backgroundColor = [UIColor blackColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	//重新布下局
	view2.frame = CGRectMake(80, 30, 640, 50);
	view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, 640, 50);
	view2.clipsToBounds = YES;	
	view2.backgroundColor = [UIColor grayColor];
	//view2.frame = CGRectMake(0, 0 , 960 , contentHeight);
	[self addSubview:view2];
	rightScrollView.frame =CGRectMake(80, 0, self.frame.size.width - 80, 200); 
	[leftScrollView addSubview:rightScrollView];
	
	
	rightTableView.frame = CGRectMake(0, 0, 640,200);
	[rightScrollView addSubview:rightTableView];
	leftTableView.frame = CGRectMake(0, 0, 80, 200);
	[leftScrollView addSubview:leftTableView];
	
	[rightTableView reloadData];
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:0.0];
	view2.frame = CGRectMake(80, 30, 640, 50);
	view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, 640, 50);
	view2.clipsToBounds = YES;
	[self addSubview:view2];
	[UIView commitAnimations];
	
}



//这里应用另一个思路，就是左右滑动的时候，view2不必要加到ScrollView上面，用一个动画改变它的位置即可
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
	NSLog(@"scrollView.contentOffset.x = %f",scrollView.contentOffset.x);
    if(scrollView.contentOffset.x)
        
        [UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:0.0];
	view2.frame = CGRectMake(80, 30, 640, 50);
	view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, 640, 50);
	view2.clipsToBounds = YES;
	[self addSubview:view2];
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
	return [nameLabels count] - 1;
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
		
		cell.textLabel.text = [self.nameLabels objectAtIndex:indexPath.row + 1];
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.backgroundColor = [UIColor clearColor];
		return cell;
	}
	else {
		static NSString *cellIdetify = @"cell1";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
		UILabel *label1 = nil;
		UILabel *label2 = nil;
		UILabel *label3 = nil;
		UILabel *label4 = nil;
		UILabel *label5 = nil;
		UILabel *label6 = nil;
		UILabel *label7 = nil;
		UILabel *label8 = nil;
		if(!cell)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdetify] autorelease];
            
			label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 80, 30)];
			label1.backgroundColor = [UIColor clearColor];
			label1.textColor = [UIColor whiteColor];
			label1.textAlignment = UITextAlignmentCenter;
			label1.tag = 101;
			[cell.contentView addSubview:label1];
			
			label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 80, 30)];
			label2.backgroundColor = [UIColor clearColor];
			label2.textColor = [UIColor whiteColor];
			label2.textAlignment = UITextAlignmentCenter;
			label2.tag = 102;
			[cell.contentView addSubview:label2];
			
		    label3 = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 80, 30)];
			label3.backgroundColor = [UIColor clearColor];
			label3.textColor = [UIColor whiteColor];
			label3.textAlignment = UITextAlignmentCenter;
			label3.tag = 103;
			[cell.contentView addSubview:label3];
			
			label4 = [[UILabel alloc] initWithFrame:CGRectMake(240, 10, 80, 30)];
			label4.backgroundColor = [UIColor clearColor];
			label4.textColor = [UIColor whiteColor];
			label4.textAlignment = UITextAlignmentCenter;
			label4.tag = 104;
			[cell.contentView addSubview:label4];
			
			label5 = [[UILabel alloc] initWithFrame:CGRectMake(320, 10, 80, 30)];
			label5.backgroundColor = [UIColor clearColor];
			
			label5.textAlignment = UITextAlignmentCenter;
			label5.textColor = [UIColor whiteColor];
			label5.tag = 105;
			[cell.contentView addSubview:label5];
			
			label6 = [[UILabel alloc] initWithFrame:CGRectMake(400, 10, 80, 30)];
			label6.backgroundColor = [UIColor clearColor];
			label6.textColor = [UIColor whiteColor];
			label6.textAlignment = UITextAlignmentCenter;
			label6.tag = 106;
			[cell.contentView addSubview:label6];
			
			label7 = [[UILabel alloc] initWithFrame:CGRectMake(480, 10, 80, 30)];
			label7.backgroundColor = [UIColor clearColor];
			label7.textColor = [UIColor whiteColor];
			label7.textAlignment = UITextAlignmentCenter;
			label7.tag = 107;
			[cell.contentView addSubview:label7];
			
			label8 = [[UILabel alloc] initWithFrame:CGRectMake(560, 10, 80, 30)];
			label8.backgroundColor = [UIColor clearColor];
			label8.textColor = [UIColor whiteColor];
			label8.textAlignment = UITextAlignmentCenter;
			label8.tag = 108;
			[cell.contentView addSubview:label8];
		}
		
		label1 = (UILabel *)[cell.contentView viewWithTag:101];
		label1.text = [titleArray objectAtIndex:0];
		
		label2 = (UILabel *)[cell.contentView viewWithTag:102];
		label2.text = [titleArray objectAtIndex:1];
		
		label3 = (UILabel *)[cell.contentView viewWithTag:103];
		label3.text = [titleArray objectAtIndex:2];
		
		label4 = (UILabel *)[cell.contentView viewWithTag:104];
		label4.text = [titleArray objectAtIndex:3];
		
		label5 = (UILabel *)[cell.contentView viewWithTag:105];
		label5.text = [titleArray objectAtIndex:4];
		
		label6 = (UILabel *)[cell.contentView viewWithTag:106];
		label6.text = [titleArray objectAtIndex:5];
		
		label7 = (UILabel *)[cell.contentView viewWithTag:107];
		label7.text = [titleArray objectAtIndex:6];
		
		label8 = (UILabel *)[cell.contentView viewWithTag:108];
		label8.text = [titleArray objectAtIndex:7];
		
		return cell;
	}
	
}

@end

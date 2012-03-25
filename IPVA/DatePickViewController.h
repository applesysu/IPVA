//
//  DatePickViewController.h
//  IPVA
//
//  Created by Lancy on 12-3-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"




@interface DatePickViewController : UIViewController <TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource> {
	TKCalendarMonthView *calendar;	
}

@property (nonatomic, retain) TKCalendarMonthView *calendar;

- (void)toggleCalendar;

@end

//
//  IpvaSheetData.h
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IpvaSheetData : NSObject
{
    long rankNumber;
    NSString *squareName;
    long consumerCount;
    float salesCount;
    NSString *weather;
    NSString *activity;
}

@property (nonatomic, assign) long rankNumber;
@property (nonatomic, retain) NSString *squareName;
@property (nonatomic, assign) long consumerCount;
@property (nonatomic, assign) float salesCount;
@property (nonatomic, retain) NSString *weather;
@property (nonatomic, retain) NSString *activity;

@end

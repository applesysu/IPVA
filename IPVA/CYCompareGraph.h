//
//  CYCompareGraph.h
//  IPVA
//
//  Created by Lancy on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CYCompareGraph : UIView {
    CGPoint center;
    CGFloat radious;
    NSInteger edges;
    CGFloat width;
    CGColorRef polygonColor;
    CGColorRef firstObjectColor;
    CGColorRef secondObjectColor;
    NSInteger maxValue;
    NSInteger *firstObjectValuesArray;
    NSInteger *secondObjectValuesArray;
}

@property CGPoint center;
@property CGFloat radious;
@property NSInteger edges;
@property CGFloat width;
@property CGColorRef polygonColor;
@property CGColorRef firstObjectColor;
@property CGColorRef secondObjectColor;
@property NSInteger maxValue;
@property NSInteger *firstObjectValuesArray;
@property NSInteger *secondObjectValuesArray;

@end

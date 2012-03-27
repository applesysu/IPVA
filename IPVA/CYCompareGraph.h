//
//  CYCompareGraph.h
//  IPVA
//
//  Created by Lancy on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CYCompareGraph : UIView {
    
}

@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat radious;
@property (nonatomic) NSInteger edges;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGColorRef polygonColor;
@property (nonatomic) CGColorRef firstObjectColor;
@property (nonatomic) CGColorRef secondObjectColor;
@property (nonatomic) NSInteger maxValue;
@property (nonatomic, retain)NSMutableArray *firstObjectValuesArray;
@property (nonatomic, retain)NSMutableArray *secondObjectValuesArray;

@end

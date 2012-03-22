//
//  BrandAnalysisData.h
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandAnalysisData : NSObject
{
    long rankNumber;
    NSString *brandName;
    long storeNumber;
    long consumerCount;
    float salesCount;
    float avgConsumerCount;
    float avgSalesCount;
}

@property (nonatomic, assign) long rankNumber;
@property (nonatomic, retain) NSString *brandName;
@property (nonatomic, assign) long storeNumber;
@property (nonatomic, assign) long consumerCount;
@property (nonatomic, assign) float salesCount;
@property (nonatomic, assign) float avgConsumerCount;
@property (nonatomic, assign) float avgSalesCount;

@end

//
//  LeadingStoreData.h
//  IpvaSheet
//
//  Created by again on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeadingStoreData : NSObject
{
    long rankNumber;
    NSString *squareName;
    long consumerCount;
    float salesCount;
}

@property (nonatomic, assign) long rankNumber;
@property (nonatomic, retain) NSString *squareName;
@property (nonatomic, assign) long consumerCount;
@property (nonatomic, assign) float salesCount;

@end

//
//  CYCompareGraph.m
//  IPVA
//
//  Created by Lancy on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "CYCompareGraph.h"

void drawStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, 
                CGColorRef color, CGFloat width);
void drawPolygon(CGContextRef context, CGPoint center, CGFloat radious, NSInteger edges, NSInteger maxValue, CGColorRef color, CGFloat width);
void drawValueGraph(CGContextRef context, CGPoint center, NSInteger *valueArray, CGFloat radious, NSInteger edges, NSInteger maxValue, CGColorRef color, CGFloat width);



@implementation CYCompareGraph
@synthesize center, radious, edges, width, polygonColor, firstObjectColor, secondObjectColor, maxValue;
//@synthesize firstObjectValuesArray, secondObjectValuesArray;

- (void)dealloc
{
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        radious = 150;
        center = CGPointMake(150, 150);
        edges = 8;
        width = 3;
        maxValue = 3;
        polygonColor = [[UIColor grayColor] CGColor];
        firstObjectColor = [[UIColor redColor] CGColor];
        secondObjectColor = [[UIColor blueColor] CGColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(ctx, self.bounds);
    
    //    drawPolygon(ctx, 100, 8, 5, [[UIColor yellowColor] CGColor], 2.0);
    //    
    for (int i = 0; i < 8; i++) {
        firstObjectValuesArray[i] = i % 4;
        secondObjectValuesArray[i] = (i + 1) % 4;
    }
    //    
    //    drawValueGraph(ctx, firstObjectValueArray, 100, 8, 5, [[UIColor redColor] CGColor], 2.0);
    //    drawValueGraph(ctx, secondObjectValueArray, 100, 8, 5, [[UIColor blueColor] CGColor], 2.0);
    
    
    drawPolygon(ctx, center, radious, edges, maxValue, polygonColor, width);
    drawValueGraph(ctx, center, firstObjectValuesArray, radious, edges, maxValue, firstObjectColor, width);
    drawValueGraph(ctx, center, secondObjectValuesArray, radious, edges, maxValue, secondObjectColor, width);
    
    
    
}

#pragma mark - drawMethods
void drawValueGraph(CGContextRef context, CGPoint center, NSInteger *valueArray, CGFloat radious, NSInteger edge, NSInteger maxValue, CGColorRef color, CGFloat width)
{
    NSInteger currentValue = valueArray[0];
    CGFloat currentRadious = currentValue * (radious / maxValue);
    CGPoint lastPoint = CGPointMake(center.x, center.y - currentRadious);
    for (int j = 1; j <= edge; j++) { 
        CGFloat currentAngle = 2 * M_PI / edge * j;
        currentValue = valueArray[j % edge];
        currentRadious = currentValue * (radious / maxValue);
        CGFloat x = center.x + currentRadious * sin(currentAngle);
        CGFloat y = center.y - currentRadious * cos(currentAngle);
        CGPoint currentPoint = CGPointMake(x, y);
        drawStroke(context, lastPoint, currentPoint, color, width);
        lastPoint = currentPoint;
    }    
}


void drawPolygon(CGContextRef context, CGPoint center, CGFloat radious, NSInteger edge, NSInteger maxValue, CGColorRef color, CGFloat width)
{
    for (int i = 1; i <= maxValue; i++) {
        CGFloat currentRadious = i * (radious / maxValue);
        CGPoint lastPoint = CGPointMake(center.x, center.y - currentRadious);
        for (int j = 1; j <= edge; j++) { 
            CGFloat currentAngle = 2 * M_PI / edge * j;
            CGFloat x = center.x + currentRadious * sin(currentAngle);
            CGFloat y = center.y - currentRadious * cos(currentAngle);
            CGPoint currentPoint = CGPointMake(x, y);
            drawStroke(context, lastPoint, currentPoint, color, width);
            lastPoint = currentPoint;
        }
    }
    
}


void drawStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, 
                CGColorRef color, CGFloat width) {
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, width);
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);        
}


@end

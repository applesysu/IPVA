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
void drawValueGraph(CGContextRef context, CGPoint center, CGFloat *valueArray, CGFloat radious, NSInteger edges, NSInteger maxValue, CGColorRef color, CGFloat width);



@implementation CYCompareGraph
@synthesize center, radious, edges, width, polygonColor, firstObjectColor, secondObjectColor, maxValue;
@synthesize firstObjectValuesArray = _firstObjectValuesArray;
@synthesize secondObjectValuesArray = _secondObjectValuesArray;


//- (NSMutableArray *)firstObjectValuesArray
//{
//    if (_firstObjectValuesArray == nil)
//        _firstObjectValuesArray = [[[NSMutableArray alloc] init] autorelease];
//    return _firstObjectValuesArray;
//
//}

//- (void)setFirstObjectValuesArray:(NSMutableArray *)firstObjectValuesArray
//{
//    int i = 0;
//    for (NSNumber *number in firstObjectValuesArray)
//    {
//        [_firstObjectValuesArray replaceObjectAtIndex:i withObject:[firstObjectValuesArray objectAtIndex:i]];
//        i++;
//    }
//    _firstObjectValuesArray = firstObjectValuesArray;
//}

//- (NSMutableArray *)secondObjectValuesArray
//{
//    if (_secondObjectValuesArray == nil)
//        _secondObjectValuesArray = [[[NSMutableArray alloc] init] autorelease];
//    return _secondObjectValuesArray;
//    
//}

//- (void)setSecondObjectValuesArray:(NSMutableArray *)secondObjectValuesArray
//{
//    int i = 0;
//    for (NSNumber *number in secondObjectValuesArray)
//    {
//        [_secondObjectValuesArray replaceObjectAtIndex:i withObject:[secondObjectValuesArray objectAtIndex:i]];
//        i++;
//    }
//}

- (void)dealloc
{
    [super dealloc];
    [_firstObjectValuesArray release];
    [_secondObjectValuesArray release];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        
        // Initialization code
        radious = 150;
        center = CGPointMake(150, 150);
        edges = 8;
        width = 3;
        maxValue = 3;
        polygonColor = [[UIColor grayColor] CGColor];
        firstObjectColor = [[UIColor redColor] CGColor];
        secondObjectColor = [[UIColor blueColor] CGColor];
        for (int i = 0; i < 8; i++) {
            [self.firstObjectValuesArray addObject:[NSNumber numberWithDouble:0]];
            [self.secondObjectValuesArray addObject:[NSNumber numberWithDouble:0]];
        }
        NSLog(@"%@",self.firstObjectValuesArray);
        
        
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
    
    [[UIColor clearColor] setFill];
    CGContextAddRect(ctx, rect);
    CGContextDrawPath(ctx, kCGPathFill);
    
    // change NSArray to c array
    CGFloat firstObjectValueArray[self.edges];
    int i = 0;
    NSLog(@"%@", self.firstObjectValuesArray);
    NSLog(@"%@", self.secondObjectValuesArray);

    for (NSNumber *number in self.firstObjectValuesArray)
    {
        firstObjectValueArray[i] = [number doubleValue];
        i++;
    }
    
    CGFloat secondObjectValuesArray[self.edges];
    i = 0;
    for (NSNumber *number in self.secondObjectValuesArray)
    {
        secondObjectValuesArray[i] = [number doubleValue];
        i++;
    }
    
    drawPolygon(ctx, center, radious, edges, 5, polygonColor, width);
    drawValueGraph(ctx, center, firstObjectValueArray, radious, edges, maxValue, firstObjectColor, width);
    drawValueGraph(ctx, center, secondObjectValuesArray, radious, edges, maxValue, secondObjectColor, width);
    
    
    
}

#pragma mark - drawMethods
void drawValueGraph(CGContextRef context, CGPoint center, CGFloat *valueArray, CGFloat radious, NSInteger edge, NSInteger maxValue, CGColorRef color, CGFloat width)
{
    CGFloat currentValue = valueArray[0];
    //    CGFloat currentRadious = currentValue * (radious / maxValue);
    CGFloat currentRadious = currentValue * radious;
    CGPoint lastPoint = CGPointMake(center.x, center.y - currentRadious);
    for (int j = 1; j <= edge; j++) { 
        CGFloat currentAngle = 2 * M_PI / edge * j;
        currentValue = valueArray[j % edge];
        //        currentRadious = currentValue * (radious / maxValue);
        currentRadious = currentValue * radious;
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
            if (i == maxValue)
            {
                drawStroke(context, center, currentPoint, color, width);
            }
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

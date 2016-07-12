//
//  JFDegreeLine.m
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/6/29.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import "JFDegreeLine.h"

@interface JFDegreeLine(){
    CGFloat lineWidth;
    CGFloat lineHeight; // 高度
}

@end

@implementation JFDegreeLine

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        lineWidth = frame.size.width;
        lineHeight = frame.size.height;
        [self drawingLine];
    }
    
    return self;
}

-(UIColor *)fillColor{
    if (_fillColor == nil) {
        _fillColor = [UIColor grayColor];
    }
    
    return _fillColor;
}

-(void)drawingLine{
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    

    if (self.lineW <= 4) {
        self.lineW = 12;
    }
    
    if (self.lineH <= 0) {
        self.lineH = 8;
    }

    
    if (self.lineType == JFLineUpward) {
        
        CGFloat mid = lineWidth/2;
        CGFloat width = lineWidth-6;
        CGFloat height = lineHeight-6;
        CGFloat x=mid-width/2+2;;
        CGFloat y=height;
        
        CGContextMoveToPoint(context, x, y);//开始坐标p1
        CGContextAddArcToPoint(context, x+mid, y-(height-1), x+width, y+(height-1), mid*3.35);
        CGContextSetLineWidth(context, self.lineH-4);//线条宽度
        CGContextSetStrokeColorWithColor(context, self.fillColor.CGColor);
        CGContextStrokePath(context);//绘画路径


    }
    else if (self.lineType == JFLineDownward){

        
        // 下半圆
        CGFloat mid = lineWidth/2;
        CGFloat width = lineWidth-6;
        CGFloat height = lineHeight-6;
        CGFloat x=mid-width/2+2;;
        CGFloat y= 2;
        
        CGContextMoveToPoint(context, x, y);//开始坐标p1
        CGContextAddArcToPoint(context, x+mid, y+(height-1), x+width, y-(height-1), mid*2.75);
        CGContextSetLineWidth(context, self.lineH-4);//线条宽度
        CGContextSetStrokeColorWithColor(context, self.fillColor.CGColor);
        CGContextStrokePath(context);//绘画路径

    }
    else{
        
        
        CGFloat midX = lineWidth/2;
        
        CGFloat d = 2;
        CGFloat width = self.lineW-4;
        CGFloat height = self.lineH-4;
        CGFloat radius = self.lineH/5;
        int X=midX-self.lineW/2+2;
        int Y=2;
        
        CGContextMoveToPoint(context, X+d, Y);
        //左上角
        CGContextAddArcToPoint(context, X, Y , X, Y+d, radius);
        //左下角
        CGContextAddArcToPoint(context, X, Y+height , X+d, Y+height, radius);
        //右下角
        CGContextAddArcToPoint(context, X+width, Y+height , X+width, Y+height-d, radius);
        //右上角
        CGContextAddArcToPoint(context, X+width, Y , X+d, Y, radius);
        
        CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
        
        // 暂时用图片代替
        //    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
        //    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    
    
    
    
    

}


@end

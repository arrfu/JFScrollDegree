//
//  JFDegreeLine.h
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/6/29.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,JFLineType){
    JFLineUpward, // 上半圆弧
    JFLineMidward, // 中间为矩形
    JFLineDownward, // 下半圆弧
};

@interface JFDegreeLine : UIView

//@property (nonatomic,assign)CGFloat lineHeight; // 高度
@property (nonatomic,assign)CGFloat lineRadius; // 半径

@property (nonatomic,assign)CGFloat lineW; // 宽
@property (nonatomic,assign)CGFloat lineH; // 高

@property (nonatomic,strong)UIColor *fillColor; // 填充色

@property (nonatomic,assign)JFLineType lineType; // 绘制类型

-(void)drawingLine;
@end

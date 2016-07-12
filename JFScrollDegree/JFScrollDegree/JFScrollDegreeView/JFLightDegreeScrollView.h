//
//  JFLightDegreeScrollView.h
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/6/29.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JFGestureState)
{
    JFGestureStateOther, // 其他点击,马上更新
    JFGestureStateBegan, // 手势开始
    JFGestureStateEnd, // 手势结束,延时更新
};


@protocol JFLightDegreeScrollViewDelegate <NSObject>

-(void)scrollLightDegree:(NSInteger)degree GestureState:(JFGestureState)scrollGestureState; // 0~100

@end

@interface JFLightDegreeScrollView : UIView

@property (nonatomic,assign)NSInteger lightDegree;

@property (nonatomic,unsafe_unretained)id <JFLightDegreeScrollViewDelegate>delegate;

/**
 * 根据亮度更新滚动位置
 */
-(void)updateScrollViewContentOffsetWithBrightness:(NSInteger)brightness;
@end

//
//  JFLightDegreeScrollView.m
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/6/29.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import "JFLightDegreeScrollView.h"
#import "JFDegreeLine.h"

@interface JFLightDegreeScrollView()<UIScrollViewDelegate>{
    UIImageView *bgImage;
    UIImageView *lightImage; // 亮度图片
    bool snapping;
    CGPoint oldContentOffset;
    BOOL scrollEnd; // 滑动结束
    
    JFGestureState gestureState; // 手势状态
}

@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation JFLightDegreeScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        snapping = NO;
        scrollEnd = YES;
        oldContentOffset = CGPointMake(0, 0);
        [self createUIWithFrame:frame];
    }
    
    return self;
}

-(void)createUIWithFrame:(CGRect)frame{
    
    bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    bgImage.image = [UIImage imageNamed:@"img_tr"];
    [self addSubview:bgImage];
    
    lightImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    lightImage.image = [UIImage imageNamed:@"trackball0000_black"];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 3, frame.size.width, frame.size.height-6)];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    CGFloat itemSizeW = frame.size.width*0.45;
    CGFloat itemSizeH = 8;
    CGFloat lineY = 0;//-15;
    NSInteger lineNum = 250;
    
    for (int i = 0; i < lineNum; i++) {
        JFDegreeLine *line = [[JFDegreeLine alloc] initWithFrame:CGRectMake(5, lineY+i*itemSizeH, itemSizeW, itemSizeH)];
        line.center = CGPointMake(frame.size.width/2, line.center.y);
        line.fillColor = [UIColor colorWithWhite:0.5 alpha:0.5];
//        line.fillColor = [UIColor clearColor];
        line.lineW = itemSizeW;
        line.lineH = itemSizeH;
        line.lineType = JFLineMidward;
        [line drawingLine];
        line.tag = i+100;
        
        [self.scrollView addSubview:line];
    }
    
    [self changeAnimationLight];
    self.scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height+itemSizeH*140);
    [self addSubview:self.scrollView];
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    scrollEnd = NO;
    if (!snapping) {
        gestureState = JFGestureStateBegan;
        [self degreeDidScrollViewDragging];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollEnd = NO;
    
    if (!snapping) {
        gestureState = JFGestureStateBegan;
        [self degreeDidScrollViewDragging];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    scrollEnd = NO;
    if (!snapping) {
        gestureState = JFGestureStateBegan;
        [self degreeDidScrollViewDragging];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollEnd = YES;
    gestureState = JFGestureStateEnd; // 滚动结束
    if (!snapping) {
        
        [self degreeDidScrollViewDragging];
    }
}


-(void)degreeDidScrollViewDragging{
    
    CGFloat itemSizeH = 8;
    CGFloat contentOffsetY = self.scrollView.contentOffset.y;
    NSInteger lineNun = (NSInteger)(contentOffsetY/8);
    
    NSInteger oldDegree = self.lightDegree;
    
    if (lineNun >= 100) {
        [self moveScrollViewContentOffsetWithBrightness:100];
    }
    else if (self.scrollView.contentOffset.y <= 0){
        [self moveScrollViewContentOffsetWithBrightness:0];
    }
    else {
        self.lightDegree = lineNun;
    }
    
    if (oldDegree != self.lightDegree) {
        if ([self.delegate respondsToSelector:@selector(scrollLightDegree:GestureState:)]) {
            [self.delegate scrollLightDegree:self.lightDegree GestureState:gestureState];
      
        }
        
//        JFLog(@"lightDegree = %d",self.lightDegree);
    }
    
    
    
//    JFLog(@"contentOffset.y = %f",self.scrollView.contentOffset.y);
    
    [self changeAnimationLight];
}

/**
 * 根据亮度更新滚动位置
 */
-(void)updateScrollViewContentOffsetWithBrightness:(NSInteger)brightness{
    if (brightness > 100) {
        brightness = 100;
    }
    
    if (scrollEnd == NO) {
//        return ;
    }

    snapping = YES;
    CGPoint contentOffset = self.scrollView.contentOffset;
    contentOffset.y = 8*brightness;
    self.scrollView.contentOffset = contentOffset;
    self.lightDegree = brightness;
    [self changeAnimationLight];
    snapping = NO;

}

/**
 * 设置滚动位置
 */
-(void)moveScrollViewContentOffsetWithBrightness:(NSInteger)brightness{
    
    CGPoint contentOffset = self.scrollView.contentOffset;
    contentOffset.y = 8*brightness;
    self.scrollView.contentOffset = contentOffset;
    self.lightDegree = brightness;

}

/**
 * 修改动画
 */
-(void)changeAnimationLight{
    
    JFDegreeLine *line = [self.scrollView viewWithTag:1+100];
    CGFloat lineW = line.frame.size.width;
    CGFloat lineH = line.frame.size.height;
    
    CGFloat itemSizeH = lineH;
    CGFloat pageHeight = itemSizeH*10; // 每页10条
    
    // 取出每页第一条对应tag
    NSInteger firstLineTag = self.scrollView.contentOffset.y/itemSizeH +100;
 
    float colorBuf[10] = {0.09, 0.11, 0.65, 0.75, 0.95, 0.99, 0.90, 0.65,0.11,0.03}; // 渐变色 暗->亮
    float lineWidthBuf[10] = {0.70, 0.80, 0.88, 0.94, 1.0, 0.94, 0.88, 0.80, 0.75, 0.70}; // 宽大小 小->大
    float lineHeightBuf[10] = {0.65, 0.75, 0.90, 0.94, 1.0, 0.94, 0.90, 0.80, 0.75, 0.70}; // 高大小 小->大
    
    for (int i = 0; i<10; i++) {
        if ([[self.scrollView viewWithTag:firstLineTag+i] class] == [JFDegreeLine class]) {
            JFDegreeLine *line = [self.scrollView viewWithTag:firstLineTag+i];
            
            CGFloat linew = lineW;
            CGFloat lineh = lineH;
            
            linew *= lineWidthBuf[i];
            lineh *= lineHeightBuf[i];
            line.fillColor = [UIColor colorWithWhite:colorBuf[i] alpha:0.3];
            
            // 设置线条类型
            if (i < 2) {
                line.lineType = JFLineUpward;
            }
            else if (i >= 8){
                line.lineType = JFLineDownward;
            }
            else{
                line.lineType = JFLineMidward;
                
            }
            
            line.lineW = linew;
            line.lineH = lineh;
            [line drawingLine];
        }
        
    }

    
    
    
//    JFLog(@"page : %f,firstLineTag = %d",self.scrollView.contentOffset.y/pageHeight,firstLineTag);
}


///**
// * 修改动画 用图片方式
// */
//-(void)changeAnimationLight{
//    
//    CGFloat itemSizeW = bgImage.frame.size.width*0.4;
//    CGFloat itemSizeH = 8;
//    CGFloat lineY = -15;
//    NSInteger lineNum = 200;
//    
//    CGFloat pageHeight = itemSizeH*10; // 每页10条
//    
//    // 取出每页第一条对应tag
////    NSInteger firstLineTag = self.lightDegree
//    
//    NSString *str = [NSString stringWithFormat:@"%@",@"trackball"];
//    NSInteger brightness = self.lightDegree;
//    NSInteger imageNum = 0;
//    
////    if (brightness < 40 ) {
////        
////        if (brightness % 2 == 0) {
////            imageNum = brightness/2;
////            str = [NSString stringWithFormat:@"%@%04d%@",str,imageNum,@"_white"];
////        }
////        else{
////            imageNum = (brightness-1)/2;
////            str = [NSString stringWithFormat:@"%@%04d%@",str,imageNum,@"_black"];
////        }
////        
////        
////        
////    }
////    else{
////
////        str = [NSString stringWithFormat:@"%@%04d%@",str,brightness,@"_black"];
////    }
//    
//    if (brightness < 20 ) {
//        
//        str = [NSString stringWithFormat:@"%@%04d%@",str,imageNum,@"_white"];
//        
//        
//    }
//    else if (brightness < 40 ){
//        brightness = (brightness-20);
//        str = [NSString stringWithFormat:@"%@%04d%@",str,brightness,@"_black"];
//    }
//
//    lightImage.image = [UIImage imageNamed:str];
//    
////    [line drawingLine];
//    
//    JFLog(@"page : %f",self.scrollView.contentOffset.y/pageHeight);
//}


@end

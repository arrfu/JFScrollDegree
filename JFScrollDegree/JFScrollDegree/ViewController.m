//
//  ViewController.m
//  JFScrollDegree
//
//  Created by hao123 on 16/7/11.
//  Copyright © 2016年 arrfu. All rights reserved.
//

#import "ViewController.h"
#import "JFLightDegreeScrollView.h"

@interface ViewController ()<JFLightDegreeScrollViewDelegate>{
    UILabel *degreeLabel; // 等级显示
    JFLightDegreeScrollView *lightDegreeScrollView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 亮度等级显示
    degreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    degreeLabel.center = CGPointMake(self.view.center.x, self.view.center.y-60);
    degreeLabel.textColor = [UIColor blackColor];
    degreeLabel.textAlignment = NSTextAlignmentCenter;
    degreeLabel.text = @"0 %";
    [self.view addSubview:degreeLabel];
    
    lightDegreeScrollView = [[JFLightDegreeScrollView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    lightDegreeScrollView.center = self.view.center;
    lightDegreeScrollView.delegate = self;
    [self.view addSubview:lightDegreeScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 亮度滚动回调
-(void)scrollLightDegree:(NSInteger)degree GestureState:(JFGestureState)scrollGestureState{
    
    NSLog(@"degree = %ld,scrollGestureState = %ld",(long)degree,(long)scrollGestureState);
    
    degreeLabel.text = [NSString stringWithFormat:@"%d %@",degree,@"%"];
    
}

@end

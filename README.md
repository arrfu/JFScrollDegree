# JFScrollDegree
亮度等级滚动条

1.接口
<pre><oc>
@protocol JFLightDegreeScrollViewDelegate <NSObject>

-(void)scrollLightDegree:(NSInteger)degree GestureState:(JFGestureState)scrollGestureState; // 0~100

@end
</oc></pre>

2.使用Demo
<pre><oc>
JFLightDegreeScrollView *lightDegreeScrollView = [[JFLightDegreeScrollView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
lightDegreeScrollView.center = self.view.center;
lightDegreeScrollView.delegate = self;
[self.view addSubview:lightDegreeScrollView];
</oc></pre>

3.效果：   

![滚动效果图](JFScrollDegreeView.gif)

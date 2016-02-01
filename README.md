# WWsegment
=====
简单方便，高度可自定义，缺点是不可以滑动，用来替代iOS系统segment的很好的东东
可轻松实现以下效果
*
**
#可实现效果
![baidu](https://github.com/wsq724439564/WWsegment/blob/master/screenshot/01.png) 



![baidu](https://github.com/wsq724439564/WWsegment/blob/master/screenshot/02.png) 


![baidu](https://github.com/wsq724439564/WWsegment/blob/master/screenshot/03.png) 



![baidu](https://github.com/wsq724439564/WWsegment/blob/master/screenshot/04.png) 

#使用方法

###使用xib拖线使用
``` Objective-C
-(void)setupSegment
{
    [self.segment setSegementItemHighlightBGColor:WWRGB(255, 116, 67)];
    [self.segment setSegementItemNormalBGColor:WWRGB(31, 34, 40)];
    [self.segment setSegementItemNormalTitleColor:WWRGB(255, 116, 67)];
    [self.segment setSegementItemHighlightTitleColor:WWRGB(31, 34, 40)];
    self.segment.delegate =self;
    [self.segment setSegementItemSpacing:1];
    [self.segment setSegementLineColor:WWRGB(4, 5, 7)];
    [self.segment setSegementItemTitleFont:[UIFont systemFontOfSize:14]];
    [self.segment setAutoSelected:YES];
    [self.segment setTitles:self.titlesArray];
}
```
###手写代码使用
``` Objective-C
    WWSegmentView* segmentView01 = [[WWSegmentView alloc] initWithFrame:self.containerView1.bounds];
    segmentView01.delegate = self;
    segmentView01.segementCornerRadius = 3;
    segmentView01.segementBorderWidth = 1;
    segmentView01.autoSelected = YES;
    [segmentView01 setTitles:@[@"会员", @"潜力客户1", @"潜力客户2",@"潜力客户3", @"潜力客户4"]];
    [self.containerView1 addSubview:segmentView01];
```

###自定义item使用 
自定义类型可以使任何自定义的继承自WWButton的类。
``` Objective-C
    WWSegmentView* segmentView01 = [[WWSegmentView alloc] initWithFrame:self.containerView1.bounds];
    
    segmentView01.delegate = self;
    segmentView01.segementCornerRadius = 3;
    segmentView01.segementBorderWidth = 1;
    segmentView01.autoSelected = YES;
    [segmentView01 setTitles:@[@"会员", @"潜力客户1", @"潜力客户2",@"潜力客户3", @"潜力客户4"]];
    
    WWButton* item = [WWButton customImageButtonItemWithNormalImage:@"like_highlight" highlight:@"like_normal"];
    [self.segment insertSegmentItem:item atIndex:0];

    [self.containerView2 addSubview:segmentView01];
```
#其他注意事项，
    切记设置完所有属性之后再调用 setTitles 方法，
    
    WWsegment支持禁用点击事件 
    ``` Objective-C
    segment.disableSelected =YES
    
    ``` 
    WWsegment默认响应第一个item的事件，去掉默认的自动触发
    ``` Objective-C
    segment.autoSelected =NO
    
    ``` 



#联系我
    邮箱：wsq724439564@126.com 

    微博： http://weibo.com/u/1325583405 [@我就是大强]


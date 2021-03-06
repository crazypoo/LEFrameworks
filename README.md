# LEFrameworks
IOS Development Frameworks 持续更新中 

请使用：

#import "LEFrameworks.h"



关于库中导航栏处理说明：

以前UI开发时，导航栏的开发一直使用的是自定义做法，因为这样比较灵活。后来一个项目必须用到的第三个库必须支持系统的导航栏，因此改变了UI开发的方式。目前大部分库都是针对于UIView做的支持，不存在导航栏的处理。但是部分库由于与系统组件关联较大如MultiImagePicker（图片多选组件），在开发时与导航栏挂在一起。因此在使用类似的组件时需要管理导航栏。后期的开发不出意外都会使用系统导航栏而不再自定义，因此如果后期的库与系统组件挂钩的都仅仅会使用兼容导航栏的方式进行开发。

一、组件封装：

    1- LECircleChart:圆形镂空进度组件（可以只显示一段弧形）
      
    
![image](https://github.com/LarryEmerson/LEFrameworks/blob/master/Example/LECircleChart.gif)
    
    -(void) onTestCircleChart{
        circleChart=[[LECircleChart alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorInsideBottomCenter Offset:CGPointMake(0, StatusBarHeight) CGSize:CGSizeMake(240, 240)] MinAngle:-225 MaxAngle:45 Color:[UIColor colorWithRed:0.345 green:0.748 blue:0.885 alpha:1.000] ShadowColor:[UIColor colorWithRed:0.271 green:0.496 blue:0.712 alpha:1.000] LineWidth:12 ShadowLineWidth:6 Progrss:12];
        [circleChart strokeChart];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onCheckCircleChart) userInfo:nil repeats:YES];
    }
    -(void) onCheckCircleChart{
        [circleChart growChartByAmount:12];
    }
    
    2-LELineChart：统计线形图
    
![image](https://github.com/LarryEmerson/LEFrameworks/blob/master/Example/LELineChart.gif)
    
    Gif中组件测试代码：
    UILabel *labelLineChart;
    -(void) onTestLELineChart{
        LELineChart *line=[[LELineChart alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.curFrameWidth, self.curFrameWidth/2)] LineWidth:2 RulerLineWidth:1 Color:ColorRed RulerColor:[UIColor greenColor] Padding:14 VerticalPadding:20 Target:self];
        labelLineChart=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:line Offset:CGPointMake(0, LayoutSideSpace) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorRed Line:1 Alignment:NSTextAlignmentCenter]];
        [line onSetData:@[@"10",@"100",@"50",@"60",@"20",@"5",@"90",@"100",@"40",@"80"] Min:5 Max:100];
        [line setBackgroundColor:[UIColor colorWithRed:0.4686 green:0.7222 blue:0.8368 alpha:1.0]];
    }
    -(void) onLineChartSelection:(NSUInteger)index{
        [labelLineChart leSetText:[NSString stringWithFormat:@"当前移动到了第%d个位置",index+1]];
    }
    
    
    3-LEBarChart:统计柱状图
    
![image](https://github.com/LarryEmerson/LEFrameworks/blob/master/Example/LEBarChart.gif)
    
    GIF中组件测试代码：
    UILabel *labelBarChart;
    
    -(void) onTestBarChart{
        LEBarChart *bar=[[LEBarChart alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.curFrameWidth, self.curFrameWidth/2)] BarChartSettings:[[LEBarChartSettings alloc] init] Delegate:self];
        labelBarChart=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:bar Offset:CGPointMake(0, LayoutSideSpace) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorRed Line:1 Alignment:NSTextAlignmentCenter]];
        [bar onSetValues:@[@"10",@"100",@"50",@"60",@"20",@"5",@"90",@"100",@"40",@"80"] Tags:@[@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eight",@"Nine",@"Ten"]];
    }
    -(void) onBarSelectedWithIndex:(int)index{
        [labelBarChart leSetText:[NSString stringWithFormat:@"当前点击了第%d个bar",index+1]];
    }
   
    4- LESegmentView顶部封装
    
![image](https://github.com/LarryEmerson/LEFrameworks/blob/master/Example/LESegmentView.gif)
    
    -(id) initWithTitles:(NSArray *) titles Pages:(NSArray *) pages ViewContainer:(UIView *) container SegmentHeight:(int) segmentHeight Indicator:(UIImage *) indicator SegmentSpace:(int) space;
    
    Gif中组件测试代码如下：
    
    -(void) onTestSegmentView {
        UIView *v1=[[UIView alloc] init];
        [v1 setBackgroundColor:[UIColor colorWithRed:1.0 green:0.5216 blue:0.563 alpha:1.0]];
        UIView *v2=[[UIView alloc] init];
        [v2 setBackgroundColor:[UIColor colorWithRed:0.7397 green:1.0 blue:0.795 alpha:1.0]];
        UIView *v3=[[UIView alloc] init];
        [v3 setBackgroundColor:[UIColor colorWithRed:0.6962 green:0.7723 blue:1.0 alpha:1.0]];
        UIView *v4=[[UIView alloc] init];
        [v4 setBackgroundColor:[UIColor colorWithRed:1.0 green:0.7302 blue:0.9259 alpha:1.0]];
        UIView *v5=[[UIView alloc] init];
        [v5 setBackgroundColor:[UIColor colorWithRed:0.9925 green:0.909 blue:0.7724 alpha:1.0]];
        [[LESegmentView alloc] initWithTitles:@[@"One",@"第二页",@"再来一个",@"这一个应该可以超出屏幕宽了吧",@"好了可以结束了"] Pages:@[v1,v2,v3,v4,v5] ViewContainer:self.viewContainer SegmentHeight:40 Indicator:[ColorRed imageWithSize:CGSizeMake(8, 4)] SegmentSpace:20];
    }
    
    
    5-LEWaveProgressView:波浪上涨动画
   
![image](https://github.com/LarryEmerson/LEFrameworks/blob/master/Example/LEWaveProgressView.gif)
   
    GIF中组件测试代码如下：
   
    -(void) onTestWaveProgressView{
        curWave=[[LEWaveProgressView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, NavigationBarHeight) CGSize:CGSizeMake(250, 260)]];
        [curWave setBackgroundColor:[UIColor colorWithRed:0.3515 green:0.7374 blue:1.0 alpha:1.0]];
        [curWave setPercentage:0];
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onWaveTimer) userInfo:nil repeats:YES];
    }
    -(void) onWaveTimer{
        [curWave setPercentage:rand()%10*1.0/10];
    }
    
    6-MultiImagePicker：图片多选组件（注意需要配合系统导航栏使用）
    
![image](https://github.com/LarryEmerson/LEFrameworks/blob/master/Example/MultiImagePicker.gif)
    
    GIF中组件测试代码如下：
    
    [self.navigationController setNavigationBarHidden:NO];
    MultiImagePicker *picker=[[MultiImagePicker alloc] initWithImagePickerDelegate:self];
    [self.navigationController pushViewController:picker animated:YES];
    
    7-ExcelView:表格方式展示数据
    
![image](https://raw.githubusercontent.com/LarryEmerson/LEFrameworks/master/Example/ExcelView.gif)
    
    GIF中组件测试代码如下：
    
    UIView *view=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:self.viewContainer.bounds.size]];
    curExcelView=[[ExcelView alloc] initWithSettings:[[LETableViewSettings alloc] initWithSuperViewContainer:self ParentView:view TableViewCell:@"TestExcelViewCell" EmptyTableViewCell:nil GetDataDelegate:self TableViewCellSelectionDelegate:self] ImmovableViewWidth:120 MovableViewWidth:300 TabbarHeight:BottomTabbarHeight TabbarClassname:@"TestExcelViewTabbar"];
    [curExcelView onRefreshedWithData:[@[@"",@"",@"",@"",@"",@"",@"",@""]mutableCopy]];
    
    @interface TestExcelViewCell : ExcelViewTableViewCell
    @end
    @implementation TestExcelViewCell{ 
        UILabel *labelLeft;
        UILabel *labelRight;
    }
    -(void) initUIForExcelView{
        [self.immovableView setBackgroundColor:[UIColor colorWithRed:0.8947 green:0.527 blue:0.3107 alpha:1.0]];
        [self.movableView setBackgroundColor:[UIColor colorWithRed:0.6922 green:0.4729 blue:0.6923 alpha:1.0]];
        [LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.movableView EdgeInsects:UIEdgeInsetsZero] Image:[[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"lewave"]];
        [self addBottomSplitWithColor:ColorRed Offset:CGPointZero Width:self.bounds.size.width];
        labelLeft=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.immovableView Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentCenter]];
        labelRight=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.movableView Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LayoutSideSpace20, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentLeft]];
    }
    -(void) setData:(id)data IndexPath:(NSIndexPath *)path{
        [super setData:data IndexPath:path];
        [labelLeft leSetText:[NSString stringWithFormat:@"第%d行",path.row]];
        [labelRight leSetText:[NSString stringWithFormat:@"第%d行右侧可移动的内容，我是第%d行内容",path.row,path.row]];
    }
    @end

    @interface TestExcelViewTabbar : ExcelViewTabbar
    @end
    @implementation TestExcelViewTabbar
    -(void) initUIForExcelViewTabbar{
        [self.immovableView setBackgroundColor:[UIColor colorWithRed:0.9991 green:0.5522 blue:0.9683 alpha:1.0]];
        [self.movableView setBackgroundColor:[UIColor colorWithRed:0.4642 green:0.6434 blue:0.9982 alpha:1.0]];
        [LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.movableView EdgeInsects:UIEdgeInsetsZero] Image:[[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"lewave"]];
        [LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.immovableView Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"左侧行数" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentCenter]];
        [LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.movableView Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LayoutSideSpace20, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"右侧内容1        右侧内容2" FontSize:LayoutFontSize14 Font:nil Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentLeft]];
    }
    @end

二、实用的自动排版的库:（原理解析）

![image](https://github.com/LarryEmerson/LEFrameworks/blob/master/Example/LEUIFramework.gif)
    
    
    LEUIFramework，主要的用法是在新建视图时确定好其父视图，相对位置，大小后，之后父视图的变动，或者自身的变动无需花费大量监听代码去处理视图之间的关系。基本原理是子视图在初始化时，提供父视图、与父视图或者与其他子视图的相对位置、偏移量，大小（Label和Image可以设置为CGSizeZero，从而选择让库来自动处理大小）后，视图位置即可确定。当父视图或者相对位置的参考子视图有所变动时，子视图都会收到重排的指令，从而可以自动排版。而子视图在使用leSetOffset改变偏移量，leSetSize变动大小或者leSetFrame设置整个frame时，其他与之有相对位置关系的视图都会收到消息，从而所有视图都可以自动重排。

    1）、所有的view在新建时都可以使用如下的3个初始化方法
        -(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor Offset:(CGPoint) offset CGSize:(CGSize) size;相对位置参考物为父视图
        -(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor RelativeView:(UIView *) relativeView Offset:(CGPoint) offset CGSize:(CGSize) size;相对位置是父视图中的某一个子视图
        -(id) initWithSuperView:(UIView *)superView EdgeInsects:(UIEdgeInsets) edge;相对于父视图，子视图的大小为父视图的大小减去edge
    2）、相对位置LEAnchors
        相对位置参考物为父视图时：用9宫格法
        上左  上中  上右    
        左中  中间  右中
        下左  下中  下右
        相对位置参考物为父视图中的某一子视图时：
        
        角（Outside1）          角（Outside2）
           1 上左  上中  上右 2
             _______________
        左上|               |右上
            |               |
        左中|               |右中
            |               |
        左下|               |右下
             ———————————————
           3 下左  下中  下右  4
        角（Outside3）           角（Outside4）
    3）、快速初始化组件（1句话初始化）：UILabel，UIImageView，UIButton
        +(UIImageView *) getUIImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(UIImage *) image ;
        +(UILabel *) getUILabelWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings ;  
        +(UIButton *) getUIButtonWithSettings:(LEAutoLayoutSettings *) settings ButtonSettings:(LEAutoLayoutUIButtonSettings *) buttonSettings ;
        
三、界面的初步封装(Base目录中)

    LEBaseEmptyView，全屏视图可以通过初始化接口设置导航栏内容，进入，退出效果
    
四、列表的封装：单组列表（LEBaseTableView） 

    1）、已接入下拉刷新（onRefreshData），上拉加载更多（onLoadMore）的效果
    2）、初始化简单- (id) initWithSettings:(LETableViewSettings *) settings; 
    3）、列表数据源：
        -(void) onRefreshedWithData:(NSMutableArray *)data;
        -(void) onLoadedMoreWithData:(NSMutableArray *)data;
    4）、初始化方法：参数有全屏视图，父视图，自定义Cell的类名，可自定义空列表Cell类名，列表数据源回调，列表Cell点击事件回调
        -(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LEGetDataDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
    5）、可以重新自定义section及rows
五、Tabbar封装：LEBottomTabbar，LETabbarRelatedPageView

    -(id) initTabbarWithFrame:(CGRect) frame Delegate:(id) delegate NormalIcons:(NSArray *) icons HighlightedIcons:(NSArray *) iconsSelected Titles:(NSArray *) titles Pages:(NSArray *) pages NormalColor:(UIColor *) normalColor HighlightedColor:(UIColor *) highlightedColor;
    
六、其他工具：

    图片多选框架（MultiImagePicker），
    弹出消息（LocalNotification），
    二维码扫码（LEScanQRCode），
    弹窗（LEPopup）、
    Badge（LEBadge），
    电池上涨动画（LEWaveProgressView），
    
七、其他
[![Version](https://img.shields.io/cocoapods/v/LEFrameworks.svg?style=flat)](http://cocoapods.org/pods/LEFrameworks)
[![License](https://img.shields.io/cocoapods/l/LEFrameworks.svg?style=flat)](http://cocoapods.org/pods/LEFrameworks)
[![Platform](https://img.shields.io/cocoapods/p/LEFrameworks.svg?style=flat)](http://cocoapods.org/pods/LEFrameworks)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LEFrameworks is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby

platform :ios, '7.0'
target "ProjectName” do 
pod "LEFrameworks"
end 
```

## Author

LarryEmerson, larryemerson@163.com

## License

LEFrameworks is available under the MIT license. See the LICENSE file for more info.




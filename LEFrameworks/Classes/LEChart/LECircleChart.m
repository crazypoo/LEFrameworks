//
//  WWDCircleChart.m
//  WWDChart
//
//  Created by maginawin on 15-1-28.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "LECircleChart.h"
 
@implementation LECircleChart{
    float minAngle;
    float maxAngle;
    UIColor *colorCircle;
    UIColor *colorShadow;
    float lineWidth;
    float lineWidthShadow;
    
    UIColor* strokeColorGradientStart;
    float total;
    float current;
    
    CAShapeLayer* circle;
    CAShapeLayer* circleBackground;
}
-(void) setColor:(UIColor *) color ShadowColor:(UIColor *) shadowColor{
    colorCircle=color;
    colorShadow=shadowColor;
    [circle setStrokeColor:colorCircle.CGColor];
    [circleBackground setStrokeColor:colorShadow.CGColor];
    [self growChartByAmount:0];
}
-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *)settings MinAngle:(float) min MaxAngle:(float) max Color:(UIColor *) color  ShadowColor:(UIColor *) shadowColor LineWidth:(float) lineW ShadowLineWidth:(float) shadowLineWidth Progrss:(float) progress{
    self=[super initWithAutoLayoutSettings:settings];
    minAngle=min;
    maxAngle=max;
    colorCircle=color;
    colorShadow=shadowColor;
    lineWidth=lineW;
    lineWidthShadow=shadowLineWidth;
    current=progress;
    [self initExtra];
    if(progress>0){
        [self strokeChart];
    }
    return self;
}
-(void) setCircleLineCapAsButt{
    circle.lineCap = kCALineCapButt;
}
-(void) setCircleLineCapAsSquare{
    circle.lineCap = kCALineCapSquare;
}
-(void) setCircleLineCapAsRound{
    circle.lineCap = kCALineCapRound;
}
-(void) initExtra{
    total=maxAngle-minAngle;
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:(self.frame.size.height * 0.5) - lineWidth startAngle:DEGREES_TO_RADIANS(minAngle) endAngle:DEGREES_TO_RADIANS(maxAngle) clockwise:YES];
    circle = [CAShapeLayer layer];
    circle.path = circlePath.CGPath;
    circle.lineCap = kCALineCapRound;
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.lineWidth = lineWidth;
    circle.zPosition = 1;
    
    circleBackground = [CAShapeLayer layer];
    circleBackground.path = circlePath.CGPath;
    circleBackground.lineCap = kCALineCapRound;
    circleBackground.fillColor = [UIColor clearColor].CGColor;
    circleBackground.lineWidth = lineWidthShadow;
    circleBackground.strokeColor = colorShadow.CGColor;
    circleBackground.strokeEnd = 1;
    circleBackground.zPosition = -1;
    
    [self.layer addSublayer:circle];
    [self.layer addSublayer:circleBackground];
}
- (void)strokeChart {
    circle.lineWidth = lineWidth;
    circleBackground.lineWidth = lineWidthShadow;
    circleBackground.strokeEnd = 1.0;
    circle.strokeColor = colorCircle.CGColor;
    CABasicAnimation* pathAnimation = [CABasicAnimation animation];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @(current / total);
    [circle addAnimation:pathAnimation forKey:nil];
    circle.strokeEnd = current / total;
}
- (void)growChartByAmount:(float)growAmount { 
    [self updateChartByCurrent:current+growAmount];
}
- (void)updateChartByCurrent:(float) to {
    CABasicAnimation* pathAnimation = [CABasicAnimation animation];
    [pathAnimation setAdditive:YES];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @(current/total);
    pathAnimation.toValue = @(to/total);
    circle.strokeEnd = to/total;
    [circle addAnimation:pathAnimation forKey:nil];
    current = to;
}
@end

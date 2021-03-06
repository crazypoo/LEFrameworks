//
//  LEPopup.m
//  YuSen
//
//  Created by emerson larry on 16/4/18.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "LEPopup.h"


@implementation LEPopupSettings
-(id) init{
    self=[super init];
    [self initExtra];
    return self;
}
-(void) initExtra{}
@end

@implementation LEPopup{
    LEPopupSettings *curSettings;
    UIImageView *curBackground;
    UIView *curContentContainer;
    UILabel *curTitle;
    UIImageView *curSplit;
    UILabel *curSubtitle;
    //
    int W;
    int H;
    int ContentW;
    int ContentHExtra;
    //
    UIView *curBottomBar;
    UIView *curLeftBar;
    UIView *curRightBar;
    UIButton *curLeftButton;
    UIButton *curRightButton;
    UIButton *curCenterButton;
    //
    int btnHeight;
}
+(LEPopup *) showLEPopupWithSettings:(LEPopupSettings *) settings{
    LEPopup *popup= [[LEPopup alloc] initWithSettings:settings];
    [popup easeIn];
    return popup;
}
+(LEPopup *) showQuestionPopupWithSubtitle:(NSString *)subtitle Delegate:(id<LEPopupDelegate>) delegate{
    return [LEPopup showQuestionPopupWithTitle:nil Subtitle:subtitle Alignment:NSTextAlignmentCenter Delegate:delegate];
}
+(LEPopup *) showQuestionPopupWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Alignment:(NSTextAlignment) textAlignment Delegate:(id<LEPopupDelegate>) delegate{
    return [LEPopup showQuestionPopupWithTitle:title Subtitle:subtitle Alignment:textAlignment LeftButtonText:@"取消" RightButtonText:@"确定" Delegate:delegate];
}
+(LEPopup *) showQuestionPopupWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Alignment:(NSTextAlignment) textAlignment LeftButtonText:(NSString *)leftText RightButtonText:(NSString *)rightText Delegate:(id<LEPopupDelegate>) delegate {
    return [LEPopup showQuestionPopupWithTitle:title Subtitle:subtitle Alignment:textAlignment LeftButtonImage:[LEPopupCancleImage middleStrechedImage] RightButtonImage:[LEPopupOKImage middleStrechedImage] LeftButtonText:leftText RightButtonText:rightText Delegate:delegate];
}
+(LEPopup *) showQuestionPopupWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Alignment:(NSTextAlignment) textAlignment LeftButtonImage:(UIImage *)leftImg RightButtonImage:(UIImage *)rightImg LeftButtonText:(NSString *)leftText RightButtonText:(NSString *)rightText Delegate:(id<LEPopupDelegate>) delegate{
    LEPopupSettings *settings=[[LEPopupSettings alloc] init];
    [settings setCurDelegate:delegate];
    [settings setTitle:title];
    [settings setHasTopSplit:title!=nil];
    [settings setSubtitle:subtitle];
    [settings setTextAlignment:textAlignment];
    [settings setLeftButtonSetting:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:leftText FontSize:LayoutFontSize13 Font:nil Image:nil BackgroundImage:leftImg Color:ColorWhite SelectedColor:ColorGray MaxWidth:0 SEL:nil Target:nil HorizontalSpace:30]];
    [settings setRightButtonSetting:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:rightText FontSize:LayoutFontSize13 Font:nil Image:nil BackgroundImage:rightImg Color:ColorWhite SelectedColor:ColorGray MaxWidth:0 SEL:nil Target:nil HorizontalSpace:30]];
    LEPopup *popup=[[LEPopup alloc] initWithSettings:settings];
    [popup easeIn];
    return popup;
}
+(LEPopup *) showTipPopupWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Alignment:(NSTextAlignment) textAlignment{
    return [LEPopup showTipPopupWithTitle:title Subtitle:subtitle Alignment:textAlignment ButtonImage:[LEPopupOKImage middleStrechedImage] ButtonText:@"确定"];
}
+(LEPopup *) showTipPopupWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Alignment:(NSTextAlignment) textAlignment ButtonImage:(UIImage *)img ButtonText:(NSString *) text{
    LEPopupSettings *settings=[[LEPopupSettings alloc] init];
    [settings setTitle:title];
    [settings setHasTopSplit:title!=nil];
    [settings setSubtitle:subtitle];
    [settings setTextAlignment:textAlignment];
    [settings setCenterButtonSetting:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:text FontSize:LayoutFontSize13 Font:nil Image:nil BackgroundImage:img Color:ColorWhite SelectedColor:ColorGray MaxWidth:0 SEL:nil Target:nil HorizontalSpace:30]];
    LEPopup *popup=[[LEPopup alloc] initWithSettings:settings];
    [popup easeIn];
    return popup;
}
-(id) initWithSettings:(LEPopupSettings *) settings{
    curSettings=settings;
    self=[super initWithFrame:[LEUIFramework sharedInstance].ScreenBounds];
    [self setBackgroundColor:ColorMask5];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self initExtra];
    [self initUI];
    return self;
}
-(void) initExtra{
    W=self.bounds.size.width;
    H=self.bounds.size.height;
    if(curSettings.sideEdge==0){
        curSettings.sideEdge=NavigationBarHeight;
    }
    if(curSettings.maxHeight==0){
        curSettings.maxHeight=H;
    }
    if(UIEdgeInsetsEqualToEdgeInsets(curSettings.contentInsects, UIEdgeInsetsZero)){
        curSettings.contentInsects=UIEdgeInsetsMake(LayoutContentTopSpace, LayoutSideSpace, LayoutContentBottomSpace, LayoutSideSpace);
    }
    if(!curSettings.titleFont){
        curSettings.titleFont=[UIFont boldSystemFontOfSize:LayoutFontSize14];
    }
    if(!curSettings.titleColor){
        curSettings.titleColor=ColorTextBlack;
    }
    if(!curSettings.subtitleFont){
        curSettings.subtitleFont=[UIFont systemFontOfSize:LayoutFontSize12];
    }
    if(!curSettings.subtitleColor){
        curSettings.subtitleColor=ColorTextBlack;
    }
    //  
} 
-(void) initUI{
    [self setAlpha:0]; 
    [self addTapEventWithSEL:@selector(onBackgroundTapped) Target:self];
    curBackground=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeMake(W-curSettings.sideEdge*2, curSettings.maxHeight)] Image:curSettings.backgroundImage?[[UIImage imageNamed:curSettings.backgroundImage] middleStrechedImage]:(LEPopupBGImage?LEPopupBGImage:[ColorWhite imageStrechedFromSizeOne])];
    [curBackground setUserInteractionEnabled:YES];
    [curBackground addTapEventWithSEL:nil];
    curContentContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curBackground EdgeInsects:curSettings.contentInsects]];
    ContentW=curContentContainer.bounds.size.width;
    ContentHExtra=curSettings.contentInsects.top+curSettings.contentInsects.bottom;
    curTitle=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curContentContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(ContentW, ContentHExtra)] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:curSettings.title FontSize:0 Font:curSettings.titleFont Width:ContentW Height:0 Color:curSettings.titleColor Line:0 Alignment:NSTextAlignmentCenter]];
    curSplit=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curContentContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:curTitle Offset:CGPointMake(0, LayoutSideSpace) CGSize:CGSizeMake(ContentW, 1)] Image:[ColorSplit imageStrechedFromSizeOne]];
    [curSplit setHidden:!curSettings.hasTopSplit];
    curSubtitle=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curContentContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:curSplit Offset:CGPointMake(0, curSettings.hasTopSplit?LayoutSideSpace:0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:curSettings.subtitle FontSize:0 Font:curSettings.subtitleFont Width:ContentW Height:0 Color:curSettings.subtitleColor Line:0 Alignment:curSettings.textAlignment]];
    //    [curSubtitle leSetLineSpace:LayoutTextLineSpace];
    btnHeight=NavigationBarHeight;
    if(curSettings.leftButtonSetting.leBackgroundImage){
        btnHeight=MAX(NavigationBarHeight, curSettings.leftButtonSetting.leBackgroundImage.size.height);
    }
    if(curSettings.leftButtonSetting.leBackgroundImage){
        btnHeight=MAX(NavigationBarHeight, curSettings.leftButtonSetting.leBackgroundImage.size.height);
    }
    if(curSettings.centerButtonSetting.leBackgroundImage){
        btnHeight=MAX(NavigationBarHeight, curSettings.centerButtonSetting.leBackgroundImage.size.height);
    }
    curBottomBar=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curContentContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:curSubtitle Offset:CGPointMake(0, LayoutSideSpace) CGSize:CGSizeMake(ContentW, btnHeight)]];
    curLeftBar=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curBottomBar Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeMake(ContentW/2.0, btnHeight)]];
    curRightBar=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curBottomBar Anchor:LEAnchorInsideRightCenter Offset:CGPointZero CGSize:CGSizeMake(ContentW/2.0, btnHeight)]];
    [self initLeftButton];
    [self initRightButton];
    [self initCenterButton];
    [self onUpdatePopupLayout];
}
//
-(void) onResetPopupContent{
    [curTitle leSetText:curSettings.title];
    [curSplit setHidden:!curSettings.hasTopSplit];
    [curSubtitle leSetText:curSettings.subtitle];
    //    [curSubtitle leSetLineSpace:LayoutTextLineSpace];
    [curSubtitle leSetOffset:CGPointMake(0, curSettings.hasTopSplit?LayoutSideSpace:0)];
    [self initLeftButton];
    [self initRightButton];
    [self initCenterButton];
    [self onUpdatePopupLayout];
}
-(void) onUpdatePopupLayout{
    BOOL hasButton=(curSettings.leftButtonSetting&&curSettings.rightButtonSetting)||curSettings.centerButtonSetting;
    [curBottomBar setHidden:!hasButton];
    [curContentContainer leSetSize:CGSizeMake(curBackground.bounds.size.width, curBottomBar.frame.origin.y+(hasButton?btnHeight:0))];
    [curBackground leSetSize:CGSizeMake(curBackground.bounds.size.width, curBottomBar.frame.origin.y+(hasButton?btnHeight:0)+curSettings.contentInsects.top+curSettings.contentInsects.bottom)];
}
//
-(void) initLeftButton{
    if(curSettings.leftButtonSetting){
        curSettings.leftButtonSetting.leTargetView=self;
        curSettings.leftButtonSetting.leSEL=@selector(onLeft);
        if(curLeftButton){
            [curLeftButton removeTarget:self action:@selector(onLeft) forControlEvents:UIControlEventTouchUpInside];
            [curLeftButton removeFromSuperview];
        }
        if(UIEdgeInsetsEqualToEdgeInsets(curSettings.leftButtonEdge, UIEdgeInsetsZero)){
            curLeftButton=[LEUIFramework getUIButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curLeftBar Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] ButtonSettings:curSettings.leftButtonSetting];
        }else{
            curLeftButton=[LEUIFramework getUIButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curLeftBar EdgeInsects:curSettings.leftButtonEdge] ButtonSettings:curSettings.leftButtonSetting];
        }
    }
}
-(void) initRightButton{
    if(curSettings.rightButtonSetting){
        curSettings.rightButtonSetting.leTargetView=self;
        curSettings.rightButtonSetting.leSEL=@selector(onRight);
        if(curRightButton){
            [curRightButton removeTarget:self action:@selector(onRight) forControlEvents:UIControlEventTouchUpInside];
            [curRightButton removeFromSuperview];
        }
        if(UIEdgeInsetsEqualToEdgeInsets(curSettings.rightButtonEdge, UIEdgeInsetsZero)){
            curRightButton=[LEUIFramework getUIButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curRightBar Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] ButtonSettings:curSettings.rightButtonSetting];
        }else{
            curRightButton=[LEUIFramework getUIButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curRightBar EdgeInsects:curSettings.rightButtonEdge] ButtonSettings:curSettings.rightButtonSetting];
        }
    }
}
-(void) initCenterButton{
    if(curSettings.centerButtonSetting){
        curSettings.centerButtonSetting.leTargetView=self;
        curSettings.centerButtonSetting.leSEL=@selector(onCenter);
        if(curCenterButton){
            [curCenterButton removeTarget:self action:@selector(onCenter) forControlEvents:UIControlEventTouchUpInside];
            [curCenterButton removeFromSuperview];
        }
        if(UIEdgeInsetsEqualToEdgeInsets(curSettings.centerButtonEdge, UIEdgeInsetsZero)){
            curCenterButton=[LEUIFramework getUIButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curBottomBar Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] ButtonSettings:curSettings.centerButtonSetting];
        }else{
            curCenterButton=[LEUIFramework getUIButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curBottomBar EdgeInsects:curSettings.centerButtonEdge] ButtonSettings:curSettings.centerButtonSetting];
        }
    }
}
//
-(void) onLeft{
    [self easeOut:@selector(onLeftLogic)];
}
-(void) onLeftLogic{
    if(curSettings.curDelegate&&[curSettings.curDelegate respondsToSelector:@selector(onPopupLeftButtonClicked)]){
        [curSettings.curDelegate performSelector:@selector(onPopupLeftButtonClicked)];
    }
}
-(void) onRight{
    [self easeOut:@selector(onRightLogic)];
}
-(void) onRightLogic{
    if(curSettings.curDelegate&&[curSettings.curDelegate respondsToSelector:@selector(onPopupRightButtonClicked)]){
        [curSettings.curDelegate performSelector:@selector(onPopupRightButtonClicked)];
    }
}
-(void) onCenter{
    [self easeOut:@selector(onCenterLogic)];
}
-(void) onCenterLogic{
    if(curSettings.curDelegate&&[curSettings.curDelegate respondsToSelector:@selector(onPopupCenterButtonClicked)]){
        [curSettings.curDelegate performSelector:@selector(onPopupCenterButtonClicked)];
    }
}
-(void) onBackgroundTapped{
    [self easeOut:nil];
}
-(void) easeIn{
    [UIView animateWithDuration:0.4 animations:^(void){
        [self setAlpha:1];
    }];
}
-(void) easeOut:(SEL) sel{
    [UIView animateWithDuration:0.4 animations:^(void){
        [self setAlpha:0];
    } completion:^(BOOL done){
        if(sel){
            SuppressPerformSelectorLeakWarning(
                                               [self performSelector:sel];
                                               );
        }
        [self removeFromSuperview];
    }];
}
@end

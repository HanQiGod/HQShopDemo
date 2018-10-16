//
//  HQTabbar.m
//  HQShopDemo
//
//  Created by Mr_Han on 2018/10/16.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//

#import "HQTabbar.h"
#import "UIImage+HQImage.h"
#import "UIView+HQExtension.h"
#import "UIColor+HQColor.h"

#define LBMagin 10
@interface HQTabbar ()

/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn ;
/** 按钮文字 */
@property (nonatomic, strong) UILabel *label;

@end

@implementation HQTabbar


- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"发布";
        _label.font = [UIFont systemFontOfSize:11];
        [_label sizeToFit];
        _label.textColor = [UIColor colorWithHexString:@"#00b0f0"];
    }
    return _label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"icon_ticketLogo"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"icon_ticketLogo"] forState:UIControlStateHighlighted];
        
        self.plusBtn = plusBtn;
        
        
        [plusBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIControl * tabBarBtn in self.subviews) {
        
        //实现 tabBar 的点击事件
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [tabBarBtn addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    
    self.plusBtn.centerX = self.centerX;
    //调整发布按钮的中线点Y值
//    self.plusBtn.centerY = self.height * 0.5 - 2*LBMagin ;
//    self.plusBtn.size = CGSizeMake(self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
    self.plusBtn.centerY = self.height * 0.5 - 4*LBMagin ;
    self.plusBtn.size = CGSizeMake(60, 60);
    
    [self addSubview:self.label];
    self.label.centerX = self.plusBtn.centerX;
    self.label.centerY = CGRectGetMaxY(self.plusBtn.frame) + LBMagin ;
    
    
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的五分之一
            btn.width = self.width / 5;
            
            btn.x = btn.width * btnIndex;
            
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
            
        }
    }
    
    [self bringSubviewToFront:self.plusBtn];
    
    
}


- (void)tabBarButtonClick:(UIControl *)tarBarBtn
{
    for (UIView * img in tarBarBtn.subviews) {
        
        if ([img isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            
            //实现帧动画
            CAKeyframeAnimation * animation =[CAKeyframeAnimation animation];
            animation.keyPath =@"transform.scale";
            animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
            animation.duration = 1;
            animation.calculationMode = kCAAnimationCubic;
            //把动画添加上去
            [img.layer addAnimation:animation forKey:nil];
        }
    }
}


//点击了发布按钮
- (void)plusBtnDidClick
{
    //如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if ([self.delegate respondsToSelector:@selector(tabBarPlusBtnClick:)]) {
        [self.myDelegate tabBarPlusBtnClick:self];
    }
    
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}



@end

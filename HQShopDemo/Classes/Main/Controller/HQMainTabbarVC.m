//
//  HQMainTabbarVC.m
//  HQShopDemo
//
//  Created by Mr_Han on 2018/10/16.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "HQMainTabbarVC.h"

#import "UIImage+HQImage.h"
#import "UIColor+HQColor.h"
#import "HQHomeVC.h"
#import "HQProjectVC.h"
#import "HQMineVC.h"
#import "HQCartVC.h"
#import "HQGoodsCategroyVC.h"
#import "HQTabbar.h"

@interface HQMainTabbarVC () <UITabBarControllerDelegate,HQTabBarDelegate>



@end

@implementation HQMainTabbarVC

#pragma mark -- 系统方法

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    //设置底部菜单背景颜色
    //self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar_bg"];
    
    // 设置子控制器
    [self addChildViewControllers];
    
    [self setupNavigationView];
}
#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.7f;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:@"animation"];
}

#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:0.7f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

- (void)setupNavigationView {
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    // self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.backBarButtonItem = itemBack;
}

// 在viewWillAppear:方法中添加子控件才是显示在最上面的,同时badgeView的值会随时更新
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}


#pragma mark - 添加多个子控制器
- (void)addChildViewControllers {
    
    // 首页
    HQHomeVC *homeVC = [[HQHomeVC alloc]init];
    [self addOneChildViewController:homeVC title:@"首页" normalImage:[UIImage originalImageNamed:@"icon_home_"] pressedImage:[UIImage originalImageNamed:@"icon_home_sign"] navigationBarTitle:@""];
    
    // 分类
    HQGoodsCategroyVC *categoryVC = [[HQGoodsCategroyVC alloc] init];
    [self addOneChildViewController:categoryVC title:@"分类" normalImage:[UIImage originalImageNamed:@"icon_classification_"] pressedImage:[UIImage originalImageNamed:@"icon_classification_sign"] navigationBarTitle:@"分类"];
    
    // 专题
    //     JKProjectViewController *projectVC = [[JKProjectViewController alloc] init];
    //    [self addOneChildViewController:projectVC title:@"专题" normalImage:[UIImage originalImageNamed:@"icon_special"] pressedImage:[UIImage originalImageNamed:@"icon_special_sign"] navigationBarTitle:@"专题"];
    
    // 购物车
    HQCartVC *cartVC = [[HQCartVC alloc] init];
    [self addOneChildViewController:cartVC title:@"购物车" normalImage:[UIImage originalImageNamed:@"icon_cart"] pressedImage:[UIImage originalImageNamed:@"icon_car_sign"] navigationBarTitle:@"购物车"];
    
    // 我的
    HQMineVC *MyVC = [[HQMineVC alloc] init];
    [self addOneChildViewController:MyVC title:@"我的" normalImage:[UIImage originalImageNamed:@"icon_presonal"] pressedImage:[UIImage originalImageNamed:@"icon_presonal_sign"] navigationBarTitle:@""];
}

#pragma mark - 添加1个子控制器
- (void)addOneChildViewController:(UIViewController *)viewController
                            title:(NSString *)menutitle
                      normalImage:(UIImage *)normalImage
                     pressedImage:(UIImage *)pressedImage
               navigationBarTitle:(NSString *)title{
    
    // 设置子控制器导航条标题
    viewController.navigationItem.title = title;
    viewController.tabBarItem.title = menutitle;
    // 设置标签图片
    viewController.tabBarItem.image = normalImage;
    viewController.tabBarItem.selectedImage = pressedImage;
    
    //设置默认文字样式颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#00b0f0"];
    [viewController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //设置默认文字大小
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [viewController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [viewController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    //设置选中文字大小
    selectedTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [viewController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 添加子控制器至导航控制器
    UINavigationController *navigationVC
    = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    // 添加导航控制器
    [self addChildViewController:navigationVC];
    
    // 添加tabBarItem至数组
//    [self.tabBarItems addObject:viewController.tabBarItem];
    
    HQTabbar *tabBar = [[HQTabbar alloc] init];
    tabBar.myDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - 移除观察者
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(HQTabbar *)tabBar
{
    NSLog(@"凸出中间");
    HQProjectVC *projectVC = [[HQProjectVC alloc] init];
    [self.navigationController pushViewController:projectVC animated:YES];
}

#pragma mark --UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    [UIApplication sharedApplication].statusBarStyle = index==4?UIStatusBarStyleLightContent:UIStatusBarStyleDefault;
    
    return YES;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

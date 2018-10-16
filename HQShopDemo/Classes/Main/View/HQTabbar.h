//
//  HQTabbar.h
//  HQShopDemo
//
//  Created by Mr_Han on 2018/10/16.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HQTabbar;

@protocol HQTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(HQTabbar *)tabBar;
@end

NS_ASSUME_NONNULL_BEGIN

@interface HQTabbar : UITabBar

/** tabbar的代理 */
@property (nonatomic, weak) id<HQTabBarDelegate> myDelegate;

@end

NS_ASSUME_NONNULL_END

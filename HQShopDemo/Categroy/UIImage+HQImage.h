//
//  UIImage+HQImage.h
//  HQShopDemo
//
//  Created by Mr_Han on 2018/10/16.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HQImage)


/**
 *  根据颜色生成一张图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (instancetype)originalImageNamed:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END

//
//  UIColor+FFHex.h
//  FFPopup_Objc
//
//  Created by JonyFang on 2018/12/12.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FFHex)

+ (UIColor *)colorWithHex:(NSUInteger)hex;

+ (UIColor *)FFBlack;
+ (UIColor *)FFGray;
+ (UIColor *)FFLightGray;
+ (UIColor *)FFBlue;

@end

NS_ASSUME_NONNULL_END

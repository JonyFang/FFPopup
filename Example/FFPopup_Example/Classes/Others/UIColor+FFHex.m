//
//  UIColor+FFHex.m
//  FFPopup_Example
//
//  Created by JonyFang on 2018/12/12.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "UIColor+FFHex.h"

@implementation UIColor (FFHex)
+ (UIColor*) colorWithHex: (NSUInteger)hex {
    CGFloat red, green, blue, alpha;
    red = ((CGFloat)((hex >> 16) & 0xFF)) / ((CGFloat)0xFF);
    green = ((CGFloat)((hex >> 8) & 0xFF)) / ((CGFloat)0xFF);
    blue = ((CGFloat)((hex >> 0) & 0xFF)) / ((CGFloat)0xFF);
    alpha = hex > 0xFFFFFF ? ((CGFloat)((hex >> 24) & 0xFF)) / ((CGFloat)0xFF) : 1;
    
    return [UIColor colorWithRed: red green:green blue:blue alpha:alpha];
}
@end

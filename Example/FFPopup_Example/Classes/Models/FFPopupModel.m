//
//  FFPopupModel.m
//  FFPopup_Example
//
//  Created by JonyFang on 2018/12/11.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFPopupModel.h"

@implementation FFItemModel
@end

@implementation FFStateItemModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"types" : FFItemModel.class};
}
@end

@implementation FFActionItemModel
@end

@implementation FFPopupModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"layout" : FFStateItemModel.class,
             @"animation" : FFStateItemModel.class,
             @"mask" : @"FFStateItemModel",
             @"background" : @"FFActionItemModel",
             @"content" : @"FFActionItemModel",
             @"duration" : @"FFActionItemModel"
             };
}
@end

//
//  FFSelectionViewController.h
//  FFPopup_Objc
//
//  Created by JonyFang on 2018/11/29.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FFSelectionType) {
    FFSelectionType_None,
    FFSelectionType_HorizontalLayout,
    FFSelectionType_VerticalLayout,
    FFSelectionType_ShowAnimation,
    FFSelectionType_DismissAnimation,
    FFSelectionType_Mask
};

@class FFPopupModel;
@interface FFSelectionViewController : UIViewController
@property (nonatomic, copy, nullable) void(^selectedBlock)(void);
- (void)configureWithType:(FFSelectionType)type model:(FFPopupModel *)model;
@end

NS_ASSUME_NONNULL_END

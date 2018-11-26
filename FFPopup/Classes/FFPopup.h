//
//  FFPopup.h
//  FFPopup
//
//  Created by JonyFang on 2018/11/26.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 FFPopupShowType
 Controled how the popup will be presented.
 */
typedef NS_ENUM(NSUInteger, FFPopupShowType) {
    FFPopupShowType_None,
    FFPopupShowType_FadeIn,
    FFPopupShowType_GrowIn,
    FFPopupShowType_ShrinkIn,
    FFPopupShowType_SlideInFromTop,
    FFPopupShowType_SlideInFromBottom,
    FFPopupShowType_SlideInFromLeft,
    FFPopupShowType_SlideInFromRight,
    FFPopupShowType_BounceIn,
    FFPopupShowType_BounceInFromTop,
    FFPopupShowType_BounceInFromBottom,
    FFPopupShowType_BounceInFromLeft,
    FFPopupShowType_BounceInFromRight
};

/**
 FFPopupDismissType
 Controled how the popup will be dismissed.
 */
typedef NS_ENUM(NSUInteger, FFPopupDismissType) {
    FFPopupDismissType_None,
    FFPopupDismissType_FadeOut,
    FFPopupDismissType_GrowOut,
    FFPopupDismissType_ShrinkOut,
    FFPopupDismissType_SlideOutToTop,
    FFPopupDismissType_SlideOutToBottom,
    FFPopupDismissType_SlideOutToLeft,
    FFPopupDismissType_SlideOutToRight,
    FFPopupDismissType_BounceOut,
    FFPopupDismissType_BounceOutToTop,
    FFPopupDismissType_BounceOutToBottom,
    FFPopupDismissType_BounceOutToLeft,
    FFPopupDismissType_BounceOutToRight
};

/**
 FFPopupHorizontalLayout
 Controled the layout of the popup in the horizontal direction.
 */
typedef NS_ENUM(NSUInteger, FFPopupHorizontalLayout) {
    FFPopupHorizontalLayout_Custom,
    FFPopupHorizontalLayout_Left,
    FFPopupHorizontalLayout_LeftOfCenter,
    FFPopupHorizontalLayout_Center,
    FFPopupHorizontalLayout_RightOfCenter,
    FFPopupHoricontalLayout_Right
};

/**
 FFPopupVerticalLayout
 Controled the layout of the popup in the vertical direction.
 */
typedef NS_ENUM(NSUInteger, FFPopupVerticalLayout) {
    FFPopupVerticalLayout_Custom,
    FFPopupVerticalLayout_AboveCenter,
    FFPopupVerticalLayout_Center,
    FFPopupVerticalLayout_BelowCenter,
    FFPopupVerticalLayout_Bottom
};

/**
 FFPopupMaskType
 Controled whether to allow interaction with the underlying view.
 */
typedef NS_ENUM(NSUInteger, FFPopupMaskType) {
    /// Allow interaction with underlying view.
    FFPopupMaskType_None,
    /// Don't allow interaction with underlying view.
    FFPopupMaskType_Clear,
    /// Don't allow interaction with underlying view, dim background.
    FFPopupMaskType_Dimmed
};

/** FFPopupLayout */
struct FFPopupLayout {
    FFPopupHorizontalLayout horizontal;
    FFPopupVerticalLayout vertical;
};

typedef struct FFPopupLayout FFPopupLayout;

extern FFPopupLayout FFPopupLayoutMake(FFPopupHorizontalLayout horizontal, FFPopupVerticalLayout vertical);

extern const FFPopupLayout FFPopupLayoutCenter;

NS_ASSUME_NONNULL_BEGIN

@interface FFPopup : UIView

@end

NS_ASSUME_NONNULL_END

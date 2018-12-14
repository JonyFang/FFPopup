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
 Controlled how the popup will be presented.
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
 Controlled how the popup will be dismissed.
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
 Controlled the layout of the popup in the horizontal direction.
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
 Controlled the layout of the popup in the vertical direction.
 */
typedef NS_ENUM(NSUInteger, FFPopupVerticalLayout) {
    FFPopupVerticalLayout_Custom,
    FFPopupVerticalLayout_Top,
    FFPopupVerticalLayout_AboveCenter,
    FFPopupVerticalLayout_Center,
    FFPopupVerticalLayout_BelowCenter,
    FFPopupVerticalLayout_Bottom
};

/**
 FFPopupMaskType
 Controlled whether to allow interaction with the underlying view.
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

extern const FFPopupLayout FFPopupLayout_Center;

NS_ASSUME_NONNULL_BEGIN

@interface FFPopup : UIView

/**
 The view you want to appear in popup.
 
 Must provide contentView before or in `-willStartShowing`.
 Must set size of contentView before or in `-willStartShowing`.
 */
@property (nonatomic, strong) UIView *contentView;

/**
 Animation transition for presenting contentView.
 
 @discussion The default value is `FFPopupShowType_BounceInFromTop`.
 */
@property (nonatomic, assign) FFPopupShowType showType;

/**
 Animation transition for dismissing contentView.
 
 @discussion The default value is `FFPopupDismissType_BounceOutToBottom`.
 */
@property (nonatomic, assign) FFPopupDismissType dismissType;

/**
 Mask prevents background touches from passing to underlying views.
 
 @discussion The default value is `FFPopupMaskType_Dimmed`.
 */
@property (nonatomic, assign) FFPopupMaskType maskType;

/**
 Overrides alpha value for dimmed mask.
 
 @discussion The default value is `0.5`.
 */
@property (nonatomic, assign) CGFloat dimmedMaskAlpha;

/**
 Overrides animation duration for show in.
 
 @discussion The default value is `0.15`.
 */
@property (nonatomic, assign) CGFloat showInDuration;

/**
 Overrides animation duration for dismiss out.
 
 @discussion The default value is `0.15`.
 */
@property (nonatomic, assign) CGFloat dismissOutDuration;

/**
 If `YES`, the popup will dismiss when background is touched.
 
 @discussion The default value is `YES`.
 */
@property (nonatomic, assign) BOOL shouldDismissOnBackgroundTouch;

/**
 If `YES`, the popup will dismiss when content view is touched.
 
 @discussion The default value is `NO`.
 */
@property (nonatomic, assign) BOOL shouldDismissOnContentTouch;

/**
 A block to be executed when showing animation started.
 The default value is nil.
 */
@property (nonatomic, copy, nullable) void(^willStartShowingBlock)(void);

/**
 A block to be executed when showing animation finished.
 The default value is nil.
 */
@property (nonatomic, copy, nullable) void(^didFinishShowingBlock)(void);

/**
 A block to be executed when dismissing animation started.
 The default value is nil.
 */
@property (nonatomic, copy, nullable) void(^willStartDismissingBlock)(void);

/**
 A block to be executed when dismissing animation finished.
 The default value is nil.
 */
@property (nonatomic, copy, nullable) void(^didFinishDismissingBlock)(void);

/**
 Convenience Initializers
 Create a new popup with `contentView`.
 */
+ (FFPopup *)popupWithContentView:(UIView *)contentView;

/**
 Convenience Initializers
 Create a new popup with custom values.
 
 @param contentView The view you want to appear in popup.
 @param showType    The default value is `FFPopupShowType_BounceInFromTop`.
 @param dismissType The default value is `FFPopupDismissType_BounceOutToBottom`.
 @param maskType    The default value is `FFPopupMaskType_Dimmed`.
 @param shouldDismissOnBackgroundTouch  The default value is `YES`.
 @param shouldDismissOnContentTouch     The default value is `NO`.
 */
+ (FFPopup *)popupWithContentView:(UIView *)contentView
                         showType:(FFPopupShowType)showType
                      dismissType:(FFPopupDismissType)dismissType
                         maskType:(FFPopupMaskType)maskType
         dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch
            dismissOnContentTouch:(BOOL)shouldDismissOnContentTouch;

/**
 Dismiss all the popups in the app.
 */
+ (void)dismissAllPopups;

/**
 Dismiss the popup for contentView.
 */
+ (void)dismissPopupForView:(UIView *)view animated:(BOOL)animated;

/**
 Dismiss super popup.
 Iterate over superviews until you find a `FFPopup` and dismiss it.
 */
+ (void)dismissSuperPopupIn:(UIView *)view animated:(BOOL)animated;

/**
 Show popup with center layout.
 `FFPopupVerticalLayout_Center` & `FFPopupHorizontalLayout_Center`
 Showing animation is determined by `showType`.
 */
- (void)show;

/**
 Show popup with specified layout.
 Showing animation is determined by `showType`.
 */
- (void)showWithLayout:(FFPopupLayout)layout;

/**
 Show and then dismiss popup after `duration`.
 If duration is `0.0` or `less`, it will be considered infinity.
 */
- (void)showWithDuration:(NSTimeInterval)duration;

/**
 Show popup with specified `layout` and then dismissed after `duration`.
 If duration is `0.0` or `less`, it will be considered infinity.
 */
- (void)showWithLayout:(FFPopupLayout)layout duration:(NSTimeInterval)duration;

/**
 Show popup at point in view's coordinate system.
 If view is nil, will use screen base coordinates.
 */
- (void)showAtCenterPoint:(CGPoint)point inView:(UIView *)view;

/**
 Show popup at point in view's coordinate system and then dismissed after duration.
 If view is nil, will use screen base coordinates.
 If duration is `0.0` or `less`, it will be considered infinity.
 */
- (void)showAtCenterPoint:(CGPoint)point inView:(UIView *)view duration:(NSTimeInterval)duration;

/**
 Dismiss popup.
 Use `dismissType` if animated is `YES`.
 */
- (void)dismissAnimated:(BOOL)animated;

#pragma mark - ReadOnly Properties
@property (nonatomic, strong, readonly) UIView *backgroundView;
@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, assign, readonly) BOOL isBeingShown;
@property (nonatomic, assign, readonly) BOOL isShowing;
@property (nonatomic, assign, readonly) BOOL isBeingDismissed;

@end

NS_ASSUME_NONNULL_END

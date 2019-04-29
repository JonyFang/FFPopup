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
    FFPopupShowType_None NS_SWIFT_NAME(none),
    FFPopupShowType_FadeIn NS_SWIFT_NAME(fadeIn),
    FFPopupShowType_GrowIn NS_SWIFT_NAME(growIn),
    FFPopupShowType_ShrinkIn NS_SWIFT_NAME(shrinkIn),
    FFPopupShowType_SlideInFromTop NS_SWIFT_NAME(slideInFromTop),
    FFPopupShowType_SlideInFromBottom NS_SWIFT_NAME(slideInFromBottom),
    FFPopupShowType_SlideInFromLeft NS_SWIFT_NAME(slideInFromLeft),
    FFPopupShowType_SlideInFromRight NS_SWIFT_NAME(slideInFromRight),
    FFPopupShowType_BounceIn NS_SWIFT_NAME(bounceIn),
    FFPopupShowType_BounceInFromTop NS_SWIFT_NAME(bounceInFromTop),
    FFPopupShowType_BounceInFromBottom NS_SWIFT_NAME(bounceInFromBottom),
    FFPopupShowType_BounceInFromLeft NS_SWIFT_NAME(bounceInFromLeft),
    FFPopupShowType_BounceInFromRight NS_SWIFT_NAME(bounceInFromRight)
} NS_SWIFT_NAME(FFPopup.ShowType);

/**
 FFPopupDismissType
 Controlled how the popup will be dismissed.
 */
typedef NS_ENUM(NSUInteger, FFPopupDismissType) {
    FFPopupDismissType_None NS_SWIFT_NAME(none),
    FFPopupDismissType_FadeOut NS_SWIFT_NAME(fadeOut),
    FFPopupDismissType_GrowOut NS_SWIFT_NAME(growOut),
    FFPopupDismissType_ShrinkOut NS_SWIFT_NAME(shrinkOut),
    FFPopupDismissType_SlideOutToTop NS_SWIFT_NAME(slideOutToTop),
    FFPopupDismissType_SlideOutToBottom NS_SWIFT_NAME(slideOutToBottom),
    FFPopupDismissType_SlideOutToLeft NS_SWIFT_NAME(slideOutToLeft),
    FFPopupDismissType_SlideOutToRight NS_SWIFT_NAME(slideOutToRight),
    FFPopupDismissType_BounceOut NS_SWIFT_NAME(bounceOut),
    FFPopupDismissType_BounceOutToTop NS_SWIFT_NAME(bounceOutToTop),
    FFPopupDismissType_BounceOutToBottom NS_SWIFT_NAME(bounceOutToBottom),
    FFPopupDismissType_BounceOutToLeft NS_SWIFT_NAME(bounceOutToLeft),
    FFPopupDismissType_BounceOutToRight NS_SWIFT_NAME(bounceOutToRight)
} NS_SWIFT_NAME(FFPopup.DismissType);

/**
 FFPopupHorizontalLayout
 Controlled the layout of the popup in the horizontal direction.
 */
typedef NS_ENUM(NSUInteger, FFPopupHorizontalLayout) {
    FFPopupHorizontalLayout_Custom NS_SWIFT_NAME(custom),
    FFPopupHorizontalLayout_Left NS_SWIFT_NAME(left),
    FFPopupHorizontalLayout_LeftOfCenter NS_SWIFT_NAME(leftOfCenter),
    FFPopupHorizontalLayout_Center NS_SWIFT_NAME(center),
    FFPopupHorizontalLayout_RightOfCenter NS_SWIFT_NAME(rightOfCenter),
    FFPopupHoricontalLayout_Right NS_SWIFT_NAME(right)
} NS_SWIFT_NAME(FFPopup.HorizontalLayout);

/**
 FFPopupVerticalLayout
 Controlled the layout of the popup in the vertical direction.
 */
typedef NS_ENUM(NSUInteger, FFPopupVerticalLayout) {
    FFPopupVerticalLayout_Custom NS_SWIFT_NAME(custom),
    FFPopupVerticalLayout_Top NS_SWIFT_NAME(top),
    FFPopupVerticalLayout_AboveCenter NS_SWIFT_NAME(aboveCenter),
    FFPopupVerticalLayout_Center NS_SWIFT_NAME(center),
    FFPopupVerticalLayout_BelowCenter NS_SWIFT_NAME(belowCenter),
    FFPopupVerticalLayout_Bottom NS_SWIFT_NAME(bottom)
} NS_SWIFT_NAME(FFPopup.VerticalLayout);

/**
 FFPopupMaskType
 Controlled whether to allow interaction with the underlying view.
 */
typedef NS_ENUM(NSUInteger, FFPopupMaskType) {
    /// Allow interaction with underlying view.
    FFPopupMaskType_None NS_SWIFT_NAME(none),
    /// Don't allow interaction with underlying view.
    FFPopupMaskType_Clear NS_SWIFT_NAME(clear),
    /// Don't allow interaction with underlying view, dim background.
    FFPopupMaskType_Dimmed NS_SWIFT_NAME(dimmed)
} NS_SWIFT_NAME(FFPopup.MaskType);

/** FFPopupLayout */
struct FFPopupLayout {
    FFPopupHorizontalLayout horizontal;
    FFPopupVerticalLayout vertical;
};

typedef struct FFPopupLayout FFPopupLayout;

extern FFPopupLayout FFPopupLayoutMake(FFPopupHorizontalLayout horizontal, FFPopupVerticalLayout vertical) NS_SWIFT_NAME(FFpopupLayout(horizontal:vertical:));

extern FFPopupLayout const FFPopupLayout_Center NS_SWIFT_NAME(FFPopupLayout.Center);

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
            dismissOnContentTouch:(BOOL)shouldDismissOnContentTouch NS_SWIFT_NAME(popup(contetnView:showType:dismissType:maskType:dismissOnBackgroundTouch:dismissOnContentTouch:));

/**
 Dismiss all the popups in the app.
 */
+ (void)dismissAllPopups;

/**
 Dismiss the popup for contentView.
 */
+ (void)dismissPopupForView:(UIView *)view animated:(BOOL)animated NS_SWIFT_NAME(dismiss(contentView:animated:));

/**
 Dismiss super popup.
 Iterate over superviews until you find a `FFPopup` and dismiss it.
 */
+ (void)dismissSuperPopupIn:(UIView *)view animated:(BOOL)animated NS_SWIFT_NAME(dismissSuperPopup(inView:animated:));

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
- (void)showWithLayout:(FFPopupLayout)layout NS_SWIFT_NAME(show(layout:));

/**
 Show and then dismiss popup after `duration`.
 If duration is `0.0` or `less`, it will be considered infinity.
 */
- (void)showWithDuration:(NSTimeInterval)duration NS_SWIFT_NAME(show(duration:));

/**
 Show popup with specified `layout` and then dismissed after `duration`.
 If duration is `0.0` or `less`, it will be considered infinity.
 */
- (void)showWithLayout:(FFPopupLayout)layout duration:(NSTimeInterval)duration NS_SWIFT_NAME(show(layout:duration:));

/**
 Show popup at point in view's coordinate system.
 If view is nil, will use screen base coordinates.
 */
- (void)showAtCenterPoint:(CGPoint)point inView:(UIView *)view NS_SWIFT_NAME(show(center:inView:));

/**
 Show popup at point in view's coordinate system and then dismissed after duration.
 If view is nil, will use screen base coordinates.
 If duration is `0.0` or `less`, it will be considered infinity.
 */
- (void)showAtCenterPoint:(CGPoint)point inView:(UIView *)view duration:(NSTimeInterval)duration NS_SWIFT_NAME(show(center:inView:duration:));

/**
 Dismiss popup.
 Use `dismissType` if animated is `YES`.
 */
- (void)dismissAnimated:(BOOL)animated NS_SWIFT_NAME(dismiss(animated:));

#pragma mark - ReadOnly Properties
@property (nonatomic, strong, readonly) UIView *backgroundView;
@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, assign, readonly) BOOL isBeingShown;
@property (nonatomic, assign, readonly) BOOL isShowing;
@property (nonatomic, assign, readonly) BOOL isBeingDismissed;

@end

NS_ASSUME_NONNULL_END

//
//  FFPopup.m
//  FFPopup
//
//  Created by JonyFang on 2018/11/26.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFPopup.h"

static const CGFloat kDefaultSpringDamping = 0.8;
static const CGFloat kDefaultSpringVelocity = 10.0;
static const CGFloat kDefaultAnimateDuration = 0.15;
static const NSInteger kAnimationOptionCurve = (7 << 16);
static NSString *const kParametersViewName = @"parameters.view";
static NSString *const kParametersLayoutName = @"parameters.layout";
static NSString *const kParametersCenterName = @"parameters.center-point";
static NSString *const kParametersDurationName = @"parameters.duration";

FFPopupLayout FFPopupLayoutMake(FFPopupHorizontalLayout horizontal, FFPopupVerticalLayout vertical) {
    FFPopupLayout layout;
    layout.horizontal = horizontal;
    layout.vertical = vertical;
    return layout;
}

const FFPopupLayout FFPopupLayout_Center = { FFPopupHorizontalLayout_Center, FFPopupVerticalLayout_Center };

/**
 FFPopupLayout Value.
 Typically, you should not use this class directly.
 */
@interface NSValue (FFPopupLayout)
+ (NSValue *)valueWithFFPopupLayout:(FFPopupLayout)layout;
- (FFPopupLayout)FFPopupLayoutValue;
@end

/**
 Interate the views to find a FFPopup.
 */
@interface UIView (FFPopup)
///Iterate the subviews, if you find a FFPopup and block it.
- (void)containsPopupBlock:(void (^)(FFPopup *popup))block;
///Iterate over superviews until you find a FFPopup and dismiss it.
- (void)dismissShowingPopup:(BOOL)animated;
@end

/**
 FFPopup Class.
 */
@interface FFPopup ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, assign) BOOL isBeingShown;
@property (nonatomic, assign) BOOL isBeingDismissed;

@end

@implementation FFPopup

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = UIColor.clearColor;
        self.alpha = 0.0;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.autoresizesSubviews = YES;
        
        self.shouldDismissOnBackgroundTouch = YES;
        self.shouldDismissOnContentTouch = NO;
        
        self.showType = FFPopupShowType_BounceInFromTop;
        self.dismissType = FFPopupDismissType_BounceOutToBottom;
        self.maskType = FFPopupMaskType_Dimmed;
        self.dimmedMaskAlpha = 0.5;
        
        _isBeingShown = NO;
        _isShowing = NO;
        _isBeingDismissed = NO;
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.containerView];
        
        /// Register for notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeStatusbarOrientation:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        /// If backgroundTouch flag is set, try to dismiss.
        if (_shouldDismissOnBackgroundTouch) {
            [self dismissAnimated:YES];
        }
        /// If there is no mask, retuen nil. So touch passes through to underlying views.
        return _maskType == FFPopupMaskType_None ? nil : hitView;
    } else {
        /// If view in within containterView and contentTouch flag is set, try to dismiss.
        if ([hitView isDescendantOfView:_containerView] && _shouldDismissOnContentTouch) {
            [self dismissAnimated:YES];
        }
        return hitView;
    }
}

#pragma mark - Public Class Methods
+ (FFPopup *)popupWithContentView:(UIView *)contentView {
    FFPopup *popup = [[[self class] alloc] init];
    popup.contentView = contentView;
    return popup;
}

+ (FFPopup *)popupWithContentView:(UIView *)contentView
                         showType:(FFPopupShowType)showType
                      dismissType:(FFPopupDismissType)dismissType
                         maskType:(FFPopupMaskType)maskType
         dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch
            dismissOnContentTouch:(BOOL)shouldDismissOnContentTouch {
    FFPopup *popup = [[[self class] alloc] init];
    popup.contentView = contentView;
    popup.showType = showType;
    popup.dismissType = dismissType;
    popup.maskType = maskType;
    popup.shouldDismissOnBackgroundTouch = shouldDismissOnBackgroundTouch;
    popup.shouldDismissOnContentTouch = shouldDismissOnContentTouch;
    return popup;
}

+ (void)dismissAllPopups {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        [window containsPopupBlock:^(FFPopup * _Nonnull popup) {
            [popup dismissAnimated:NO];
        }];
    }
}

+ (void)dismissPopupForView:(UIView *)view animated:(BOOL)animated {
    [view dismissShowingPopup:animated];
}

+ (void)dismissSuperPopupIn:(UIView *)view animated:(BOOL)animated {
    [view dismissShowingPopup:animated];
}

#pragma mark - Public Instance Methods
- (void)show {
    [self showWithLayout:FFPopupLayout_Center];
}

- (void)showWithLayout:(FFPopupLayout)layout {
    [self showWithLayout:layout duration:0.0];
}

- (void)showWithDuration:(NSTimeInterval)duration {
    [self showWithLayout:FFPopupLayout_Center duration:duration];
}

- (void)showWithLayout:(FFPopupLayout)layout duration:(NSTimeInterval)duration {
    NSDictionary *parameters = @{kParametersLayoutName: [NSValue valueWithFFPopupLayout:layout],
                                 kParametersDurationName: @(duration)};
    [self showWithParameters:parameters];
}

- (void)showAtCenterPoint:(CGPoint)point inView:(UIView *)view {
    [self showAtCenterPoint:point inView:view duration:0.0];
}

- (void)showAtCenterPoint:(CGPoint)point inView:(UIView *)view duration:(NSTimeInterval)duration {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:[NSValue valueWithCGPoint:point] forKey:kParametersCenterName];
    [parameters setValue:@(duration) forKey:kParametersDurationName];
    [parameters setValue:view forKey:kParametersViewName];
    [self showWithParameters:parameters.mutableCopy];
}

- (void)dismissAnimated:(BOOL)animated {
    [self dismiss:animated];
}

#pragma mark - Private Methods
- (void)showWithParameters:(NSDictionary *)parameters {
    /// If popup can be shown
    if (!_isBeingShown && !_isShowing && !_isBeingDismissed) {
        _isBeingShown = YES;
        _isShowing = NO;
        _isBeingDismissed = NO;
        
        if (self.willStartShowingBlock != nil) {
            self.willStartShowingBlock();
        }
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            /// Preparing to add popup to the top window.
            if (!strongSelf.superview) {
                NSEnumerator *reverseWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
                for (UIWindow *window in reverseWindows) {
                    if (window.windowLevel == UIWindowLevelNormal) {
                        [window addSubview:self];
                        break;
                    }
                }
            }
            
            /// Before we calculate the layout of the containerView, we have to make sure that we have transformed for current orientation.
            [strongSelf updateInterfaceOrientation];
            
            /// Make sure popup isn't hidden.
            strongSelf.hidden = NO;
            strongSelf.alpha = 1.0;
            
            /// Setup background view
            strongSelf.backgroundView.alpha = 0.0;
            if (strongSelf.maskType == FFPopupMaskType_Dimmed) {
                strongSelf.backgroundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:strongSelf.dimmedMaskAlpha];
            } else {
                strongSelf.backgroundView.backgroundColor = UIColor.clearColor;
            }
            
            /// Animate backgroundView animation if need.
            void (^backgroundAnimationBlock)(void) = ^(void) {
                strongSelf.backgroundView.alpha = 1.0;
            };
            
            /// Custom backgroundView showing animation.
            if (strongSelf.showType != FFPopupShowType_None) {
                CGFloat showInDuration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                [UIView animateWithDuration:showInDuration
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveLinear
                                 animations:backgroundAnimationBlock
                                 completion:NULL];
            } else {
                backgroundAnimationBlock();
            }
            
            /// Dismiss popup after duration. Default value is 0.0.
            NSNumber *durationNumber = parameters[kParametersDurationName];
            NSTimeInterval duration = durationNumber != nil ? durationNumber.doubleValue : 0.0;
            
            /// Setup completion block
            void (^completionBlock)(BOOL) = ^(BOOL finished) {
                strongSelf.isBeingShown = NO;
                strongSelf.isShowing = YES;
                strongSelf.isBeingDismissed = NO;
                if (strongSelf.didFinishShowingBlock) {
                    strongSelf.didFinishShowingBlock();
                }
                ///Dismiss popup after duration, if duration is greater than 0.0.
                if (duration > 0.0) {
                    [strongSelf performSelector:@selector(dismiss) withObject:nil afterDelay:duration];
                }
            };
            
            /// Add contentVidew as subView to container.
            if (strongSelf.contentView.superview != strongSelf.containerView) {
                [strongSelf.containerView addSubview:strongSelf.contentView];
            }
            
            /// If the contentView is using autolayout, need to relayout the contentView.
            [strongSelf.contentView layoutIfNeeded];
            
            /// Size container to match contentView.
            CGRect containerFrame = strongSelf.containerView.frame;
            containerFrame.size = strongSelf.contentView.frame.size;
            strongSelf.containerView.frame = containerFrame;
            
            /// Position contentView to fill popup.
            CGRect contentFrame = strongSelf.contentView.frame;
            contentFrame.origin = CGPointZero;
            strongSelf.contentView.frame = contentFrame;
            
            /// Reset containerView's constraints in case contentView is using autolayout.
            UIView *contentView = strongSelf.contentView;
            NSDictionary *viewsDict = NSDictionaryOfVariableBindings(contentView);
            [strongSelf.containerView removeConstraints:strongSelf.containerView.constraints];
            [strongSelf.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:viewsDict]];
            [strongSelf.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:viewsDict]];
            
            /// Determine final position and necessary autoresizingMask for container.
            CGRect finalContainerFrame = containerFrame;
            UIViewAutoresizing containerAutoresizingMask = UIViewAutoresizingNone;
            
            /// Use explicit center coordinates if provided.
            NSValue *centerValue = parameters[kParametersCenterName];
            if (centerValue) {
                CGPoint centerInView = centerValue.CGPointValue;
                CGPoint centerInSelf;
                /// Convert coordinates from provided view to self.
                UIView *fromView = parameters[kParametersViewName];
                centerInSelf = fromView != nil ? [self convertPoint:centerInView toView:fromView] : centerInView;
                finalContainerFrame.origin.x = centerInSelf.x - CGRectGetWidth(finalContainerFrame)*0.5;
                finalContainerFrame.origin.y = centerInSelf.y - CGRectGetHeight(finalContainerFrame)*0.5;
                containerAutoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
            } else {
                /// Otherwise use relative layout. Default value is center.
                NSValue *layoutValue = parameters[kParametersLayoutName];
                FFPopupLayout layout = layoutValue ? [layoutValue FFPopupLayoutValue] : FFPopupLayout_Center;
                /// Layout of the horizontal.
                switch (layout.horizontal) {
                    case FFPopupHorizontalLayout_Left:
                        finalContainerFrame.origin.x = 0.0;
                        containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleRightMargin;
                        break;
                    case FFPopupHoricontalLayout_Right:
                        finalContainerFrame.origin.x = CGRectGetWidth(strongSelf.bounds) - CGRectGetWidth(containerFrame);
                        containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleLeftMargin;
                        break;
                    case FFPopupHorizontalLayout_LeftOfCenter:
                        finalContainerFrame.origin.x = floorf(CGRectGetWidth(strongSelf.bounds) / 3.0 - CGRectGetWidth(containerFrame) * 0.5);
                        containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
                        break;
                    case FFPopupHorizontalLayout_RightOfCenter:
                        finalContainerFrame.origin.x = floorf(CGRectGetWidth(strongSelf.bounds) * 2.0 / 3.0 - CGRectGetWidth(containerFrame) * 0.5);
                        containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
                        break;
                    case FFPopupHorizontalLayout_Center:
                        finalContainerFrame.origin.x = floorf((CGRectGetWidth(strongSelf.bounds) - CGRectGetWidth(containerFrame)) * 0.5);
                        containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
                        break;
                    default:
                        break;
                }
                
                /// Layout of the vertical.
                switch (layout.vertical) {
                    case FFPopupVerticalLayout_Top:
                        finalContainerFrame.origin.y = 0.0;
                        containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleBottomMargin;
                        break;
                    case FFPopupVerticalLayout_AboveCenter:
                        finalContainerFrame.origin.y = floorf(CGRectGetHeight(self.bounds) / 3.0 - CGRectGetHeight(containerFrame) * 0.5);
                        containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
                        break;
                    case FFPopupVerticalLayout_Center:
                        finalContainerFrame.origin.y = floorf((CGRectGetHeight(self.bounds) - CGRectGetHeight(containerFrame)) * 0.5);
                        containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
                        break;
                    case FFPopupVerticalLayout_BelowCenter:
                        finalContainerFrame.origin.y = floorf(CGRectGetHeight(self.bounds) * 2.0 / 3.0 - CGRectGetHeight(containerFrame) * 0.5);
                        containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
                        break;
                    case FFPopupVerticalLayout_Bottom:
                        finalContainerFrame.origin.y = CGRectGetHeight(self.bounds) - CGRectGetHeight(containerFrame);
                        containerAutoresizingMask = containerAutoresizingMask | UIViewAutoresizingFlexibleTopMargin;
                        break;
                    default:
                        break;
                }
            }
            
            strongSelf.containerView.autoresizingMask = containerAutoresizingMask;
            
            /// Animate contentView if needed.
            switch (strongSelf.showType) {
                case FFPopupShowType_FadeIn: {
                    strongSelf.containerView.alpha = 0.0;
                    strongSelf.containerView.transform = CGAffineTransformIdentity;
                    strongSelf.containerView.frame = finalContainerFrame;
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        strongSelf.containerView.alpha = 1.0;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_GrowIn: {
                    strongSelf.containerView.alpha = 0.0;
                    strongSelf.containerView.frame = finalContainerFrame;
                    strongSelf.containerView.transform = CGAffineTransformMakeScale(0.85, 0.85);
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 options:kAnimationOptionCurve animations:^{
                        strongSelf.containerView.alpha = 1.0;
                        strongSelf.containerView.transform = CGAffineTransformIdentity;
                        strongSelf.containerView.frame = finalContainerFrame;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_ShrinkIn: {
                    strongSelf.containerView.alpha = 0.0;
                    strongSelf.containerView.frame = finalContainerFrame;
                    strongSelf.containerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 options:kAnimationOptionCurve animations:^{
                        strongSelf.containerView.alpha = 1.0;
                        strongSelf.containerView.frame = finalContainerFrame;
                        strongSelf.containerView.transform = CGAffineTransformIdentity;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_SlideInFromTop: {
                    strongSelf.containerView.alpha = 1.0;
                    strongSelf.transform = CGAffineTransformIdentity;
                    CGRect startFrame = finalContainerFrame;
                    startFrame.origin.y = - CGRectGetHeight(finalContainerFrame);
                    strongSelf.containerView.frame = startFrame;
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 options:kAnimationOptionCurve animations:^{
                        strongSelf.containerView.frame = finalContainerFrame;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_SlideInFromBottom: {
                    strongSelf.containerView.alpha = 1.0;
                    strongSelf.containerView.transform = CGAffineTransformIdentity;
                    CGRect startFrame = finalContainerFrame;
                    startFrame.origin.y = CGRectGetHeight(self.bounds);
                    strongSelf.containerView.frame = startFrame;
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 options:kAnimationOptionCurve animations:^{
                        strongSelf.containerView.frame = finalContainerFrame;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_SlideInFromLeft: {
                    strongSelf.containerView.alpha = 1.0;
                    strongSelf.containerView.transform = CGAffineTransformIdentity;
                    CGRect startFrame = finalContainerFrame;
                    startFrame.origin.x = - CGRectGetWidth(finalContainerFrame);
                    strongSelf.containerView.frame = startFrame;
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 options:kAnimationOptionCurve animations:^{
                        strongSelf.containerView.frame = finalContainerFrame;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_SlideInFromRight: {
                    strongSelf.containerView.alpha = 1.0;
                    strongSelf.containerView.transform = CGAffineTransformIdentity;
                    CGRect startFrame = finalContainerFrame;
                    startFrame.origin.x = CGRectGetWidth(self.bounds);
                    strongSelf.containerView.frame = startFrame;
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 options:kDefaultAnimateDuration animations:^{
                        strongSelf.containerView.frame = finalContainerFrame;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_BounceIn: {
                    strongSelf.containerView.alpha = 0.0;
                    strongSelf.containerView.frame = finalContainerFrame;
                    strongSelf.containerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:0 animations:^{
                        strongSelf.containerView.alpha = 1.0;
                        strongSelf.containerView.transform = CGAffineTransformIdentity;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_BounceInFromTop: {
                    strongSelf.containerView.alpha = 1.0;
                    strongSelf.containerView.transform = CGAffineTransformIdentity;
                    CGRect startFrame = finalContainerFrame;
                    startFrame.origin.y = - CGRectGetHeight(finalContainerFrame);
                    strongSelf.containerView.frame = startFrame;
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:0 animations:^{
                        strongSelf.containerView.frame = finalContainerFrame;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_BounceInFromBottom: {
                    strongSelf.containerView.alpha = 1.0;
                    strongSelf.containerView.transform = CGAffineTransformIdentity;
                    CGRect startFrame = finalContainerFrame;
                    startFrame.origin.y = CGRectGetHeight(self.bounds);
                    strongSelf.containerView.frame = startFrame;
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:0 animations:^{
                        strongSelf.containerView.frame = finalContainerFrame;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_BounceInFromLeft: {
                    strongSelf.containerView.alpha = 1.0;
                    strongSelf.containerView.transform = CGAffineTransformIdentity;
                    CGRect startFrame = finalContainerFrame;
                    startFrame.origin.x = - CGRectGetWidth(finalContainerFrame);
                    strongSelf.containerView.frame = startFrame;
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:0 animations:^{
                        strongSelf.containerView.frame = finalContainerFrame;
                    } completion:completionBlock];
                }   break;
                case FFPopupShowType_BounceInFromRight: {
                    strongSelf.containerView.alpha = 1.0;
                    strongSelf.containerView.transform = CGAffineTransformIdentity;
                    CGRect startFrame = finalContainerFrame;
                    startFrame.origin.x = CGRectGetWidth(self.bounds);
                    strongSelf.containerView.frame = startFrame;
                    CGFloat duration = strongSelf.showInDuration ?: kDefaultAnimateDuration;
                    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:0 animations:^{
                        strongSelf.containerView.frame = finalContainerFrame;
                    } completion:completionBlock];
                }   break;
                default: {
                    strongSelf.containerView.alpha = 1.0;
                    strongSelf.containerView.frame = finalContainerFrame;
                    strongSelf.containerView.transform = CGAffineTransformIdentity;
                    completionBlock(YES);
                }   break;
            }
        });
    }
}

- (void)dismiss:(BOOL)animated {
    if (_isShowing && !_isBeingDismissed) {
        _isShowing = NO;
        _isBeingShown = NO;
        _isBeingDismissed = YES;
        
        /// Cancel previous `-dismissAnimated:` requests.
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
        
        if (self.willStartDismissingBlock) {
            self.willStartDismissingBlock();
        }
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = self;
            /// Animate backgroundView if needed.
            void (^backgroundAnimationBlock)(void) = ^(void) {
                strongSelf.backgroundView.alpha = 0.0;
            };
            
            /// Custom backgroundView dismissing animation.
            if (animated && strongSelf.showType != FFPopupShowType_None) {
                CGFloat duration = strongSelf.dismissOutDuration ?: kDefaultAnimateDuration;
                [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:backgroundAnimationBlock completion:NULL];
            } else {
                backgroundAnimationBlock();
            }
            
            /// Setup completion block.
            void (^completionBlock)(BOOL) = ^(BOOL finished) {
                [strongSelf removeFromSuperview];
                strongSelf.isBeingShown = NO;
                strongSelf.isShowing = NO;
                strongSelf.isBeingDismissed = NO;
                if (strongSelf.didFinishDismissingBlock) {
                    strongSelf.didFinishDismissingBlock();
                }
            };
            
            NSTimeInterval duration = strongSelf.dismissOutDuration ?: kDefaultAnimateDuration;
            NSTimeInterval bounceDurationA = duration * 1.0 / 3.0;
            NSTimeInterval bounceDurationB = duration * 2.0 / 3.0;
            
            /// Animate contentView if needed.
            if (animated) {
                NSTimeInterval dismissOutDuration = strongSelf.dismissOutDuration ?: kDefaultAnimateDuration;
                switch (strongSelf.dismissType) {
                    case FFPopupDismissType_FadeOut: {
                        [UIView animateWithDuration:dismissOutDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                            strongSelf.containerView.alpha = 0.0;
                        } completion:completionBlock];
                    }   break;
                    case FFPopupDismissType_GrowOut: {
                        [UIView animateKeyframesWithDuration:dismissOutDuration delay:0.0 options:kAnimationOptionCurve animations:^{
                            strongSelf.containerView.alpha = 0.0;
                            strongSelf.containerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                        } completion:completionBlock];
                    }   break;
                    case FFPopupDismissType_ShrinkOut: {
                        [UIView animateWithDuration:dismissOutDuration delay:0.0 options:kAnimationOptionCurve animations:^{
                            strongSelf.containerView.alpha = 0.0;
                            strongSelf.containerView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                        } completion:completionBlock];
                    }   break;
                    case FFPopupDismissType_SlideOutToTop: {
                        CGRect finalFrame = strongSelf.containerView.frame;
                        finalFrame.origin.y = - CGRectGetHeight(finalFrame);
                        [UIView animateWithDuration:dismissOutDuration delay:0.0 options:kAnimationOptionCurve animations:^{
                            strongSelf.containerView.frame = finalFrame;
                        } completion:completionBlock];
                    }   break;
                    case FFPopupDismissType_SlideOutToBottom: {
                        CGRect finalFrame = strongSelf.containerView.frame;
                        finalFrame.origin.y = CGRectGetHeight(strongSelf.bounds);
                        [UIView animateWithDuration:dismissOutDuration delay:0.0 options:kAnimationOptionCurve animations:^{
                            strongSelf.containerView.frame = finalFrame;
                        } completion:completionBlock];
                    }   break;
                    case FFPopupDismissType_SlideOutToLeft: {
                        CGRect finalFrame = strongSelf.containerView.frame;
                        finalFrame.origin.x = - CGRectGetWidth(finalFrame);
                        [UIView animateWithDuration:dismissOutDuration delay:0.0 options:kAnimationOptionCurve animations:^{
                            strongSelf.containerView.frame = finalFrame;
                        } completion:completionBlock];
                    }   break;
                    case FFPopupDismissType_SlideOutToRight: {
                        CGRect finalFrame = strongSelf.containerView.frame;
                        finalFrame.origin.x = CGRectGetWidth(strongSelf.bounds);
                        [UIView animateWithDuration:dismissOutDuration delay:0.0 options:kAnimationOptionCurve animations:^{
                            strongSelf.containerView.frame = finalFrame;
                        } completion:completionBlock];
                    }   break;
                    case FFPopupDismissType_BounceOut: {
                        [UIView animateWithDuration:bounceDurationA delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                            strongSelf.containerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:bounceDurationB delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                                strongSelf.containerView.alpha = 0.0;
                                strongSelf.containerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                            } completion:completionBlock];
                        }];
                    }   break;
                    case FFPopupDismissType_BounceOutToTop: {
                        CGRect finalFrameA = strongSelf.containerView.frame;
                        finalFrameA.origin.y += 20.0;
                        CGRect finalFrameB = strongSelf.containerView.frame;
                        finalFrameB.origin.y = - CGRectGetHeight(finalFrameB);
                        [UIView animateWithDuration:bounceDurationA delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                            strongSelf.containerView.frame = finalFrameA;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:bounceDurationB delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                                strongSelf.containerView.frame = finalFrameB;
                            } completion:completionBlock];
                        }];
                    }   break;
                    case FFPopupDismissType_BounceOutToBottom: {
                        CGRect finalFrameA = strongSelf.containerView.frame;
                        finalFrameA.origin.y -= 20;
                        CGRect finalFrameB = strongSelf.containerView.frame;
                        finalFrameB.origin.y = CGRectGetHeight(self.bounds);
                        [UIView animateWithDuration:bounceDurationA delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                            strongSelf.containerView.frame = finalFrameA;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:bounceDurationB delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                                strongSelf.containerView.frame = finalFrameB;
                            } completion:completionBlock];
                        }];
                    }   break;
                    case FFPopupDismissType_BounceOutToLeft: {
                        CGRect finalFrameA = strongSelf.containerView.frame;
                        finalFrameA.origin.x += 20.0;
                        CGRect finalFrameB = strongSelf.containerView.frame;
                        finalFrameB.origin.x = - CGRectGetWidth(finalFrameB);
                        [UIView animateWithDuration:bounceDurationA delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                            strongSelf.containerView.frame = finalFrameA;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:bounceDurationB delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                                strongSelf.containerView.frame = finalFrameB;
                            } completion:completionBlock];
                        }];
                    }   break;
                    case FFPopupDismissType_BounceOutToRight: {
                        CGRect finalFrameA = strongSelf.containerView.frame;
                        finalFrameA.origin.x -= 20.0;
                        CGRect finalFrameB = strongSelf.containerView.frame;
                        finalFrameB.origin.x = CGRectGetWidth(strongSelf.bounds);
                        [UIView animateWithDuration:bounceDurationA delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                            strongSelf.containerView.frame = finalFrameA;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:bounceDurationB delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                                strongSelf.containerView.frame = finalFrameB;
                            } completion:completionBlock];
                        }];
                    }   break;
                    default: {
                        strongSelf.containerView.alpha = 0.0;
                        completionBlock(YES);
                    }   break;
                }
            } else {
                strongSelf.containerView.alpha = 0.0;
                completionBlock(YES);
            }
        });
    }
}

- (void)didChangeStatusbarOrientation:(NSNotification *)notification {
    [self updateInterfaceOrientation];
}

- (void)updateInterfaceOrientation {
    self.frame = self.window.bounds;
}

- (void)dismiss {
    [self dismiss:YES];
}

#pragma mark - Properties
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = UIColor.clearColor;
        _backgroundView.userInteractionEnabled = NO;
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundView.frame = self.bounds;
    }
    return _backgroundView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.autoresizesSubviews = NO;
        _containerView.userInteractionEnabled = YES;
        _containerView.backgroundColor = UIColor.clearColor;
    }
    return _containerView;
}

@end

@implementation NSValue (FFPopupLayout)
+ (NSValue *)valueWithFFPopupLayout:(FFPopupLayout)layout {
    return [NSValue valueWithBytes:&layout objCType:@encode(FFPopupLayout)];
}

- (FFPopupLayout)FFPopupLayoutValue {
    FFPopupLayout layout;
    [self getValue:&layout];
    return layout;
}

@end

@implementation UIView (FFPopup)
- (void)containsPopupBlock:(void (^)(FFPopup *popup))block {
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[FFPopup class]]) {
            block((FFPopup *)subview);
        } else {
            [subview containsPopupBlock:block];
        }
    }
}

- (void)dismissShowingPopup:(BOOL)animated {
    UIView *view = self;
    while (view) {
        if ([view isKindOfClass:[FFPopup class]]) {
            [(FFPopup *)view dismissAnimated:animated];
            break;
        }
        view = view.superview;
    }
}

@end

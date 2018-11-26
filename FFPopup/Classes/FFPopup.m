//
//  FFPopup.m
//  FFPopup
//
//  Created by JonyFang on 2018/11/26.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFPopup.h"

static NSInteger const K_ANIMATION_OPTION_CURVE = (7 << 16);

FFPopupLayout FFPopupLayoutMake(FFPopupHorizontalLayout horizontal, FFPopupVerticalLayout vertical) {
    FFPopupLayout layout;
    layout.horizontal = horizontal;
    layout.vertical = vertical;
    return layout;
}

const FFPopupLayout FFPopupLayout_Center = { FFPopupHorizontalLayout_Center, FFPopupVerticalLayout_Center };

@interface NSValue (FFPopupLayout)
+ (NSValue *)valueWithFFPopupLayout:(FFPopupLayout)layout;
- (FFPopupLayout)FFPopupLayoutValue;
@end

@interface FFPopup () {
    UIView *_backgroundView;
    UIView *_containerView;
    
    BOOL _isBeingShown;
    BOOL _isShowing;
    BOOL _isBeingDismissed;
}

- (void)updateForInterfaceOrientation;
- (void)didChangeStatusbarOrientation:(NSNotification *)notification;

- (void)dismiss;

@end

@implementation FFPopup

@synthesize backgroundView = _backgroundView;
@synthesize containerView = _containerView;
@synthesize isBeingShown = _isBeingShown;
@synthesize isShowing = _isShowing;
@synthesize isBeingDismissed = _isBeingDismissed;

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
        
        self.showType = FFPopupShowType_ShrinkIn;
        self.dismissType = FFPopupDismissType_ShrinkOut;
        self.maskType = FFPopupMaskType_Dimmed;
        self.dimmedMaskAlpha = 0.5;
        
        _isBeingShown = NO;
        _isShowing = NO;
        _isBeingDismissed = NO;
        
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = UIColor.clearColor;
        _backgroundView.userInteractionEnabled = NO;
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundView.frame = self.bounds;
        
        _containerView = [UIView new];
        _containerView.autoresizesSubviews = NO;
        _containerView.userInteractionEnabled = YES;
        _containerView.backgroundColor = UIColor.clearColor;
        
        [self addSubview:_backgroundView];
        [self addSubview:_containerView];
        
        /// Register for notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeStatusbarOrientation:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    return self;
}

@end

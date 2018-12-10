//
//  FFHomeViewController.m
//  FFPopup_Example
//
//  Created by JonyFang on 2018/11/29.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFHomeViewController.h"
#import "BLCustomContentView.h"
#import "FFPopup.h"

#define K_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define K_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface FFHomeViewController () <BLCustomContentViewDelegate>
@property (nonatomic, strong) UIButton *popupButton;
@property (nonatomic, strong) BLCustomContentView *contentView;
@end

@implementation FFHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

#pragma mark - Private Methods
- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.popupButton];
    /// Make Constraints
    [_popupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-22);
        make.right.equalTo(self.view.mas_right).offset(-44);
        make.left.equalTo(self.view.mas_left).offset(44);
        make.height.mas_equalTo(44);
    }];
}

- (void)popupButtonClicked:(UIButton *)button {
    FFPopup *popup = [FFPopup popupWithContentView:self.contentView showType:FFPopupShowType_BounceInFromTop dismissType:FFPopupDismissType_BounceOutToBottom maskType:FFPopupMaskType_Dimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    [popup show];
}

#pragma mark - BLCustomContentViewDelegate
- (void)didClickedCloseButton:(UIButton *)button {
    [FFPopup dismissSuperPopupIn:button animated:YES];
}

#pragma mark - Properties
- (UIButton *)popupButton {
    if (!_popupButton) {
        _popupButton = [UIButton new];
        _popupButton.backgroundColor = UIColor.blueColor;
        _popupButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [_popupButton setTitle:@"Show Popup" forState:UIControlStateNormal];
        [_popupButton addTarget:self action:@selector(popupButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _popupButton.layer.cornerRadius = 22;
        _popupButton.layer.masksToBounds = YES;
    }
    return _popupButton;
}

- (BLCustomContentView *)contentView {
    if (!_contentView) {
        CGFloat scale = 375.0 / K_SCREEN_WIDTH;
        CGFloat width = 320.0 * scale;
        CGFloat height = 360.0 * scale;
        _contentView = [[BLCustomContentView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [_contentView updateTitle:@"👋\nHurray!" desc:@"Your request has been sent successfully. We will email you shortly. Meantime, check our marketing tips on Twitter and Facebook." buttonTitle:@"Got it"];
        _contentView.delegate = self;
    }
    return _contentView;
}

@end

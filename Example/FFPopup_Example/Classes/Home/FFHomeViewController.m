//
//  FFHomeViewController.m
//  FFPopup_Example
//
//  Created by JonyFang on 2018/11/29.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFHomeViewController.h"
#import "FFPopup.h"

#define K_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define K_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface FFHomeViewController ()
@property (nonatomic, strong) UIButton *popupButton;
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
    CGFloat width = K_SCREEN_WIDTH - 40.0;
    CGFloat height = width * 3.0 / 4.0;
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor blueColor];
    contentView.frame = CGRectMake(0.0, 0.0, width, height);
    contentView.layer.cornerRadius = 6.0;
    contentView.layer.masksToBounds = YES;
    FFPopup *popup = [FFPopup popupWithContentView:contentView showType:FFPopupShowType_BounceInFromTop dismissType:FFPopupDismissType_BounceOutToBottom maskType:FFPopupMaskType_Dimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    [popup show];
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

@end

//
//  BLCustomContentView.m
//  FFPopup_Objc
//
//  Created by JonyFang on 2018/11/29.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "BLCustomContentView.h"

@interface BLCustomContentView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation BLCustomContentView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateTitle:(NSString *)title desc:(NSString *)desc buttonTitle:(NSString *)buttonTitle {
    _titleLabel.text = title;
    _descLabel.text = desc;
    [_closeButton setTitle:buttonTitle forState:UIControlStateNormal];
}

#pragma mark - Private Methods
- (void)setupViews {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.closeButton];
    /// Make Constraints
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(18.0);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(26.0);
        make.left.equalTo(self.contentView.mas_left).offset(20.0);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0);
    }];
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-18.0);
        make.left.equalTo(self.contentView.mas_left).offset(20.0);
        make.right.equalTo(self.contentView.mas_right).offset(-20.0);
        make.height.mas_equalTo(44.0);
    }];
}

- (void)closeButtonClicked:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickedCloseButton:)]) {
        [self.delegate didClickedCloseButton:button];
    }
}

#pragma mark - Properties
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1.0];
        _contentView.layer.cornerRadius = 6.0;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor colorWithRed:84.0/255.0 green:92.0/255.0 blue:119.0/255.0 alpha:1.0];
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.font = [UIFont systemFontOfSize:16.0];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.numberOfLines = 0;
        _descLabel.textColor = [UIColor colorWithRed:84.0/255.0 green:92.0/255.0 blue:119.0/255.0 alpha:1.0];
    }
    return _descLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton new];
        _closeButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:111.0/255.0 blue:255.0/255.0 alpha:1.0];
        _closeButton.titleLabel.textColor = UIColor.whiteColor;
        _closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [_closeButton setTitle:@"Dismiss Popup" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.layer.cornerRadius = 22;
        _closeButton.layer.masksToBounds = YES;
    }
    return _closeButton;
}

@end

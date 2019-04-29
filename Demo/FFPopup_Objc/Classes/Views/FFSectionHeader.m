//
//  FFSectionHeader.m
//  FFPopup_Objc
//
//  Created by JonyFang on 2018/12/11.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFSectionHeader.h"

@interface FFSectionHeader ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation FFSectionHeader

#pragma mark - Public Methods
- (void)updateTitle:(NSString *)title {
    _titleLabel.text = title;
}

+ (CGFloat)height {
    return 24.0;
}

#pragma mark - Private Methods
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor FFLightGray];
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor FFGray];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _titleLabel;
}

@end

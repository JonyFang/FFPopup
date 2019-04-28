//
//  FFSelectionTableViewCell.m
//  FFPopup_Objc
//
//  Created by JonyFang on 2018/12/10.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFSelectionTableViewCell.h"

@interface FFSelectionTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *stateImageView;
@property (nonatomic, strong) UIView *separator;
@end

@implementation FFSelectionTableViewCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateTitle:(NSString *)title selected:(BOOL)selected {
    NSString *imageName = selected ? @"icon_check_highlight" : @"icon_check_default";
    _stateImageView.image = [UIImage imageNamed:imageName];
    _titleLabel.text = title;
}

+ (CGFloat)height {
    return 50.0;
}

#pragma mark - Private Methods
- (void)setupViews {
    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.stateImageView];
    [self.contentView addSubview:self.separator];
    ///Make Constraints
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    [_stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(16);
    }];
    [_separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - Properties
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = UIColor.FFBlack;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)stateImageView {
    if (!_stateImageView) {
        _stateImageView = [UIImageView new];
        _stateImageView.image = [UIImage imageNamed:@"icon_check_default"];
    }
    return _stateImageView;
}

- (UIView *)separator {
    if (!_separator) {
        _separator = [UIView new];
        _separator.backgroundColor = [UIColor FFLightGray];
    }
    return _separator;
}

@end

NSString *kFFSelectionTableViewCell = @"FFSelectionTableViewCell";

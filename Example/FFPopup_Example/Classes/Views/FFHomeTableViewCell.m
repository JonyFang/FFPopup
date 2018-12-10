//
//  FFHomeTableViewCell.m
//  FFPopup_Example
//
//  Created by JonyFang on 2018/12/10.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFHomeTableViewCell.h"

@interface FFHomeTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation FFHomeTableViewCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Public Methods
- (void)updateTitle:(NSString *)title subtitle:(NSString *)subtitle {
    _titleLabel.text = title;
    _subtitleLabel.text = subtitle;
}

#pragma mark - Private Methods
- (void)setupViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subtitleLabel];
    [self.contentView addSubview:self.arrowImageView];
    //Make Constraints
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16.0);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16.0);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(16.0);
    }];
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left).offset(-6);
        make.centerY.equalTo(self.arrowImageView.mas_centerY);
    }];
}

#pragma mark - Properties
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel new];
        _subtitleLabel.font = [UIFont systemFontOfSize:14.0];
        _subtitleLabel.textColor = UIColor.grayColor;
        _subtitleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _subtitleLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.image = [UIImage imageNamed:@""];
        _arrowImageView.backgroundColor = UIColor.grayColor;
    }
    return _arrowImageView;
}

@end

NSString *kFFHomeTableViewCell = @"FFHomeTableViewCell";

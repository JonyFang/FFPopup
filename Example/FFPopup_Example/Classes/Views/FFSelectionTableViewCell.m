//
//  FFSelectionTableViewCell.m
//  FFPopup_Example
//
//  Created by JonyFang on 2018/12/10.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFSelectionTableViewCell.h"

@interface FFSelectionTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *stateImageView;
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
- (void)cellDidSelected:(BOOL)selected {
    NSString *imageName = selected ? @"" : @"";
    _stateImageView.image = [UIImage imageNamed:imageName];
}

+ (CGFloat)height {
    return 50.0;
}

#pragma mark - Private Methods
- (void)setupViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.stateImageView];
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

- (UIImageView *)stateImageView {
    if (!_stateImageView) {
        _stateImageView = [UIImageView new];
        _stateImageView.image = [UIImage imageNamed:@""];
        _stateImageView.backgroundColor = UIColor.grayColor;
    }
    return _stateImageView;
}

@end

NSString *kFFSelectionTableViewCell = @"FFSelectionTableViewCell";

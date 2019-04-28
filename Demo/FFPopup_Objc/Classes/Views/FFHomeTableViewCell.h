//
//  FFHomeTableViewCell.h
//  FFPopup_Objc
//
//  Created by JonyFang on 2018/12/10.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *kFFHomeTableViewCell;

@interface FFHomeTableViewCell : FFTableViewCell
- (void)updateTitle:(NSString *)title subtitle:(NSString *)subtitle;
+ (CGFloat)height;
@end

NS_ASSUME_NONNULL_END

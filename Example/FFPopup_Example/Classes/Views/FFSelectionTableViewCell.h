//
//  FFSelectionTableViewCell.h
//  FFPopup_Example
//
//  Created by JonyFang on 2018/12/10.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FFSelectionTableViewCell : FFTableViewCell
- (void)updateTitle:(NSString *)title selected:(BOOL)selected;
+ (CGFloat)height;
@end

NS_ASSUME_NONNULL_END

extern NSString *kFFSelectionTableViewCell;

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
- (void)cellDidSelected:(BOOL)selected;
@end

NS_ASSUME_NONNULL_END

extern NSString *kFFSelectionTableViewCell;

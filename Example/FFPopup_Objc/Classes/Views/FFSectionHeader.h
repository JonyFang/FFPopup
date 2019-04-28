//
//  FFSectionHeader.h
//  FFPopup_Example
//
//  Created by JonyFang on 2018/12/11.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFSectionHeader : UIView
- (void)updateTitle:(NSString *)title;
+ (CGFloat)height;
@end

NS_ASSUME_NONNULL_END

//
//  BLCustomContentView.h
//  FFPopup_Example
//
//  Created by JonyFang on 2018/11/29.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BLCustomContentViewDelegate <NSObject>
- (void)didClickedCloseButton;
@end

@interface BLCustomContentView : UIView
@property (nonatomic, weak) id<BLCustomContentViewDelegate> delegate;
- (void)updateTitle:(NSString *)title desc:(NSString *)desc buttonTitle:(NSString *)buttonTitle;
@end

NS_ASSUME_NONNULL_END

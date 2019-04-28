//
//  FFPopupModel.h
//  FFPopup_Objc
//
//  Created by JonyFang on 2018/12/11.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFItemModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL selected;
@end

@interface FFStateItemModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<FFItemModel*> *types;
@end

@interface FFActionItemModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL enable;
@end

@interface FFPopupModel : NSObject
@property (nonatomic, strong) NSArray<FFStateItemModel*> *layout;
@property (nonatomic, strong) NSArray<FFStateItemModel*> *animation;
@property (nonatomic, strong) FFStateItemModel *mask;
@property (nonatomic, strong) FFActionItemModel *background;
@property (nonatomic, strong) FFActionItemModel *content;
@property (nonatomic, strong) FFActionItemModel *duration;
@end

NS_ASSUME_NONNULL_END

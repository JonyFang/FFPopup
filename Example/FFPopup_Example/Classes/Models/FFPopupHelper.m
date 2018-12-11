//
//  FFPopupHelper.m
//  FFPopup_Example
//
//  Created by JonyFang on 2018/12/11.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

#import "FFPopupHelper.h"

@implementation FFPopupHelper
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
@end

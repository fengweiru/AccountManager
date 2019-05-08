//
//  CommonTool.h
//  AccountManager
//
//  Created by fengweiru on 2019/4/12.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonTool : NSObject

//根据时间戳获取显示时间字符串
+ (NSString *)getChecktimeWithTimestamp:(NSUInteger)timestamp;

//文字写入黏贴版
+ (void)writeToPasteBoard:(NSString *)string;

//提示框
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)time;

//根据颜色块生成图像
+ (UIImage *)createImageWithColor:(UIColor *)color withFrame:(CGRect)frame;

//密码隐藏显示形式
+ (NSString *)hiddenPassword:(NSString *)password;

@end

NS_ASSUME_NONNULL_END

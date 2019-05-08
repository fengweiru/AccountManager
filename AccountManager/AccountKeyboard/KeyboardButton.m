//
//  KeyboardButton.m
//  AccountKeyboard
//
//  Created by fengweiru on 2019/5/7.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "KeyboardButton.h"

@implementation KeyboardButton

+ (KeyboardButton *)createKeyboardButton
{
    KeyboardButton *keyboardButton = [KeyboardButton buttonWithType:UIButtonTypeCustom];
    [keyboardButton setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:0xd2/255.0 green:0xd2/255.0 blue:0xd2/255.0 alpha:1.0]] forState:UIControlStateNormal];//#aaaaaa
    keyboardButton.layer.masksToBounds = true;
    [keyboardButton setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    keyboardButton.layer.shadowColor = [[UIColor colorWithRed:0x96/255.0 green:0x96/255.0 blue:0x96/255.0 alpha:1.0] CGColor];
    keyboardButton.layer.shadowOffset = CGSizeMake(0, 4);
    keyboardButton.layer.shadowOpacity = 1;
    keyboardButton.layer.cornerRadius = 8;
    
    return keyboardButton;
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGSize size = CGSizeMake(200, 200);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

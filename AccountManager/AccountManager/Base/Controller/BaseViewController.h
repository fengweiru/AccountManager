//
//  BaseViewController.h
//  AccountManager
//
//  Created by fengweiru on 2018/7/13.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)setNavBar;
- (void)setNavLeftBackItem;
- (void)setNavLeftItemWithTitle:(NSString *)title;
- (void)setNavLeftItemWithImage:(UIImage *)image;
- (void)setNavRightItemWithTitle:(NSString *)title;
- (void)setNavRightItemWithImage:(UIImage *)image;

- (void)clickLeftItem:(UIButton *)sender;

@end

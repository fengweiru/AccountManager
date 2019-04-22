//
//  CommonConfigure.h
//  AccountManager
//
//  Created by fengweiru on 2018/7/13.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#ifndef CommonConfigure_h
#define CommonConfigure_h

#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

// 自定义颜色
#define FColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
// 自定义颜色 透明度
#define FColorWithAlpha(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#define FFontRegular(size) [UIFont systemFontOfSize:(size) weight:UIFontWeightRegular]
#define FFontMedium(size) [UIFont systemFontOfSize:(size) weight:UIFontWeightMedium]
#define FFontSemibold(size) [UIFont systemFontOfSize:(size) weight:UIFontWeightSemibold]

#define Color_Background  FColor(0xf7, 0xf7, 0xf7)

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define Height_For_AppHeader  ([[UIApplication sharedApplication] statusBarFrame].size.height+44)
#define Height_For_StatusBar  [[UIApplication sharedApplication] statusBarFrame].size.height
#define Height_For_IphoneBottom   ((kScreenH==812)?34:0)

#endif /* CommonConfigure_h */

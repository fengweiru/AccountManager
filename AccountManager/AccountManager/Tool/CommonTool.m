//
//  CommonTool.m
//  AccountManager
//
//  Created by fengweiru on 2019/4/12.
//  Copyright © 2019 fengweiru. All rights reserved.
//

#import "CommonTool.h"

@implementation CommonTool

+ (NSString *)getChecktimeWithTimestamp:(NSUInteger)timestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:date];
}

@end

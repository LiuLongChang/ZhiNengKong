//
//  Tool_DateInfo.m
//  AndonFunction
//
//  Created by 宣佚 on 14/11/30.
//  Copyright (c) 2014年 刘宣佚. All rights reserved.
//

#import "Utils_DateInfo.h"

@implementation Utils_DateInfo

/**
 *  获取从1970年开始到现在的秒数（时间戳）
 *
 *  @return 时间戳
 */
+(long)GetCurrentTimeSP {
    
    NSDate *datenow = [NSDate date];
    long timeSp = [datenow timeIntervalSince1970];
    return timeSp;
}

/**
 *  获取当前时区
 *
 *  @return 时区
 */
+(int)GetCurrentTimeZone {
    NSString *zone = [[NSTimeZone localTimeZone] description];
    NSString *time = [[zone componentsSeparatedByString:@"offset"] objectAtIndex:1];
    int inv = [time intValue];
    int result = inv / (60 * 60);
    if (result>0) {
        return result;
    }
    return result;
}

/**
 *  Date转为String
 *
 *  @param date        要转成字符串的日期
 *  @param FormatStyle 格式化字符串
 *
 *  @return 字符串
 */
+(NSString *)stringFromDate:(NSDate *)date Format:(NSString *)FormatStyle {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:FormatStyle];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

@end

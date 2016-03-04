//
//  Tool_AppInfo.m
//  AndonFunction
//
//  Created by 宣佚 on 14/11/30.
//  Copyright (c) 2014年 刘宣佚. All rights reserved.
//

#import "Utils_AppInfo.h"

@implementation Utils_AppInfo

/**
 *  获取App名称
 *
 *  @return App名称
 */
+(NSString *)GetAppName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *AppName = [infoDictionary objectForKey:@"CFBundleName"];
    return AppName;
}

/**
 *  获取App版本号
 *
 *  @return App版本号
 */
+(NSString *)GetAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *AppVer = [infoDictionary objectForKey:@"CFBundleVersion"];
    return AppVer;
}

/**
 *  获取App全部版本号
 *
 *  @return App全部版本号
 */
+(NSString *)GetAppShortVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *AppSVer = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return AppSVer;
}

/**
 *  获取App Bundle Identifier
 *
 *  @return Bundle Identifier
 */
+(NSString *)GetAppBundleIdentifier {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *AppSVer = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return AppSVer;
}

/**
 *  获取AppID
 *
 *  @return 用户AppID
 */
+(NSString *)GetAppIdentifier {
    NSString *appid = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppIdentifier"];
    if ([appid isEqualToString:@""] || appid == nil) {
        CFUUIDRef uuidObj = CFUUIDCreate(nil);
        NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
        NSString *str = [uuidString stringByReplacingOccurrencesOfString:@"-"
                                                              withString:@""];
        NSString *lowerStr = [str lowercaseString];
        [[NSUserDefaults standardUserDefaults] setObject:lowerStr forKey:@"AppIdentifier"];
        appid = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppIdentifier"];
    }
    return appid;
}

@end

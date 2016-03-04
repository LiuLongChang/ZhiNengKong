//
//  Tool_AppInfo.h
//  AndonFunction
//
//  Created by 宣佚 on 14/11/30.
//  Copyright (c) 2014年 刘宣佚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils_AppInfo : NSObject

/**
 *  获取App名称
 *
 *  @return App名称
 */
+(NSString *)GetAppName;

/**
 *  获取App版本号
 *
 *  @return App版本号
 */
+(NSString *)GetAppVersion;

/**
 *  获取App全部版本号
 *
 *  @return App全部版本号
 */
+(NSString *)GetAppShortVersion;

/**
 *  获取App Bundle Identifier
 *
 *  @return Bundle Identifier
 */
+(NSString *)GetAppBundleIdentifier;

/**
 *  获取AppID
 *
 *  @return 用户AppID
 */
+(NSString *)GetAppIdentifier;

@end

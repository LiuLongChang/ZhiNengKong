//
//  Tool_UserDefaultInfo.h
//  AndonFunction
//
//  Created by 宣佚 on 14/11/30.
//  Copyright (c) 2014年 刘宣佚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils_UserDefaultInfo : NSObject

/**
 *  获取iOS设备唯一标示
 *
 *  @return iOS设备唯一标示
 */
+(NSString *)GetMobileIdentifer;

/**
 *  获取用户唯一标示
 *
 *  @return 用户唯一标示
 */
+(NSString *)GetUserIdentifer:(NSString *)UserIdentity;

/**
 *  设置用户唯一标示
 */
+(void)SetUserIdentifer:(NSString *)UserIdentity;

/**
 *  获取用户AccessKey
 *
 *  @return 用户AccessKey
 */
+(NSString *)GetUserAccessKey:(NSString *)AccessKey;

/**
 *  设置用户AccessKey
 */
+(void)SetUserAccessKey:(NSString *)AccessKey;

/**
 *  获取用户RefreshToken
 *
 *  @return 用户RefreshToken
 */
+(NSString *)GetUserRefreshToken:(NSString *)RefreshToken;

/**
 *  设置用户RefreshToken
 */
+(void)SetUserRefreshToken:(NSString *)RefreshToken;

/**
 *  获取用户DeviceToken
 *
 *  @return 用户DeviceToken
 */
+ (NSString *)GetUserDeviceToken:(NSString *)DeviceToken;

/**
 *  设置用户DeviceToken
 */
+(void)SetUserDeviceToken:(NSString *)DeviceToken;

/**
 *  设置用户头像
 */
+(void)SetUserLogo:(UIImage *)image;

/**
 *  设置用户头像
 */
+(UIImage *)GetUserLogo:(UIImage *)image;

/**
 *  设置设备图标
 */
+(void)SetAvatarWithUrl:(NSString *)url image:(UIImage *)image;

/**
 *  设置设备图标
 */
+(UIImage *)GetAvatarWithUrl:(NSString *)url image:(UIImage *)image;

/**
 *  获取用户头像URL
 *
 *  @return 用户头像URL
 */
+(NSString *)GetUserLogoUrl:(NSString *)logoUrl;

/**
 *  设置用户头像URL
 */
+(void)SetUserLogoUrl:(NSString *)logoUrl;

/**
 *  获取用户手机号
 *
 *  @return 用户手机号
 */
+(NSString *)GetUserPhone:(NSString *)phone;

/**
 *  设置用户手机号
 */
+(void)SetUserPhone:(NSString *)phone;

/**
 *  获取用户昵称
 *
 *  @return 用户昵称
 */
+(NSString *)GetUserName:(NSString *)userName;

/**
 *  设置用户昵称
 */
+(void)SetUserName:(NSString *)userName;

@end

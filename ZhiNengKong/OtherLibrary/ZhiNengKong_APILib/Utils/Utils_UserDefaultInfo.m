//
//  Tool_UserDefaultInfo.m
//  AndonFunction
//
//  Created by 宣佚 on 14/11/30.
//  Copyright (c) 2014年 刘宣佚. All rights reserved.
//

#import "Utils_UserDefaultInfo.h"

@implementation Utils_UserDefaultInfo

/**
 *  获取iOS设备唯一标示
 *
 *  @return iOS设备唯一标示
 */
+(NSString *)GetMobileIdentifer {
    NSString *modelID = [[NSUserDefaults standardUserDefaults] objectForKey:@"MobileIdentifer"];
    if ([modelID isEqualToString:@""] || modelID == nil) {
        CFUUIDRef uuidObj = CFUUIDCreate(nil);
        NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
        NSString *str = [uuidString stringByReplacingOccurrencesOfString:@"-"
                                                              withString:@""];
        NSString *lowerStr = [str lowercaseString];
        [[NSUserDefaults standardUserDefaults] setObject:lowerStr forKey:@"MobileIdentifer"];
        modelID = [[NSUserDefaults standardUserDefaults] objectForKey:@"MobileIdentifer"];
    }
    return modelID;
}

/**
 *  获取用户唯一标示
 *
 *  @return 用户唯一标示
 */
+(NSString *)GetUserIdentifer:(NSString *)UserIdentity {
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserIdentifer"];
    if ([userID isEqualToString:@""] || userID == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:UserIdentity forKey:@"UserIdentifer"];
        userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserIdentifer"];
    }
    return userID;
}

/**
 *  设置用户唯一标示
 */
+(void)SetUserIdentifer:(NSString *)UserIdentity {
    [[NSUserDefaults standardUserDefaults] setObject:UserIdentity forKey:@"UserIdentifer"];
}

/**
 *  获取用户AccessKey
 *
 *  @return 用户AccessKey
 */
+(NSString *)GetUserAccessKey:(NSString *)AccessKey {
    NSString *accessKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserAccessKey"];
    if ([accessKey isEqualToString:@""] || accessKey == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:AccessKey forKey:@"UserAccessKey"];
        accessKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserAccessKey"];
    }
    return accessKey;
}

/**
 *  设置用户AccessKey
 */
+(void)SetUserAccessKey:(NSString *)AccessKey {
    [[NSUserDefaults standardUserDefaults] setObject:AccessKey forKey:@"UserAccessKey"];
}

/**
 *  获取用户RefreshToken
 *
 *  @return 用户RefreshToken
 */
+(NSString *)GetUserRefreshToken:(NSString *)RefreshToken{
    NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserRefreshToken"];
    if ([refreshToken isEqualToString:@""] || refreshToken == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:RefreshToken forKey:@"UserRefreshToken"];
        refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserRefreshToken"];
    }
    return refreshToken;
}

/**
 *  设置用户RefreshToken
 */
+(void)SetUserRefreshToken:(NSString *)RefreshToken{
    [[NSUserDefaults standardUserDefaults] setObject:RefreshToken forKey:@"UserRefreshToken"];
}

/**
 *  获取用户DeviceToken
 *
 *  @return 用户DeviceToken
 */
+(NSString *)GetUserDeviceToken:(NSString *)DeviceToken {
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDeviceToken"];
    if ([deviceToken isEqualToString:@""] || deviceToken == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:DeviceToken forKey:@"UserDeviceToken"];
        deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDeviceToken"];
    }
    return deviceToken;
}

/**
 *  设置用户DeviceToken
 */
+(void)SetUserDeviceToken:(NSString *)DeviceToken {
    [[NSUserDefaults standardUserDefaults] setObject:DeviceToken forKey:@"UserDeviceToken"];
}

/**
 *  设置用户头像
 */
+(void)SetUserLogo:(UIImage *)image{
    NSString *uid = [Utils_UserDefaultInfo GetUserIdentifer:nil];
    NSString *key = [NSString stringWithFormat:@"UserLogo:%@",uid];
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:key];
}

/**
 *  获取用户头像
 */
+(UIImage *)GetUserLogo:(UIImage *)image{
    NSString *uid = [Utils_UserDefaultInfo GetUserIdentifer:nil];
    NSString *key = [NSString stringWithFormat:@"UserLogo:%@",uid];
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (imageData == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:key];
        imageData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return [UIImage imageWithData:imageData];
}

/**
 *  设置设备图标
 */
+(void)SetAvatarWithUrl:(NSString *)url image:(UIImage *)image{
    NSString *key = [NSString stringWithFormat:@"Avatar:%@",url];
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:key];
}

/**
 *  设置设备图标
 */
+(UIImage *)GetAvatarWithUrl:(NSString *)url image:(UIImage *)image{
    NSString *key = [NSString stringWithFormat:@"Avatar:%@",url];
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (imageData == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:key];
        imageData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return [UIImage imageWithData:imageData];

}

/**
 *  获取用户头像URL
 *
 *  @return 用户头像URL
 */
+(NSString *)GetUserLogoUrl:(NSString *)logoUrl{
    NSString *uid = [Utils_UserDefaultInfo GetUserIdentifer:nil];
    NSString *key = [NSString stringWithFormat:@"UserLogoUrl:%@",uid];
    NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ([url isEqualToString:@""] || url == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:logoUrl forKey:key];
        url = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return url;
}

/**
 *  设置用户头像URL
 */
+(void)SetUserLogoUrl:(NSString *)logoUrl{
    NSString *uid = [Utils_UserDefaultInfo GetUserIdentifer:nil];
    NSString *key = [NSString stringWithFormat:@"UserLogoUrl:%@",uid];
    [[NSUserDefaults standardUserDefaults] setObject:logoUrl forKey:key];
}

/**
 *  获取用户手机号
 *
 *  @return 用户手机号
 */
+(NSString *)GetUserPhone:(NSString *)phone{
    NSString *uid = [Utils_UserDefaultInfo GetUserIdentifer:nil];
    NSString *key = [NSString stringWithFormat:@"UserPhone:%@",uid];
    NSString *userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ([userPhone isEqualToString:@""] || userPhone == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:phone forKey:key];
        userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return userPhone;
}

/**
 *  设置用户手机号
 */
+(void)SetUserPhone:(NSString *)phone{
    NSString *uid = [Utils_UserDefaultInfo GetUserIdentifer:nil];
    NSString *key = [NSString stringWithFormat:@"UserPhone:%@",uid];
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:key];
}

/**
 *  获取用户昵称
 *
 *  @return 用户昵称
 */
+(NSString *)GetUserName:(NSString *)userName{
    NSString *uid = [Utils_UserDefaultInfo GetUserIdentifer:nil];
    NSString *key = [NSString stringWithFormat:@"UserName:%@",uid];
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ([name isEqualToString:@""] || name == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:key];
        name = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return name;
}

/**
 *  设置用户昵称
 */
+(void)SetUserName:(NSString *)userName{
    NSString *uid = [Utils_UserDefaultInfo GetUserIdentifer:nil];
    NSString *key = [NSString stringWithFormat:@"UserName:%@",uid];
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:key];
}

@end

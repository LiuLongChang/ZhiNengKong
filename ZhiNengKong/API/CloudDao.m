//
//  CloudDao.m
//  ZhiNengKong_APILib
//
//  Created by 宣佚 on 14/12/29.
//  Copyright (c) 2014年 刘宣佚. All rights reserved.
//

#import "CloudDao.h"
#import "ZhiNengKong_APILib.h"
#import "NSString+WebErrorCode.h"

@implementation CloudDao

/**
 *  申请手机注册验证码，对应API 1
 *
 *  @param topInfo   申请手机注册验证码上传信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)GetRegisterVerityCode:(NSDictionary *)topInfo
                     success:(void (^)(id returnValue))success
                     failure:(void (^)(NSString *errorMessage))failure
                   exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.timeInterval = 20;
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:KGetRegisterVerityCodeURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kGetRegisterVerityCodeSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}

/**
 *  验证手机注册验证码，对应API 2
 *
 *  @param topInfo   验证手机注册验证码上传信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)VerityRegisterCode:(NSDictionary *)topInfo
                  success:(void (^)(id returnValue))success
                  failure:(void (^)(NSString *errorMessage))failure
                exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kVerityRegisterCodeURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kVerityRegisterCodeSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}

/**
 *  手机账号注册，对应API 3
 *
 *  @param topInfo   手机账号注册上传信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)RegisterUser:(NSDictionary *)topInfo
            success:(void (^)(id returnValue))success
            failure:(void (^)(NSString *errorMessage))failure
          exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kRegisterUserURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kRegisterUserSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}

/**
 *  4.手机账号登录
 *
 *  @param topInfo   手机账号登录信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)PhoneLogin:(NSDictionary *)topInfo
          success:(void (^)(id returnValue))success
          failure:(void (^)(NSString *errorMessage))failure
        exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kPhoneLoginURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kPhoneLoginSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  5.申请重置密码验证码
 *
 *  @param topInfo   申请重置密码验证码信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)VerifyReset:(NSDictionary *)topInfo
           success:(void (^)(id returnValue))success
           failure:(void (^)(NSString *errorMessage))failure
         exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kVerifyResetURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kVerifyResetSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  6.验证重置密码验证码
 *
 *  @param topInfo   验证重置密码验证码信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)VerifyResetCode:(NSDictionary *)topInfo
               success:(void (^)(id returnValue))success
               failure:(void (^)(NSString *errorMessage))failure
             exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kVerifyResetCodeURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kVerifyResetCodeSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  7.重置密码
 *
 *  @param topInfo   重置密码信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)ResetCode:(NSDictionary *)topInfo
         success:(void (^)(id returnValue))success
         failure:(void (^)(NSString *errorMessage))failure
       exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kResetCodeURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kResetCodeSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  8.访问令牌刷新
 *
 *  @param topInfo   访问令牌刷新信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)RefreshToken:(NSDictionary *)topInfo
            success:(void (^)(id returnValue))success
            failure:(void (^)(NSString *errorMessage))failure
          exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kRefreshTokenURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kRefreshTokenSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  9.申请手机动态登录码
 *
 *  @param topInfo   申请手机动态登录码信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)GetLoginCode:(NSDictionary *)topInfo
            success:(void (^)(id returnValue))success
            failure:(void (^)(NSString *errorMessage))failure
          exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kGetLoginCodeURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kGetLoginCodeSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  10.手机动态码登录
 *
 *  @param topInfo   手机动态码登录信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)CodeLogin:(NSDictionary *)topInfo
         success:(void (^)(id returnValue))success
         failure:(void (^)(NSString *errorMessage))failure
       exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kCodeLoginURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kCodeLoginSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  11.获取用户个人信息资料
 *
 *  @param topInfo   获取用户个人信息资料信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)GetUserInfo:(NSDictionary *)topInfo
           success:(void (^)(id returnValue))success
           failure:(void (^)(NSString *errorMessage))failure
         exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kGetUserInfoURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kGetUserInfoSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  12.修改用户个人信息资料
 *
 *  @param topInfo   修改用户个人信息资料信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)SetUserInfo:(NSDictionary *)topInfo
           success:(void (^)(id returnValue))success
           failure:(void (^)(NSString *errorMessage))failure
         exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kSetUserInfoURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kSetUserInfoSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  13.修改密码
 *
 *  @param topInfo   修改密码信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)ChangePassword:(NSDictionary *)topInfo
              success:(void (^)(id returnValue))success
              failure:(void (^)(NSString *errorMessage))failure
            exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kChangePasswordURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kChangePasswordSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  14.个人资料中用户上传头像
 *
 *  @param topInfo   个人资料中用户上传头像信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)UploadAvatars:(NSDictionary *)topInfo
             success:(void (^)(id returnValue))success
             failure:(void (^)(NSString *errorMessage))failure
           exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kUploadAvatarsURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kUploadAvatarsSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  15.添加设备
 *
 *  @param topInfo   添加设备信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)AddEq:(NSDictionary *)topInfo
     success:(void (^)(id returnValue))success
     failure:(void (^)(NSString *errorMessage))failure
   exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kAddEqURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kAddEqSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  16.删除设备
 *
 *  @param topInfo   删除设备信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)DelEq:(NSDictionary *)topInfo
     success:(void (^)(id returnValue))success
     failure:(void (^)(NSString *errorMessage))failure
   exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kDelEqURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kDelEqSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  17.修改设备
 *
 *  @param topInfo   修改设备信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)UpdateEq:(NSDictionary *)topInfo
        success:(void (^)(id returnValue))success
        failure:(void (^)(NSString *errorMessage))failure
      exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kUpdateEqURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kUpdateEqSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  18.设备资料中上传设备头像
 *
 *  @param topInfo   设备资料中上传设备头像信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)UploadEqAvatar:(NSDictionary *)topInfo
              success:(void (^)(id returnValue))success
              failure:(void (^)(NSString *errorMessage))failure
            exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kUploadEqAvatarURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kUploadEqAvatarSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  19.用户反馈信息上传
 *
 *  @param topInfo   用户反馈信息上传信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)UserFeedback:(NSDictionary *)topInfo
            success:(void (^)(id returnValue))success
            failure:(void (^)(NSString *errorMessage))failure
          exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kUserFeedbackURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kUserFeedbackSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  20.用户反馈图片上传
 *
 *  @param topInfo   用户反馈图片上传信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)UserFeedbackImg:(NSDictionary *)topInfo
               success:(void (^)(id returnValue))success
               failure:(void (^)(NSString *errorMessage))failure
             exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kUserFeedbackImgURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kUserFeedbackImgSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  21.分享我的设备
 *
 *  @param topInfo   分享我的设备信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)ShareEq:(NSDictionary *)topInfo
       success:(void (^)(id returnValue))success
       failure:(void (^)(NSString *errorMessage))failure
     exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kShareEqURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kShareEqSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  22.查看邀请我的信息
 *
 *  @param topInfo   查看邀请我的信息信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)MyInvitation:(NSDictionary *)topInfo
            success:(void (^)(id returnValue))success
            failure:(void (^)(NSString *errorMessage))failure
          exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kMyInvitationURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kMyInvitationSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  23.同意/拒绝邀请信息
 *
 *  @param topInfo   同意/拒绝邀请信息信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)InvitationResponse:(NSDictionary *)topInfo
                  success:(void (^)(id returnValue))success
                  failure:(void (^)(NSString *errorMessage))failure
                exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kInvitationResponseURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kInvitationResponseSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  24.获取用户所有设备信息
 *
 *  @param topInfo   获取用户所有设备信息信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)MyEquips:(NSDictionary *)topInfo
        success:(void (^)(id returnValue))success
        failure:(void (^)(NSString *errorMessage))failure
      exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kMyEquipsURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kMyEquipsSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                         failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  25.获取指定设备的分享信息
 *
 *  @param topInfo   获取指定设备的分享信息信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)UserSharings:(NSDictionary *)topInfo
            success:(void (^)(id returnValue))success
            failure:(void (^)(NSString *errorMessage))failure
          exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kUserSharingsURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kUserSharingsSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  26.删除被分享者与设备的关联
 *
 *  @param topInfo   删除被分享者与设备的关联信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)DelSharings:(NSDictionary *)topInfo
           success:(void (^)(id returnValue))success
           failure:(void (^)(NSString *errorMessage))failure
         exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kDelSharingsURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kDelSharingsSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}

/**
 *  27.获取指定设备最新N条指令信息
 *
 *  @param topInfo   获取指定设备最新N条指令信息信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)GetTopCommands:(NSDictionary *)topInfo
              success:(void (^)(id returnValue))success
              failure:(void (^)(NSString *errorMessage))failure
            exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kGetTopCommandsURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kGetTopCommandsSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  28.获取指定设备给定时间之前的N条指令数据
 *
 *  @param topInfo   获取指定设备给定时间之前的N条指令数据信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)GetOldCommands:(NSDictionary *)topInfo
              success:(void (^)(id returnValue))success
              failure:(void (^)(NSString *errorMessage))failure
            exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kGetOldCommandsURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kGetOldCommandsSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  29.客户端向设备发送指令消息
 *
 *  @param topInfo   客户端向设备发送指令消息信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)SendCommand:(NSDictionary *)topInfo
           success:(void (^)(id returnValue))success
           failure:(void (^)(NSString *errorMessage))failure
         exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kSendCommandURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kSendCommandSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  30.同步客户端指令数据
 *
 *  @param topInfo   同步客户端指令数据信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)SynClientData:(NSDictionary *)topInfo
             success:(void (^)(id returnValue))success
             failure:(void (^)(NSString *errorMessage))failure
           exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kSynClientDataURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kSynClientDataSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  31.获取设备列表（临时接口）
 *
 *  @param topInfo   获取设备列表（临时接口）信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)GetEquipList:(NSDictionary *)topInfo
            success:(void (^)(id returnValue))success
            failure:(void (^)(NSString *errorMessage))failure
          exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kGetEquipListURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kGetEquipListSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  32.我的好友列表
 *
 *  @param topInfo   我的好友列表信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)GetFriendsList:(NSDictionary *)topInfo
              success:(void (^)(id returnValue))success
              failure:(void (^)(NSString *errorMessage))failure
            exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kGetFriendsListURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kGetFriendsListSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  33.搜索好友信息
 *
 *  @param topInfo   搜索好友信息信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)SeachFriendInfo:(NSDictionary *)topInfo
               success:(void (^)(id returnValue))success
               failure:(void (^)(NSString *errorMessage))failure
             exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kSeachFriendInfoURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kSeachFriendInfoSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  34.添加好友
 *
 *  @param topInfo   添加好友信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)AddFriendInfo:(NSDictionary *)topInfo
             success:(void (^)(id returnValue))success
             failure:(void (^)(NSString *errorMessage))failure
           exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kAddFriendInfoURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kAddFriendInfoSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  35.我的设备圈列表
 *
 *  @param topInfo   我的设备圈列表信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)MyCircles:(NSDictionary *)topInfo
         success:(void (^)(id returnValue))success
         failure:(void (^)(NSString *errorMessage))failure
       exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kMyCirclesURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kMyCirclesSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  36.添加设备圈
 *
 *  @param topInfo   添加设备圈信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)AddCircle:(NSDictionary *)topInfo
         success:(void (^)(id returnValue))success
         failure:(void (^)(NSString *errorMessage))failure
       exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kAddCircleURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kAddCircleSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  37.修改设备圈
 *
 *  @param topInfo   修改设备圈信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)UpdateCircle:(NSDictionary *)topInfo
            success:(void (^)(id returnValue))success
            failure:(void (^)(NSString *errorMessage))failure
          exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kUpdateCircleURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kUpdateCircleSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  38.获取设备圈详细信息
 *
 *  @param topInfo   获取设备圈详细信息信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)GetCircleDetail:(NSDictionary *)topInfo
               success:(void (^)(id returnValue))success
               failure:(void (^)(NSString *errorMessage))failure
             exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kGetCircleDetailURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kGetCircleDetailSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  39.设备圈中发送信息
 *
 *  @param topInfo   设备圈中发送信息信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)SendCircleMessages:(NSDictionary *)topInfo
                  success:(void (^)(id returnValue))success
                  failure:(void (^)(NSString *errorMessage))failure
                exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kSendCircleMessagesURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kSendCircleMessagesSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  40.获取指定设备圈给定时间之前的N条指令数据（老数据）
 *
 *  @param topInfo   获取指定设备圈给定时间之前的N条指令数据（老数据）信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)GetOldCircleMessages:(NSDictionary *)topInfo
                    success:(void (^)(id returnValue))success
                    failure:(void (^)(NSString *errorMessage))failure
                  exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kGetOldCircleMessagesURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kGetOldCircleMessagesSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}
/**
 *  41.获取指定设备圈给定时间之后的N条指令数据（新数据）
 *
 *  @param topInfo   获取指定设备圈给定时间之后的N条指令数据（新数据）信息
 *  @param success   成功返回 NSMutableDictionary
 *  @param failure   失败返回
 *  @param exception 异常返回
 */
+(void)GetTopCircleMessages:(NSDictionary *)topInfo
                    success:(void (^)(id returnValue))success
                    failure:(void (^)(NSString *errorMessage))failure
                  exception:(void (^)(NSString *errorMessage))exception
{
    ZhiNengKong_APILib *cloud = [[ZhiNengKong_APILib alloc] init];
    cloud.serviceURL = serviceURL;
    [cloud globalTimelinePostURL:kGetTopCircleMessagesURL
                    HeadInfoType:HEADINFO_TYPE_ONE
                              SC:KSC
                              SV:kGetTopCircleMessagesSV
                      parameters:topInfo
                         success:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"success:%@",returnInfo.ReturnValue);
                             success(returnInfo.ReturnValue);
                         }
                         failure:^(ZhiNengKong_APILib *returnInfo) {
                             NSLog(@"failure:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                             NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                             NSString *returnValue = [resultMessage ErrorCode];
                             failure(returnValue);
                         }
                    SerException:^(ZhiNengKong_APILib *returnInfo) {
                        NSLog(@"SerException:%@ - %@",returnInfo.ResultMessage,returnInfo.ReturnValue);
                        NSString *resultMessage = [NSString stringWithFormat:@"%@",returnInfo.ResultMessage];
                        NSString *returnValue = [resultMessage ErrorCode];
                        exception(returnValue);
                    }
                    NetException:^(NSInteger ErrorCode, NSError *ErrorMessage) {
                        NSLog(@"NetException:%ld - %@",(long)ErrorCode,[ErrorMessage description]);
                        if (ErrorCode == -1001) {
                            exception(@"网络请求超时");
                        } else {
                            exception(@"网络连接异常");
                        }
                    }];
}

@end

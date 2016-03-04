//
//  CloudDao.h
//  iCloudLib
//
//  Created by 宣佚 on 14/12/29.
//  Copyright (c) 2014年 刘宣佚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CloudDao : NSObject

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
                   exception:(void (^)(NSString *errorMessage))exception;

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
                exception:(void (^)(NSString *errorMessage))exception;

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
          exception:(void (^)(NSString *errorMessage))exception;

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
        exception:(void (^)(NSString *errorMessage))exception;
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
         exception:(void (^)(NSString *errorMessage))exception;
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

             exception:(void (^)(NSString *errorMessage))exception;
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
       exception:(void (^)(NSString *errorMessage))exception;
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
          exception:(void (^)(NSString *errorMessage))exception;
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
          exception:(void (^)(NSString *errorMessage))exception;
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
       exception:(void (^)(NSString *errorMessage))exception;
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
         exception:(void (^)(NSString *errorMessage))exception;
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
         exception:(void (^)(NSString *errorMessage))exception;
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
            exception:(void (^)(NSString *errorMessage))exception;
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
           exception:(void (^)(NSString *errorMessage))exception;
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
   exception:(void (^)(NSString *errorMessage))exception;
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
   exception:(void (^)(NSString *errorMessage))exception;
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
      exception:(void (^)(NSString *errorMessage))exception;
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
            exception:(void (^)(NSString *errorMessage))exception;
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
          exception:(void (^)(NSString *errorMessage))exception;
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
             exception:(void (^)(NSString *errorMessage))exception;
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
     exception:(void (^)(NSString *errorMessage))exception;
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
          exception:(void (^)(NSString *errorMessage))exception;
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
                exception:(void (^)(NSString *errorMessage))exception;

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
      exception:(void (^)(NSString *errorMessage))exception;

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
          exception:(void (^)(NSString *errorMessage))exception;
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
         exception:(void (^)(NSString *errorMessage))exception;

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
            exception:(void (^)(NSString *errorMessage))exception;
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
            exception:(void (^)(NSString *errorMessage))exception;
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
         exception:(void (^)(NSString *errorMessage))exception;
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
           exception:(void (^)(NSString *errorMessage))exception;
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
          exception:(void (^)(NSString *errorMessage))exception;
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
            exception:(void (^)(NSString *errorMessage))exception;
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
             exception:(void (^)(NSString *errorMessage))exception;
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
           exception:(void (^)(NSString *errorMessage))exception;
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
       exception:(void (^)(NSString *errorMessage))exception;
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
       exception:(void (^)(NSString *errorMessage))exception;
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
          exception:(void (^)(NSString *errorMessage))exception;
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
             exception:(void (^)(NSString *errorMessage))exception;
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
                exception:(void (^)(NSString *errorMessage))exception;
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
                  exception:(void (^)(NSString *errorMessage))exception;
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
                  exception:(void (^)(NSString *errorMessage))exception;

@end

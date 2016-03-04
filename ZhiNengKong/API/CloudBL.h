//
//  CloudBL.h
//  APIDemo
//
//  Created by 宣佚 on 15/6/1.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModels.h"

@interface CloudBL : NSObject

/**
 *  申请智能控注册验证码 ，对应API 1
 *
 *  @param Phone   申请手机
 *  @param success 成功返回 
 *  @param failure 失败返回
 */
+(void)GetRegisterVerityCode_Phone:(NSString *)Phone
                           success:(void (^)(void))success
                           failure:(void (^)(NSString *errorMessage))failure;
/**
 *  验证手机验证码 ，对应API 2
 *
 *  @param Phone   申请手机
 *  @param Code    申请手机验证码
 *  @param success 成功返回 BOOL
 *  @param failure 失败返回
 */
+(void)VerityRegisterCode_Phone:(NSString *)Phone
                           Code:(NSString *)Code
                        success:(void (^)(BOOL VerityisSuccess))success
                        failure:(void (^)(NSString *errorMessage))failure;

/**
 *  注册智能控账号 ，对应API 3
 *
 *  @param Phone     申请手机
 *  @param Code      申请手机验证码
 *  @param Password  申请手机密码
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)RegisterUser_Phone:(NSString *)Phone
                     Code:(NSString *)Code
                 Password:(NSString *)Password
                  success:(void (^)(NSString *iDentity, Token *token))success
                  failure:(void (^)(NSString *errorMessage))failure;



/**
 *  4.手机账号登录
 *
 *  @param phone     手机号
 *  @param password     密码
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)PhoneLogin_Phone:(NSString *)Phone
               Password:(NSString *)Password
                success:(void (^)(NSString *HGUID,Token *Token,NSString *UserName))success
                failure:(void (^)(NSString *errorMessage))failure;

/**
 *  5.申请重置密码验证码
 *
 *  @param phone     手机号
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)VerifyReset_Phone:(NSString *)Phone
                 success:(void (^)())success
                 failure:(void (^)(NSString *errorMessage))failure;

/**
 *  6.验证重置密码验证码
 *
 *  @param phone     手机号
 *  @param code     验证码
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)VerifyResetCode_Phone:(NSString *)Phone
                        Code:(NSString *)Code
                     success:(void (^)())success
                     failure:(void (^)(NSString *errorMessage))failure;

/**
 *  7.重置密码
 *
 *  @param phone     手机号
 *  @param code     验证码
 *  @param password     密码
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)ResetCode_Phone:(NSString *)Phone
                  Code:(NSString *)Code
              Password:(NSString *)Password
               success:(void (^)(NSString *HGUID,Token *Token))success
               failure:(void (^)(NSString *errorMessage))failure;

/**
 *  8.访问令牌刷新
 *
 *  @param uN     HGUID
 *  @param refreshToken     刷新令牌
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)RefreshToken_UN:(NSString *)UN
          RefreshToken:(NSString *)RefreshToken
               success:(void (^)(NSString *HGUID,Token *Token))success
               failure:(void (^)(NSString *errorMessage))failure;

/**
 *  9.申请手机动态登录码
 *
 *  @param phone     手机号
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)GetLoginCode_Phone:(NSString *)Phone
                  success:(void (^)())success
                  failure:(void (^)(NSString *errorMessage))failure;

/**
 *  10.手机动态码登录
 *
 *  @param phone     手机号
 *  @param code     动态码
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)CodeLogin_Phone:(NSString *)Phone
                  Code:(NSString *)Code
               success:(void (^)(NSString *HGUID,Token *Token,NSString *UserName))success
               failure:(void (^)(NSString *errorMessage))failure;

/**
 *  11.获取用户个人信息资料
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)GetUserInfo_UN:(NSString *)UN
          AccessToken:(NSString *)AccessToken
              success:(void (^)(NSString *HGUID,NSString *Phone,NSString *Logo,NSString *UserName))success
              failure:(void (^)(NSString *errorMessage))failure;

/**
 *  12.修改用户个人信息资料
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param changes     信息设置
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)SetUserInfo_UN:(NSString *)UN
          AccessToken:(NSString *)AccessToken
              Changes:(NSArray *)Changes
              success:(void (^)(int IsSuccess,NSArray *Errors))success
              failure:(void (^)(NSString *errorMessage))failure;

/**
 *  13.修改密码
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param oldPassword     原始密码
 *  @param newPassword     新密码
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)ChangePassword_UN:(NSString *)UN
             AccessToken:(NSString *)AccessToken
             OldPassword:(NSString *)OldPassword
             NewPassword:(NSString *)NewPassword
                 success:(void (^)(NSString *HGUID,Token *Token))success
                 failure:(void (^)(NSString *errorMessage))failure;

/**
 *  14.个人资料中用户上传头像
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param ext     文件后缀名
 *  @param imageData     图片文件字节流的Base64编码字符串
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)UploadAvatars_UN:(NSString *)UN
            AccessToken:(NSString *)AccessToken
                    Ext:(NSString *)Ext
              ImageData:(NSString *)ImageData
                success:(void (^)())success
                failure:(void (^)(NSString *errorMessage))failure;

/**
 *  15.添加设备
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param eqID     设备唯一编号
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)AddEq_UN:(NSString *)UN
    AccessToken:(NSString *)AccessToken
           EqID:(NSString *)EqID
        success:(void (^)(NSString *EqID,NSString *Name,NSString *Alias,LastMessage *LastMessage))success
        failure:(void (^)(NSString *errorMessage))failure;

/**
 *  16.删除设备
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param eqID     设备唯一编号
 *  @param password     本人账户密码的密文
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)DelEq_UN:(NSString *)UN
    AccessToken:(NSString *)AccessToken
           EqID:(NSString *)EqID
       Password:(NSString *)Password
        success:(void (^)())success
        failure:(void (^)(NSString *errorMessage))failure;

/**
 *  17.修改设备
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param eqID     设备唯一编号
 *  @param changes     设置信息
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)UpdateEq_UN:(NSString *)UN
       AccessToken:(NSString *)AccessToken
              EqID:(NSString *)EqID
           Changes:(NSArray *)Changes
           success:(void (^)())success
           failure:(void (^)(NSString *errorMessage))failure;

/**
 *  18.设备资料中上传设备头像
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param eqID     设备唯一编号
 *  @param ext     文件后缀名
 *  @param imageData     图片文件字节流的Base64编码字符串
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)UploadEqAvatar_UN:(NSString *)UN
             AccessToken:(NSString *)AccessToken
                    EqID:(NSString *)EqID
                     Ext:(NSString *)Ext
               ImageData:(NSString *)ImageData
                 success:(void (^)())success
                 failure:(void (^)(NSString *errorMessage))failure;

/**
 *  19.用户反馈信息上传
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param feedBackID     反馈ID
 *  @param content     反馈文字内容
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)UserFeedback_UN:(NSString *)UN
           AccessToken:(NSString *)AccessToken
            FeedBackID:(NSString *)FeedBackID
               Content:(NSString *)Content
               success:(void (^)())success
               failure:(void (^)(NSString *errorMessage))failure;

/**
 *  20.用户反馈图片上传
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param feedBackID     反馈ID
 *  @param content     反馈文字内容
 *  @param Ext     文件后缀名
 *  @param imageData     图片文件字节流的Base64编码字符串
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)UserFeedbackImg_UN:(NSString *)UN
              AccessToken:(NSString *)AccessToken
               FeedBackID:(NSString *)FeedBackID
                  Content:(NSString *)Content
                      Ext:(NSString *)Ext
                ImageData:(NSString *)ImageData
                  success:(void (^)())success
                  failure:(void (^)(NSString *errorMessage))failure;
/**
 *  21.分享我的设备
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param eqID     设备唯一编号
 *  @param friendPhone     好友电话
 *  @param message     留言信息
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)ShareEq_UN:(NSString *)UN
      AccessToken:(NSString *)AccessToken
             EqID:(NSString *)EqID
      FriendPhone:(NSString *)FriendPhone
          Message:(NSString *)Message
          success:(void (^)())success
          failure:(void (^)(NSString *errorMessage))failure;

/**
 *  22.查看邀请我的信息
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)MyInvitation_UN:(NSString *)UN
           AccessToken:(NSString *)AccessToken
               success:(void (^)(NSArray *returnValue))success
               failure:(void (^)(NSString *errorMessage))failure;

/**
 *  23.同意/拒绝邀请信息
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param shareID     分享邀请的唯一标识
 *  @param isApproved      0:拒绝 1:同意
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)InvitationResponse_UN:(NSString *)UN
                 AccessToken:(NSString *)AccessToken
                     ShareID:(NSNumber *)ShareID
                  IsApproved:(NSNumber *)IsApproved
                     success:(void (^)(NSString *FromUser,NSString *EqID,NSString *EquipName,NSString *EquipAlias,NSString *EquipAvatar,LastMessage *LastMessage))success
                     failure:(void (^)(NSString *errorMessage))failure;

/**
 *  24.获取用户所有设备信息
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param tS     时间戳
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)MyEquips_UN:(NSString *)UN
       AccessToken:(NSString *)AccessToken
                TS:(NSNumber *)TS
           success:(void (^)(NSNumber *TS,NSArray *Equips))success
           failure:(void (^)(NSString *errorMessage))failure;

/**
 *  25.获取指定设备的分享信息
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param eqIDs     设备ID列表
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)UserSharings_UN:(NSString *)UN
           AccessToken:(NSString *)AccessToken
                 EqIDs:(NSArray *)EqIDs
               success:(void (^)(NSArray *Equip,NSArray *Users))success
               failure:(void (^)(NSString *errorMessage))failure;

/**
 *  26.删除被分享者与设备的关联
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param eqID     设备ID
 *  @param userID     用户ID
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)DelSharings_UN:(NSString *)UN
          AccessToken:(NSString *)AccessToken
                 EqID:(NSString *)EqID
               UserID:(NSString *)UserID
              success:(void (^)())success
              failure:(void (^)(NSString *errorMessage))failure;

/**
 *  27.获取指定设备最新N条指令信息
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param eqID     设备ID
 *  @param tS     时间戳
 *  @param pageSize     获取数据的条数，即N
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)GetTopCommands_UN:(NSString *)UN
             AccessToken:(NSString *)AccessToken
                    EqID:(NSString *)EqID
                      TS:(NSNumber *)TS
                PageSize:(NSNumber *)PageSize
                 success:(void (^)(NSNumber *RecentTS,NSNumber *OldTS,NSNumber *LeftNumber,NSArray *Commands,NSArray *Users))success
                 failure:(void (^)(NSString *errorMessage))failure;

/**
 *  28.获取指定设备给定时间之前的N条指令数据
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param eqID     设备ID
 *  @param tS     时间戳
 *  @param pageSize     获取数据的条数，即N
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)GetOldCommands_UN:(NSString *)UN
             AccessToken:(NSString *)AccessToken
                    EqID:(NSString *)EqID
                      TS:(NSNumber *)TS
                PageSize:(NSNumber *)PageSize
                 success:(void (^)(NSNumber *OldTS,NSArray *Commands,NSArray *Users))success
                 failure:(void (^)(NSString *errorMessage))failure;

/**
 *  29.客户端向设备发送指令消息
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param eqID     设备ID
 *  @param text     指令内容
 *  @param tS     客户端Unix时间
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)SendCommand_UN:(NSString *)UN
          AccessToken:(NSString *)AccessToken
                 EqID:(NSString *)EqID
                 Text:(NSString *)Text
                   TS:(NSNumber *)TS
              success:(void (^)())success
              failure:(void (^)(NSString *errorMessage))failure;

/**
 *  30.同步客户端指令数据
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param commandInfo     指令信息
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)SynClientData_UN:(NSString *)UN
            AccessToken:(NSString *)AccessToken
            CommandInfo:(NSArray *)CommandInfo
                success:(void (^)(NSNumber *IsSuccess,NSArray *Errors))success
                failure:(void (^)(NSString *errorMessage))failure;

/**
 *  31.获取设备列表（临时接口）
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)GetEquipList_UN:(NSString *)UN
           AccessToken:(NSString *)AccessToken
               success:(void (^)(NSArray *Equips,NSString *EquipID,NSNumber *IsUsing))success
               failure:(void (^)(NSString *errorMessage))failure;

/**
 *  32.我的好友列表
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)GetFriendsList_UN:(NSString *)UN
             AccessToken:(NSString *)AccessToken
                 success:(void (^)(NSArray *friendsArray))success
                 failure:(void (^)(NSString *errorMessage))failure;

/**
 *  33.搜索好友信息
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param identifiy     用户唯一标识（现输入为手机号）
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)SeachFriendInfo_UN:(NSString *)UN
              AccessToken:(NSString *)AccessToken
                Identifiy:(NSString *)Identifiy
                  success:(void (^)(SeachFriendInfoModel *friend))success
                  failure:(void (^)(NSString *errorMessage))failure;

/**
 *  34.添加好友
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param fID     好友ID（32位ASCII码，用户在系统中唯一标识）
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)AddFriendInfo_UN:(NSString *)UN
            AccessToken:(NSString *)AccessToken
                    FID:(NSString *)FID
                success:(void (^)())success
                failure:(void (^)(NSString *errorMessage))failure;

/**
 *  35.我的设备圈列表
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)MyCircles_UN:(NSString *)UN
        AccessToken:(NSString *)AccessToken
            success:(void (^)(NSArray *myCircles))success
            failure:(void (^)(NSString *errorMessage))failure;

/**
 *  36.添加设备圈
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param name     设备圈名称
 *  @param eqIDs     设备ID数组
 *  @param userIDs     用户ID数组
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)AddCircle_UN:(NSString *)UN
        AccessToken:(NSString *)AccessToken
               Name:(NSString *)Name
              EqIDs:(NSArray *)EqIDs
            UserIDs:(NSArray *)UserIDs
            success:(void (^)(NSNumber *IsSuccess,NSArray *Errors))success
            failure:(void (^)(NSString *errorMessage))failure;

/**
 *  37.修改设备圈
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param circleID     32位唯一ID
 *  @param name     设备圈名称
 *  @param eqIDs     设备ID数组
 *  @param userIDs     用户ID数组
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)UpdateCircle_UN:(NSString *)UN
           AccessToken:(NSString *)AccessToken
              CircleID:(NSString *)CircleID
                  Name:(NSString *)Name
                 EqIDs:(NSArray *)EqIDs
               UserIDs:(NSArray *)UserIDs
               success:(void (^)(NSNumber *IsSuccess,NSArray *Errors))success
               failure:(void (^)(NSString *errorMessage))failure;

/**
 *  38.获取设备圈详细信息
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param circleID     32位唯一ID
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)GetCircleDetail_UN:(NSString *)UN
              AccessToken:(NSString *)AccessToken
                 CircleID:(NSString *)CircleID
                  success:(void (^)(NSArray *EqInfo,NSArray *UserInfo))success
                  failure:(void (^)(NSString *errorMessage))failure;

/**
 *  39.设备圈中发送信息
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param circleID     32位唯一ID
 *  @param eqIDs     设备唯一ID数组(可空，为空则默认对所有设备发送)
 *  @param text     指令内容
 *  @param tS     客户端Unix时间
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)SendCircleMessages_UN:(NSString *)UN
                 AccessToken:(NSString *)AccessToken
                    CircleID:(NSString *)CircleID
                       EqIDs:(NSArray *)EqIDs
                        Text:(NSString *)Text
                          TS:(NSNumber *)TS
                     success:(void (^)())success
                     failure:(void (^)(NSString *errorMessage))failure;

/**
 *  40.获取指定设备圈给定时间之前的N条指令数据（老数据）
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param circleID     32位唯一ID
 *  @param tS     客户端Unix时间
 *  @param pageSize     获取数据的条数，即N
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)GetOldCircleMessages_UN:(NSString *)UN
                   AccessToken:(NSString *)AccessToken
                      CircleID:(NSString *)CircleID
                            TS:(NSNumber *)TS
                      PageSize:(NSNumber *)PageSize
                       success:(void (^)(NSNumber *OldTS,NSArray *Messages,NSArray *MessageUser,NSArray *MessageEquip))success
                       failure:(void (^)(NSString *errorMessage))failure;


/**
 *  41.获取指定设备圈给定时间之后的N条指令数据（新数据）
 *
 *  @param uN     HGUID
 *  @param accessToken     访问令牌
 *  @param circleID     32位唯一ID
 *  @param tS     客户端Unix时间
 *  @param pageSize     获取数据的条数，即N
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)GetTopCircleMessages_UN:(NSString *)UN
                   AccessToken:(NSString *)AccessToken
                      CircleID:(NSString *)CircleID
                            TS:(NSNumber *)TS
                      PageSize:(NSNumber *)PageSize
                       success:(void (^)(NSNumber *TopTS,NSArray *Messages,NSArray *MessageUser,NSArray *MessageEquip))success
                       failure:(void (^)(NSString *errorMessage))failure;
@end

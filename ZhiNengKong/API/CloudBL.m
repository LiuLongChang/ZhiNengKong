//
//  CloudBL.m
//  APIDemo
//
//  Created by 宣佚 on 15/6/1.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "CloudBL.h"
#import "CloudDao.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Password)

#pragma mark - 密码加密算法

/**
 *  对字符串进行加密
 *
 *  @param topInfo 需要加密的文字
 *  @param const_Str 常量盐值
 *  @param IsLower 是否为小写 设置为YES
 *
 *  @return 加密后的内容
 */
-(NSString *)SHA1:(NSString *)topInfo const_Str:(NSString *)const_Str IsLower:(BOOL)IsLower
{
    NSString *tempMd5 = [NSString stringWithFormat:@"%@%@",const_Str,topInfo];
    NSString *md5 = [self MD5:tempMd5 StringCode:NSUTF8StringEncoding IsLower:YES];
    
    NSString *tempSH = [NSString stringWithFormat:@"%@%@",md5,topInfo];
    
    const char *cstr = [tempSH cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:tempSH.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    if (IsLower) {
        return [output lowercaseString];
    } else {
        return [output uppercaseString];
    }
    return output;
}

-(NSString *)MD5:(NSString *)topInfo StringCode:(NSStringEncoding)encode IsLower:(BOOL)IsLower
{
    NSData *data = [topInfo dataUsingEncoding:encode];
    Byte * myByte = (Byte *)[data bytes];
    unsigned char result[16];
    CC_MD5( myByte, (CC_LONG)[data length], result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    if (IsLower) {
        return [hash lowercaseString];
    } else {
        return [hash uppercaseString];
    }
}

-(NSString *)encodePassword{
    
    //密码加密盐值
    NSString *passwordToken = @"-6Qg5TyljKlKD~qLu,Y22!UR++4Kep+$";
    
    return [self SHA1:self const_Str:passwordToken IsLower:YES];
}

@end

@implementation CloudBL

/**
 *  申请手机注册验证码，对应API 1
 *
 *  @param Phone   申请手机
 *  @param success 成功返回
 *  @param failure 失败返回
 */
+(void)GetRegisterVerityCode_Phone:(NSString *)Phone
                           success:(void (^)(void))success
                           failure:(void (^)(NSString *errorMessage))failure
{
    PostGetRegisterVerityCodeModel *model = [[PostGetRegisterVerityCodeModel alloc] init];
    model.phone = Phone;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao GetRegisterVerityCode:topInfo
                            success:^(id returnValue) {
                                success();
                            }
                            failure:^(NSString *errorMessage) {
                                failure(errorMessage);
                            }
                          exception:^(NSString *errorMessage) {
                              failure(@"网络请求异常");
                          }
     ];
}

/**
 *  验证手机注册验证码，对应API 2
 *
 *  @param Phone   申请手机
 *  @param Code    申请手机验证码
 *  @param success 成功返回 BOOL
 *  @param failure 失败返回
 */
+(void)VerityRegisterCode_Phone:(NSString *)Phone
                           Code:(NSString *)Code
                        success:(void (^)(BOOL VerityisSuccess))success
                        failure:(void (^)(NSString *errorMessage))failure
{
    PostVerityRegisterCodeModel *model = [[PostVerityRegisterCodeModel alloc] init];
    model.phone = Phone;
    model.code = Code;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao VerityRegisterCode:topInfo
                         success:^(id returnValue) {
                             if ([returnValue intValue] == 1)
                             {
                                 success(YES);
                             }
                             else if ([returnValue intValue] == 0)
                             {
                                 success(NO);
                             }
                         }
                         failure:^(NSString *errorMessage) {
                             failure(errorMessage);
                         }
                       exception:^(NSString *errorMessage) {
                           failure(@"网络请求异常");
                       }];
}

/**
 *  手机账号注册，对应API 3
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
                  failure:(void (^)(NSString *errorMessage))failure
{
    PostRegisterUserModel *model = [[PostRegisterUserModel alloc] init];
    model.phone = Phone;
    model.code = Code;
    model.password = [Password encodePassword];
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao RegisterUser:topInfo
                   success:^(id returnValue) {
                       RegisterUserModel *userModel = [RegisterUserModel modelObjectWithDictionary:returnValue];
                       success(userModel.hGUID,userModel.token);
                   }
                   failure:^(NSString *errorMessage) {
                       failure(errorMessage);
                   }
                 exception:^(NSString *errorMessage) {
                     failure(@"网络请求异常");
                 }];
}

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
                failure:(void (^)(NSString *errorMessage))failure
{
    PostPhoneLoginModel *model = [[PostPhoneLoginModel alloc] init];
    model.phone = Phone;
    model.password = [Password encodePassword];
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao PhoneLogin:topInfo
                 success:^(id returnValue) {
                     PhoneLoginModel *model = [PhoneLoginModel modelObjectWithDictionary:returnValue];
                     success(model.hGUID,model.token,model.userName);
                 }
                 failure:^(NSString *errorMessage) {
                     failure(errorMessage);
                 }
               exception:^(NSString *errorMessage) {
                   failure(@"网络请求异常");
               }];
}

/**
 *  5.申请重置密码验证码
 *
 *  @param phone     手机号
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)VerifyReset_Phone:(NSString *)Phone
                 success:(void (^)())success
                 failure:(void (^)(NSString *errorMessage))failure
{
    PostVerifyResetModel *model = [[PostVerifyResetModel alloc] init];
    model.phone = Phone;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao VerifyReset:topInfo
                  success:^(id returnValue) {
                      success();
                  }
                  failure:^(NSString *errorMessage) {
                      failure(errorMessage);
                  }
                exception:^(NSString *errorMessage) {
                    failure(@"网络请求异常");
                }];
}

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
                     failure:(void (^)(NSString *errorMessage))failure
{
    PostVerifyResetCodeModel *model = [[PostVerifyResetCodeModel alloc] init];
    model.phone = Phone;
    model.code = Code;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao VerifyResetCode:topInfo
                      success:^(id returnValue) {
                          success();
                      }
                      failure:^(NSString *errorMessage) {
                          failure(errorMessage);
                      }
                    exception:^(NSString *errorMessage) {
                        failure(@"网络请求异常");
                    }];
}

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
               failure:(void (^)(NSString *errorMessage))failure
{
    PostResetCodeModel *model = [[PostResetCodeModel alloc] init];
    model.phone = Phone;
    model.code = Code;
    model.password = [Password encodePassword];
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao ResetCode:topInfo
                success:^(id returnValue) {
                    ResetCodeModel *model = [ResetCodeModel modelObjectWithDictionary:returnValue];
                    success(model.hGUID,model.token);
                }
                failure:^(NSString *errorMessage) {
                    failure(errorMessage);
                }
              exception:^(NSString *errorMessage) {
                  failure(@"网络请求异常");
              }];
}

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
               failure:(void (^)(NSString *errorMessage))failure
{
    PostRefreshTokenModel *model = [[PostRefreshTokenModel alloc] init];
    model.uN = UN;
    model.refreshToken = RefreshToken;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao RefreshToken:topInfo
                   success:^(id returnValue) {
                       RefreshTokenModel *model = [RefreshTokenModel modelObjectWithDictionary:returnValue];
                       success(model.hGUID,model.token);
                   }
                   failure:^(NSString *errorMessage) {
                       failure(errorMessage);
                   }
                 exception:^(NSString *errorMessage) {
                     failure(@"网络请求异常");
                 }];
}

/**
 *  9.申请手机动态登录码
 *
 *  @param phone     手机号
 *  @param success   成功返回
 *  @param failure   失败返回
 */
+(void)GetLoginCode_Phone:(NSString *)Phone
                  success:(void (^)())success
                  failure:(void (^)(NSString *errorMessage))failure
{
    PostGetLoginCodeModel *model = [[PostGetLoginCodeModel alloc] init];
    model.phone = Phone;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao GetLoginCode:topInfo
                   success:^(id returnValue) {
                       success();
                   }
                   failure:^(NSString *errorMessage) {
                       failure(errorMessage);
                   }
                 exception:^(NSString *errorMessage) {
                     failure(@"网络请求异常");
                 }];
}

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
               failure:(void (^)(NSString *errorMessage))failure
{
    PostCodeLoginModel *model = [[PostCodeLoginModel alloc] init];
    model.phone = Phone;
    model.code = Code;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao CodeLogin:topInfo
                success:^(id returnValue) {
                    CodeLoginModel *model = [CodeLoginModel modelObjectWithDictionary:returnValue];
                    success(model.hGUID,model.token,model.userName);
                }
                failure:^(NSString *errorMessage) {
                    failure(errorMessage);
                }
              exception:^(NSString *errorMessage) {
                  failure(@"网络请求异常");
              }];
}

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
              failure:(void (^)(NSString *errorMessage))failure
{
    PostGetUserInfoModel *model = [[PostGetUserInfoModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao GetUserInfo:topInfo
                  success:^(id returnValue) {
                      GetUserInfoModel *model = [GetUserInfoModel modelObjectWithDictionary:returnValue];
                      success(model.hGUID,model.phone,model.logo,model.userName);
                  }
                  failure:^(NSString *errorMessage) {
                      failure(errorMessage);
                  }
                exception:^(NSString *errorMessage) {
                    failure(@"网络请求异常");
                }];
}

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
              failure:(void (^)(NSString *errorMessage))failure
{
    PostSetUserInfoModel *model = [[PostSetUserInfoModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.changes = Changes;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao SetUserInfo:topInfo
                  success:^(id returnValue) {
                      SetUserInfoModel *model = [SetUserInfoModel modelObjectWithDictionary:returnValue];
                      success([model.isSuccess intValue],model.errors);
                  }
                  failure:^(NSString *errorMessage) {
                      failure(errorMessage);
                  }
                exception:^(NSString *errorMessage) {
                    failure(@"网络请求异常");
                }];
}

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
             NewPassword:(NSString *)NowPassword
                 success:(void (^)(NSString *HGUID,Token *Token))success
                 failure:(void (^)(NSString *errorMessage))failure
{
    PostChangePasswordModel *model = [[PostChangePasswordModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.oldPassword = [OldPassword encodePassword];
    model.nowPassword = [NowPassword encodePassword];
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao ChangePassword:topInfo
                     success:^(id returnValue) {
                         ChangePasswordModel *model = [ChangePasswordModel modelObjectWithDictionary:returnValue];
                         success(model.hGUID,model.token);
                     }
                     failure:^(NSString *errorMessage) {
                         failure(errorMessage);
                     }
                   exception:^(NSString *errorMessage) {
                       failure(@"网络请求异常");
                   }];
}

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
                failure:(void (^)(NSString *errorMessage))failure
{
    PostUploadAvatarsModel *model = [[PostUploadAvatarsModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.ext = Ext;
    model.imageData = ImageData;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao UploadAvatars:topInfo
                    success:^(id returnValue) {
                        success();
                    }
                    failure:^(NSString *errorMessage) {
                        failure(errorMessage);
                    }
                  exception:^(NSString *errorMessage) {
                      failure(@"网络请求异常");
                  }];
}

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
        failure:(void (^)(NSString *errorMessage))failure
{
    PostAddEqModel *model = [[PostAddEqModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.eqID = EqID;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao AddEq:topInfo
            success:^(id returnValue) {
                AddEqModel *model = [AddEqModel modelObjectWithDictionary:returnValue];
                success(model.eqID,model.name,model.alias,model.lastMessage);
            }
            failure:^(NSString *errorMessage) {
                failure(errorMessage);
            }
          exception:^(NSString *errorMessage) {
              failure(@"网络请求异常");
          }];
}

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
        failure:(void (^)(NSString *errorMessage))failure
{
    PostDelEqModel *model = [[PostDelEqModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.eqID = EqID;
    if ([Password isEqualToString:@""]) {
        model.password = Password;
    }else{
        model.password = [Password encodePassword];
    }
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao DelEq:topInfo
            success:^(id returnValue) {
                success();
            }
            failure:^(NSString *errorMessage) {
                failure(errorMessage);
            }
          exception:^(NSString *errorMessage) {
              failure(@"网络请求异常");
          }];
}

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
           failure:(void (^)(NSString *errorMessage))failure
{
    PostUpdateEqModel *model = [[PostUpdateEqModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.eqID = EqID;
    model.changes = Changes;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao UpdateEq:topInfo
               success:^(id returnValue) {
                   success();
               }
               failure:^(NSString *errorMessage) {
                   failure(errorMessage);
               }
             exception:^(NSString *errorMessage) {
                 failure(@"网络请求异常");
             }];
}

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
                 failure:(void (^)(NSString *errorMessage))failure
{
    PostUploadEqAvatarModel *model = [[PostUploadEqAvatarModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.eqID = EqID;
    model.ext = Ext;
    model.imageData = ImageData;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao UploadEqAvatar:topInfo
                     success:^(id returnValue) {
                         success();
                     }
                     failure:^(NSString *errorMessage) {
                         failure(errorMessage);
                     }
                   exception:^(NSString *errorMessage) {
                       failure(@"网络请求异常");
                   }];
}

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
               failure:(void (^)(NSString *errorMessage))failure
{
    PostUserFeedbackModel *model = [[PostUserFeedbackModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.feedBackID = FeedBackID;
    model.content = Content;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao UserFeedback:topInfo
                   success:^(id returnValue) {
                       success();
                   }
                   failure:^(NSString *errorMessage) {
                       failure(errorMessage);
                   }
                 exception:^(NSString *errorMessage) {
                     failure(@"网络请求异常");
                 }];
}

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
                  failure:(void (^)(NSString *errorMessage))failure
{
    PostUserFeedbackImgModel *model = [[PostUserFeedbackImgModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.feedBackID = FeedBackID;
    model.ext = Ext;
    model.content = Content;
    model.imageData = ImageData;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao UserFeedbackImg:topInfo
                      success:^(id returnValue) {
                          success();
                      }
                      failure:^(NSString *errorMessage) {
                          failure(errorMessage);
                      }
                    exception:^(NSString *errorMessage) {
                        failure(@"网络请求异常");
                    }];
}

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
          failure:(void (^)(NSString *errorMessage))failure
{
    PostShareEqModel *model = [[PostShareEqModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.eqID = EqID;
    model.friendPhone = FriendPhone;
    model.message = Message;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao ShareEq:topInfo
              success:^(id returnValue) {
                  success();
              }
              failure:^(NSString *errorMessage) {
                  failure(errorMessage);
              }
            exception:^(NSString *errorMessage) {
                failure(@"网络请求异常");
            }];
}

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
               success:(void (^)(NSArray * returnValue))success
               failure:(void (^)(NSString *errorMessage))failure
{
    PostMyInvitationModel *model = [[PostMyInvitationModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao MyInvitation:topInfo
                   success:^(id returnValue) {
                       success(returnValue);
                   }
                   failure:^(NSString *errorMessage) {
                       failure(errorMessage);
                   }
                 exception:^(NSString *errorMessage) {
                     failure(@"网络请求异常");
                 }];
}

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
                     failure:(void (^)(NSString *errorMessage))failure
{
    PostInvitationResponseModel *model = [[PostInvitationResponseModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.shareID = ShareID;
    model.isApproved = IsApproved;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao InvitationResponse:topInfo
                         success:^(id returnValue) {
                             InvitationResponseModel *model = [InvitationResponseModel modelObjectWithDictionary:returnValue];
                             success(model.fromUser,model.eqID,model.equipName,model.equipAlias,model.equipAvatar,model.lastMessage);
                         }
                         failure:^(NSString *errorMessage) {
                             failure(errorMessage);
                         }
                       exception:^(NSString *errorMessage) {
                           failure(@"网络请求异常");
                       }];
}

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
           failure:(void (^)(NSString *errorMessage))failure
{
    PostMyEquipsModel *model = [[PostMyEquipsModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.tS = TS;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao MyEquips:topInfo
               success:^(id returnValue) {
                   MyEquipsModel *model = [MyEquipsModel modelObjectWithDictionary:returnValue];
                   success(model.tS,model.equips);
               }
               failure:^(NSString *errorMessage) {
                   failure(errorMessage);
               }
             exception:^(NSString *errorMessage) {
                 failure(@"网络请求异常");
             }];
}

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
               failure:(void (^)(NSString *errorMessage))failure
{
    PostUserSharingsModel *model = [[PostUserSharingsModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.eqIDs = EqIDs;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao UserSharings:topInfo
                   success:^(id returnValue) {
                       UserSharingsModel *model = [UserSharingsModel modelObjectWithDictionary:returnValue];
                       success(model.equip,model.users);
                   }
                   failure:^(NSString *errorMessage) {
                       failure(errorMessage);
                   }
                 exception:^(NSString *errorMessage) {
                     failure(@"网络请求异常");
                 }];
}

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
              failure:(void (^)(NSString *errorMessage))failure
{
    PostDelSharingsModel *model = [[PostDelSharingsModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.eqID = EqID;
    model.userID = UserID;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao DelSharings:topInfo
                  success:^(id returnValue) {
                      success();
                  }
                  failure:^(NSString *errorMessage) {
                      failure(errorMessage);
                  }
                exception:^(NSString *errorMessage) {
                    failure(@"网络请求异常");
                }];
}

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
                 failure:(void (^)(NSString *errorMessage))failure
{
    PostGetTopCommandsModel *model = [[PostGetTopCommandsModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.eqID = EqID;
    model.tS = TS;
    model.pageSize = PageSize;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao GetTopCommands:topInfo
                     success:^(id returnValue) {
                         GetTopCommandsModel *model = [GetTopCommandsModel modelObjectWithDictionary:returnValue];
                         success(model.recentTS,model.oldTS,model.leftNumber,model.commands,model.users);
                     }
                     failure:^(NSString *errorMessage) {
                         failure(errorMessage);
                     }
                   exception:^(NSString *errorMessage) {
                       failure(@"网络请求异常");
                   }];
}

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
                 failure:(void (^)(NSString *errorMessage))failure
{
    PostGetOldCommandsModel *model = [[PostGetOldCommandsModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.eqID = EqID;
    model.tS = TS;
    model.pageSize = PageSize;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao GetOldCommands:topInfo
                     success:^(id returnValue) {
                         GetOldCommandsModel *model = [GetOldCommandsModel modelObjectWithDictionary:returnValue];
                         success(model.oldTS,model.commands,model.users);
                     }
                     failure:^(NSString *errorMessage) {
                         failure(errorMessage);
                     }
                   exception:^(NSString *errorMessage) {
                       failure(@"网络请求异常");
                   }];
}

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
              failure:(void (^)(NSString *errorMessage))failure
{
    PostSendCommandModel *model = [[PostSendCommandModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.eqID = EqID;
    model.text = Text;
    model.tS = TS;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao SendCommand:topInfo
                  success:^(id returnValue) {
                      success();
                  }
                  failure:^(NSString *errorMessage) {
                      failure(errorMessage);
                  }
                exception:^(NSString *errorMessage) {
                    failure(@"网络请求异常");
                }];
}

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
                failure:(void (^)(NSString *errorMessage))failure
{
    PostSynClientDataModel *model = [[PostSynClientDataModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.commandInfo = CommandInfo;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao SynClientData:topInfo
                    success:^(id returnValue) {
                        SynClientDataModel *model = [SynClientDataModel modelObjectWithDictionary:returnValue];
                        success(model.isSuccess,model.errors);
                    }
                    failure:^(NSString *errorMessage) {
                        failure(errorMessage);
                    }
                  exception:^(NSString *errorMessage) {
                      failure(@"网络请求异常");
                  }];
}

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
               failure:(void (^)(NSString *errorMessage))failure
{
    PostGetEquipListModel *model = [[PostGetEquipListModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao GetEquipList:topInfo
                   success:^(id returnValue) {
                       GetEquipListModel *model = [GetEquipListModel modelObjectWithDictionary:returnValue];
                       success(model.equips,model.equipID,model.isUsing);
                   }
                   failure:^(NSString *errorMessage) {
                       failure(errorMessage);
                   }
                 exception:^(NSString *errorMessage) {
                     failure(@"网络请求异常");
                 }];
}

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
                 failure:(void (^)(NSString *errorMessage))failure
{
    PostGetFriendsListModel *model = [[PostGetFriendsListModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao GetFriendsList:topInfo
                     success:^(id returnValue) {
                         success(returnValue);
                     }
                     failure:^(NSString *errorMessage) {
                         failure(errorMessage);
                     }
                   exception:^(NSString *errorMessage) {
                       failure(@"网络请求异常");
                   }];
}

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
                  failure:(void (^)(NSString *errorMessage))failure
{
    PostSeachFriendInfoModel *model = [[PostSeachFriendInfoModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.identifiy = Identifiy;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao SeachFriendInfo:topInfo
                      success:^(id returnValue) {
                          SeachFriendInfoModel *model = [SeachFriendInfoModel modelObjectWithDictionary:returnValue];
                          success(model);
                      }
                      failure:^(NSString *errorMessage) {
                          failure(errorMessage);
                      }
                    exception:^(NSString *errorMessage) {
                        failure(@"网络请求异常");
                    }];
}

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
                failure:(void (^)(NSString *errorMessage))failure
{
    PostAddFriendInfoModel *model = [[PostAddFriendInfoModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.fID = FID;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao AddFriendInfo:topInfo
                    success:^(id returnValue) {
                        success();
                    }
                    failure:^(NSString *errorMessage) {
                        failure(errorMessage);
                    }
                  exception:^(NSString *errorMessage) {
                      failure(@"网络请求异常");
                  }];
}

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
            failure:(void (^)(NSString *errorMessage))failure
{
    PostMyCirclesModel *model = [[PostMyCirclesModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao MyCircles:topInfo
                success:^(id returnValue) {
                    success(returnValue);
                }
                failure:^(NSString *errorMessage) {
                    failure(errorMessage);
                }
              exception:^(NSString *errorMessage) {
                  failure(@"网络请求异常");
              }];
}

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
            failure:(void (^)(NSString *errorMessage))failure
{
    PostAddCircleModel *model = [[PostAddCircleModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.name = Name;
    model.eqIDs = EqIDs;
    model.userIDs = UserIDs;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao AddCircle:topInfo
                   success:^(id returnValue) {
                       AddCircleModel *model = [AddCircleModel modelObjectWithDictionary:returnValue];
                       success(model.isSuccess,model.errors);
                   }
                   failure:^(NSString *errorMessage) {
                       failure(errorMessage);
                   }
                 exception:^(NSString *errorMessage) {
                     failure(@"网络请求异常");
                 }];
}

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
               failure:(void (^)(NSString *errorMessage))failure
{
    PostUpdateCircleModel *model = [[PostUpdateCircleModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.circleID = CircleID;
    model.name = Name;
    model.eqIDs = EqIDs;
    model.userIDs = UserIDs;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao UpdateCircle:topInfo
                   success:^(id returnValue) {
                       UpdateCircleModel *model = [UpdateCircleModel modelObjectWithDictionary:returnValue];
                       success(model.isSuccess,model.errors);
                   }
                   failure:^(NSString *errorMessage) {
                       failure(errorMessage);
                   }
                 exception:^(NSString *errorMessage) {
                     failure(@"网络请求异常");
                 }];
}

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
                  failure:(void (^)(NSString *errorMessage))failure
{
    PostGetCircleDetailModel *model = [[PostGetCircleDetailModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.circleID = CircleID;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao GetCircleDetail:topInfo
                      success:^(id returnValue) {
                          GetCircleDetailModel *model = [GetCircleDetailModel modelObjectWithDictionary:returnValue];
                          success(model.eqInfo,model.userInfo);
                      }
                      failure:^(NSString *errorMessage) {
                          failure(errorMessage);
                      }
                    exception:^(NSString *errorMessage) {
                        failure(@"网络请求异常");
                    }];
}

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
                     failure:(void (^)(NSString *errorMessage))failure
{
    PostSendCircleMessagesModel *model = [[PostSendCircleMessagesModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.circleID = CircleID;
    model.eqIDs = EqIDs;
    model.text = Text;
    model.tS = TS;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao SendCircleMessages:topInfo
                         success:^(id returnValue) {
                             success();
                         }
                         failure:^(NSString *errorMessage) {
                             failure(errorMessage);
                         }
                       exception:^(NSString *errorMessage) {
                           failure(@"网络请求异常");
                       }];
}

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
                       failure:(void (^)(NSString *errorMessage))failure
{
    PostGetOldCircleMessagesModel *model = [[PostGetOldCircleMessagesModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.circleID = CircleID;
    model.tS = TS;
    model.pageSize = PageSize;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao GetOldCircleMessages:topInfo
                           success:^(id returnValue) {
                               GetOldCircleMessagesModel *model = [GetOldCircleMessagesModel modelObjectWithDictionary:returnValue];
                               success(model.oldTS,model.messages,model.messageUser,model.messageEquip);
                           }
                           failure:^(NSString *errorMessage) {
                               failure(errorMessage);
                           }
                         exception:^(NSString *errorMessage) {
                             failure(@"网络请求异常");
                         }];
}

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
                       failure:(void (^)(NSString *errorMessage))failure
{
    PostGetTopCircleMessagesModel *model = [[PostGetTopCircleMessagesModel alloc] init];
    model.uN = UN;
    model.accessToken = AccessToken;
    model.circleID = CircleID;
    model.tS = TS;
    model.pageSize = PageSize;
    NSDictionary *topInfo = [model dictionaryRepresentation];
    
    [CloudDao GetTopCircleMessages:topInfo
                           success:^(id returnValue) {
                               GetTopCircleMessagesModel *model = [GetTopCircleMessagesModel modelObjectWithDictionary:returnValue];
                               success(model.topTS,model.messages,model.messageUser,model.messageEquip);
                           }
                           failure:^(NSString *errorMessage) {
                               failure(errorMessage);
                           }
                         exception:^(NSString *errorMessage) {
                             failure(@"网络请求异常");
                         }];
}


@end

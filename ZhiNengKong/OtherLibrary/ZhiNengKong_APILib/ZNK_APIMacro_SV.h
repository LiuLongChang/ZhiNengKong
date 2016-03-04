//
//  ZNK_APIMacro_SV.h
//  ZhiNengKong_APILib
//
//  Created by 宣佚 on 15/5/26.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#ifndef ZhiNengKong_APILib_ZNK_APIMacro_SV_h
#define ZhiNengKong_APILib_ZNK_APIMacro_SV_h

//说明：SC和SV在网络请求中没有实际意义，按照API中各接口提供的SC与SV对应配置即可
//如果SC和SV与API协议中给出的不一致会返回网络请求错误

//请根据API给出的SC进行配置
#pragma mark - SC

#define KSC  @"1eb3253f3acb44c0a18b0bfbb0dac3d7"

//请根据API给出的单个接口SV进行配置
#pragma mark - SV

/*!
 *  1．申请手机注册验证码
 */
#define kGetRegisterVerityCodeSV @"7fd868b50ae14e10a782e638c968b1c0"

/*!
 *  2．验证手机注册验证码
 */
#define kVerityRegisterCodeSV @"60eeaeb3e193468b9f92f01572c927ec"

/*!
 *  3．手机账号注册
 */
#define kRegisterUserSV @"3c84d6f8604d425f971bdce64738b334"

/*!
 *  4．手机账号登录
 */
#define kPhoneLoginSV @"a3f12d3b0d46406eb6979e2de2d8dddf"

/*!
 *  5．申请重置密码验证码
 */
#define kVerifyResetSV @"02e6709d84ad4ccbbbf803bf07cdd8bf"

/*!
 *  6．验证重置密码验证码
 */
#define kVerifyResetCodeSV @"3eb5acad1f7e461dbe336471456ab088"

/*!
 *  7．重置密码
 */
#define kResetCodeSV @"19571df63c634cd9b51adb83ec740d34"

/*!
 *  8．访问令牌刷新
 */
#define kRefreshTokenSV @"194cc5a658a34dc7915c58e384d1cca5"

/*!
 *  9．申请手机动态登录码
 */
#define kGetLoginCodeSV @"7065e4ec6ca94c23ac420b44348ecf69"

/*!
 *  10．手机动态码登录
 */
#define kCodeLoginSV @"7acc561e6ed14242a808853ebd011ab6"

/*!
 *  11．获取用户个人信息资料
 */
#define kGetUserInfoSV @"fad9f402d346455d883772655c27453c"

/*!
 *  12．修改用户个人信息资料
 */
#define kSetUserInfoSV @"9d1de4bb82154534942b724bbfc417ef"

/*!
 *  13．修改密码
 */
#define kChangePasswordSV @"28ba708deb42460b86a9317a07d7bc03"

/*!
 *  14．个人资料中用户上传头像
 */
#define kUploadAvatarsSV @"d5be504bc4ca4f4d961b3b68ff54fcdb"

/*!
 *  15．添加设备
 */
#define kAddEqSV @"bb3624f9d9624922bed554eef28d09a2"

/*!
 *  16．删除设备
 */
#define kDelEqSV @"fc8f768ce0054c1c8bbd11c33ff709aa"

/*!
 *  17．修改设备
 */
#define kUpdateEqSV @"d1c789191196479c89796edcd1bd22da"

/*!
 *  18．设备资料中上传设备头像
 */
#define kUploadEqAvatarSV @"f32854dc09be4151bfddc4464966dadb"

/*!
 *  19．用户反馈信息上传
 */
#define kUserFeedbackSV @"085fa75cb15c48fdb00fdde762b7bde5"

/*!
 *  20．用户反馈图片上传
 */
#define kUserFeedbackImgSV @"f9afeaee580f4a50ba32ca6df494a102"

/*!
 *  21．分享我的设备
 */
#define kShareEqSV @"3be2f85c97fe4e808e0bb2b0bcfd24f5"

/*!
 *  22．查看邀请我的信息
 */
#define kMyInvitationSV @"2e766c09e49f489ebb17e8f3091c412b"

/*!
 *  23．同意/拒绝邀请信息
 */
#define kInvitationResponseSV @"6520206dffed482d8e113a094b677084"

/*!
 *  24．获取用户所有设备信息
 */
#define kMyEquipsSV @"b3975723e47840bcbeb5358b5b617019"

/*!
 *  25．获取指定设备的分享信息
 */
#define kUserSharingsSV @"e35147b1cfb54769aff1a53cb874f6fb"

/*!
 *  26．删除被分享者与设备的关联
 */
#define kDelSharingsSV @"79ad428c37994b8b8ac86aef3cbcaba9"

/*!
 *  27．获取指定设备最新的N条信息
 */
#define kGetTopCommandsSV @"7313cd5b04754dd7b0b0af8daf975d10"

/*!
 *  28．客户端向设备发送指令消息
 */
#define kGetOldCommandsSV @"6d877b35a465400f817603204b70cb8c"

/*!
 *  29．客户端向设备发送指令消息
 */
#define kSendCommandSV @"3826ba1ab9274a538694479c9f3a12a0"

/*!
 *  30．同步客户端指令数据
 */
#define kSynClientDataSV @"bba779670fbe47d0871ad8fa1cfa54a6"

/*!
 *  31．获取设备列表（临时接口）
 */
#define kGetEquipListSV @"35d07db112374c18bbbc7b1c50ca6ec2"

/*!
 *  32．我的好友列表
 */
#define kGetFriendsListSV @"404275e5d3844d72ae0d1c8ba4fea084"

/*!
 *  33．搜索好友信息
 */
#define kSeachFriendInfoSV @"a6893650437b460cb22977b45c00095c"

/*!
 *  34．添加好友
 */
#define kAddFriendInfoSV @"bcab0148e9e24f5ebecb9a5f8b00276f"

/*!
 *  35．我的设备圈列表
 */
#define kMyCirclesSV @"b3bdc377e6384769bbbd4c15ad1722e0"

/*!
 *  36．添加设备圈
 */
#define kAddCircleSV @"d6e081af26d541c4b8605f41deab990c"

/*!
 *  37．修改设备圈
 */
#define kUpdateCircleSV @"9881e13c98004a32aa17f2873ce72500"

/*!
 *  38．获取设备圈详细信息
 */
#define kGetCircleDetailSV @"6ff60489a647470dbc501985e3bd305c"

/*!
 *  39．设备圈中发送信息
 */
#define kSendCircleMessagesSV @"3adb1e8bbc0542f5a799b4884b971bae"

/*!
 *  40．获取指定设备圈给定时间之前的N条指令数据（老数据）
 */
#define kGetOldCircleMessagesSV @"bec7a37df47c4f6d8379bf7cd44bf12f"

/*!
 *  41．获取指定设备圈给定时间之后的N条指令数据（新数据）
 */
#define kGetTopCircleMessagesSV @"3ab4c5e0225e4cbfacf1fb4664bd25dd"

#endif

//
//  ZNK_APIMacro_URL.h
//  ZhiNengKong_APILib
//
//  Created by 宣佚 on 15/5/26.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#ifndef ZhiNengKong_APILib_ZNK_APIMacro_URL_h
#define ZhiNengKong_APILib_ZNK_APIMacro_URL_h

//请根据API给出的服务器主地址进行配置
#pragma mark - 服务器地址

#define kSBaseURL      @""   //正式
#define kSTestBaseURL  @""   //测试
#define kSDebugBaseURL @"http://intellihousedev.chinacloudapp.cn"   //调试

//请根据API给出的单个接口地址进行配置
#pragma mark - API地址

/*!
 *  1．申请手机注册验证码
 */
#define KGetRegisterVerityCodeURL @"/api/verify_phone"

/*!
 *  2．验证手机注册验证码
 */
#define kVerityRegisterCodeURL @"/api/verify_phone_code"

/*!
 *  3．手机账号注册
 */
#define kRegisterUserURL @"/api/reg_phone"

/*!
 *  4．手机账号登录
 */
#define kPhoneLoginURL @"/api/phone_login"

/*!
 *  5．申请重置密码验证码
 */
#define kVerifyResetURL @"/api/verify_reset"

/*!
 *  6．验证重置密码验证码
 */
#define kVerifyResetCodeURL @"/api/verify_reset_code"

/*!
 *  7．重置密码
 */
#define kResetCodeURL @"/api/reset_code"

/*!
 *  8．访问令牌刷新
 */
#define kRefreshTokenURL @"/api/refresh_token"

/*!
 *  9．申请手机动态登录码
 */
#define kGetLoginCodeURL @"/api/get_login_code"

/*!
 *  10．手机动态码登录
 */
#define kCodeLoginURL @"/api/code_login"

/*!
 *  11．获取用户个人信息资料
 */
#define kGetUserInfoURL @"/api/get_user_info"

/*!
 *  12．修改用户个人信息资料
 */
#define kSetUserInfoURL @"/api/set_user_info"

/*!
 *  13．修改密码
 */
#define kChangePasswordURL @"/api/change_password"

/*!
 *  14．个人资料中用户上传头像
 */
#define kUploadAvatarsURL @"/api/upload_avatars"

/*!
 *  15．添加设备
 */
#define kAddEqURL @"/api/add_eq"

/*!
 *  16．删除设备
 */
#define kDelEqURL @"/api/del_eq"

/*!
 *  17．修改设备
 */
#define kUpdateEqURL @"/api/update_eq"

/*!
 *  18．设备资料中上传设备头像
 */
#define kUploadEqAvatarURL @"/api/upload_eq_avatar"

/*!
 *  19．用户反馈信息上传
 */
#define kUserFeedbackURL @"/api/user_feedback"

/*!
 *  20．用户反馈图片上传
 */
#define kUserFeedbackImgURL @"/api/user_feedback_img"

/*!
 *  21．分享我的设备
 */
#define kShareEqURL @"/api/share_eq"

/*!
 *  22．查看邀请我的信息
 */
#define kMyInvitationURL @"/api/my_invitation"

/*!
 *  23．同意/拒绝邀请信息
 */
#define kInvitationResponseURL @"/api/invitation_response"

/*!
 *  24．获取用户所有设备信息
 */
#define kMyEquipsURL @"/api/my_equips"

/*!
 *  25．获取指定设备的分享信息
 */
#define kUserSharingsURL @"/api/my_sharings"

/*!
 *  26．删除被分享者与设备的关联
 */
#define kDelSharingsURL @"/api/del_sharings"

/*!
 *  27．获取指定设备最新的N条信息
 */
#define kGetTopCommandsURL @"/api/get_top_commands"

/*!
 *  28．客户端向设备发送指令消息
 */
#define kGetOldCommandsURL @"/api/get_old_commands"

/*!
 *  29．客户端向设备发送指令消息
 */
#define kSendCommandURL @"/api/Send_Command"

/*!
 *  30．同步客户端指令数据
 */
#define kSynClientDataURL @"/api/Syn_client_data"

/*!
 *  31．获取设备列表（临时接口）
 */
#define kGetEquipListURL @"/api/Get_Equip_List"

/*!
 *  32．我的好友列表
 */
#define kGetFriendsListURL @"/api/Get_Friends_List"

/*!
 *  33．搜索好友信息
 */
#define kSeachFriendInfoURL @"/api/Seach_Friend_Info"

/*!
 *  34．添加好友
 */
#define kAddFriendInfoURL @"/api/Add_Friend_Info"

/*!
 *  35．我的设备圈列表
 */
#define kMyCirclesURL @"/api/My_Circles"

/*!
 *  36．添加设备圈
 */
#define kAddCircleURL @"/api/Add_Circle"

/*!
 *  37．修改设备圈
 */
#define kUpdateCircleURL @"/api/Update_Circle"

/*!
 *  38．获取设备圈详细信息
 */
#define kGetCircleDetailURL @"/api/Get_Circle_Detail"

/*!
 *  39．设备圈中发送信息
 */
#define kSendCircleMessagesURL @"/api/Send_Circle_Messages"

/*!
 *  40．获取指定设备圈给定时间之前的N条指令数据（老数据）
 */
#define kGetOldCircleMessagesURL @"/api/Get_Old_CircleMessages"

/*!
 *  41．获取指定设备圈给定时间之后的N条指令数据（新数据）
 */
#define kGetTopCircleMessagesURL @"/api/Get_Top_CircleMessages"

#endif

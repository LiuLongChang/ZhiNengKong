//
//  NSString+WebErrorCode.m
//  ZhiNengKong_APILib
//
//  Created by 宣佚 on 15/5/26.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "NSString+WebErrorCode.h"

@implementation NSString (WebErrorCode)

/**
 *  生成错误码信息（根据协议错误码定义）
 *
 *  @return 错误信息字典集
 */
-(NSDictionary *)createBaseWebErrorCodeAndMessage
{
    NSDictionary *errorCodeAndMessage = @{@"1000":@"成功",\
                                                 @"2001":@"请求缺少必须参数",\
                                                 @"2002":@"Sc或Sv未授权",\
                                                 @"2003":@"手机号被占用",\
                                                 @"2004":@"错误的手机号格式",\
                                                 @"2005":@"发送短信失败",\
                                                 @"2006":@"错误的手机注册验证码",\
                                                 @"2007":@"用户不存在或者密码错误",\
                                                 @"2008":@"您输入的账号不存在",\
                                                 @"2009":@"错误的重置密码验证码",\
                                                 @"2010":@"令牌错误",\
                                                 @"2010.1":@"访问令牌错误",\
                                                 @"2010.2":@"访问令牌过期",\
                                                 @"2010.3":@"刷新令牌错误",\
                                                 @"2011":@"未注册的手机号或登录动态码错误",\
                                                 @"2012":@"用户反馈错误",\
                                                 @"2012.1":@"文字内容超长",\
                                                 @"2012.2":@"图片大小超过范围",\
                                                 @"2012.3":@"图片格式不支持",\
                                                 @"2020":@"密码错误",\
                                                 @"2020.1":@"密码长度必需为6-16位非空字符",\
                                                 @"2020.2":@"新旧密码不能相同",\
                                                 @"2030":@"设备关联错误",\
                                                 @"2030.1":@"您已添加过该设备",\
                                                 @"2030.2":@"设备已被其他人添加",\
                                                 @"2030.3":@"设备不存在",\
                                                 @"2030.4":@"您不是设备的创建者",\
                                                 @"2030.5":@"不存在与设备的关联关系",\
                                                 @"2030.6":@"您名下暂无设备信息",\
                                                 @"2031":@"分享失败",\
                                                 @"2031.1":@"您已向该好友发出过邀请",\
                                                 @"2031.2":@"没有此分享邀请或已失效",\
                                                 @"2031.3":@"不能向自己发出邀请",\
                                                 @"2031.4":@"发送的“拒绝”或“接受”无效"};
    
    
    return errorCodeAndMessage;
}

/*!
 *  通过服务器传过来的ResulteMessage返回错误信息
 *
 *  @return 错误信息
 */
-(NSString *)ErrorCode
{
    NSDictionary *dic = [[NSDictionary alloc] init];
    dic = [self createBaseWebErrorCodeAndMessage];
    
    NSString *errorStr = @"";
    errorStr = dic[self];
    
    return errorStr;
}

@end

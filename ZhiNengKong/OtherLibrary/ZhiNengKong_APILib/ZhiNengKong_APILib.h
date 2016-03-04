//
//  ZhiNengKong_APILib.h
//  ZhiNengKong_APILib
//
//  Created by 宣佚 on 15/5/26.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNK_APIMacro.h"

@interface ZhiNengKong_APILib : NSObject

/*!
 @property
 @abstract 服务器返回的结果码
 */
@property (readwrite, nonatomic, strong) NSString *Result;

/*!
 @property
 @abstract 服务器返回的编码
 */
@property (readwrite, nonatomic, strong) NSString *ResultMessage;

/*!
 @property
 @abstract 服务器返回的具体信息
 */
@property (readwrite, nonatomic, strong) NSString *ReturnValue;

/*!
 @property
 @abstract 系统时间戳
 */
@property (readwrite, nonatomic, assign) long TS;

/*!
 @property
 @abstract 超时时间 不设置时默认10秒
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

/*!
 @property
 @abstract 服务器主地址 不设置时默认为调试服务器
 */
@property (nonatomic, strong) NSString *serviceURL;

/**
 *  取消网络请求
 *
 *  @param serviceURL   服务器地址
 *  @param timeInterval 超时时间
 */
+(void)cancelAllOperations:(NSString *)serviceURL timeInterval:(NSTimeInterval)timeInterval;

/**
 *  发出网络请求
 *
 *  @param postURL      网络请求使用的POST URL地址 （在iAndonCloudMacro.h中配置）
 *  @param HeadInfoType 选择当前使用的HEADINFO版本 当前版本请使用HEADINFO_TYPE_ONE
 *  @param SC           SC
 *  @param SV           SV
 *  @param parameters   协议中的输入内容
 *  @param success      成功返回
 *  @param failure      失败返回
 *  @param SerException 服务器异常返回
 *  @param NetException 网络异常
 */
- (void)globalTimelinePostURL:(NSString *)postURL
                 HeadInfoType:(ENUM_HEADINFO_TYPE)HeadInfoType
                           SC:(NSString *)SC
                           SV:(NSString *)SV
                   parameters:(id)parameters
                      success:(void (^)(ZhiNengKong_APILib *returnInfo))success
                      failure:(void (^)(ZhiNengKong_APILib *returnInfo))failure
                 SerException:(void (^)(ZhiNengKong_APILib *returnInfo))SerException
                 NetException:(void (^)(NSInteger ErrorCode,NSError *ErrorMessage))NetException;

@end

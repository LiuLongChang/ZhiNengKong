//
//  AppDotNetAPIClient.m
//  ZhiNengKong_APILib
//
//  Created by 宣佚 on 15/5/26.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "AppDotNetAPIClient.h"

@implementation AppDotNetAPIClient

/**
 *  设置网络请求
 *
 *  @param timeInterval 超时时间（默认10s）
 *  @param serviceURL   服务器主地址
 *
 *  @return 返回请求
 */
+ (instancetype)sharedClient:(NSTimeInterval)timeInterval serviceURL:(NSString *)serviceURL
{
    static AppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:serviceURL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.securityPolicy.allowInvalidCertificates = YES;
        _sharedClient.requestSerializer.timeoutInterval = timeInterval;
    });
    
    return _sharedClient;
}

@end

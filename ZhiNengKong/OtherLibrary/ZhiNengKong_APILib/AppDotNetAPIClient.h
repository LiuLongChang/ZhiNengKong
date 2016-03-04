//
//  AppDotNetAPIClient.h
//  ZhiNengKong_APILib
//
//  Created by 宣佚 on 15/5/26.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface AppDotNetAPIClient : AFHTTPRequestOperationManager

/**
 *  设置网络请求
 *
 *  @param timeInterval 超时时间（默认10s）
 *  @param serviceURL   服务器主地址
 *
 *  @return 返回请求
 */
+ (instancetype)sharedClient:(NSTimeInterval)timeInterval serviceURL:(NSString *)serviceURL;

@end

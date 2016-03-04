//
//  NSString+WebErrorCode.h
//  ZhiNengKong_APILib
//
//  Created by 宣佚 on 15/5/26.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

//请根据API协议中的错误码定义
/*
 *这部分为示例
 static NSString *k1_1000 = @"1000";
 static NSString *k2_2001 = @"2001";
 static NSString *k3_5000 = @"5000";
*/

@interface NSString (WebErrorCode)

/*!
 *  通过服务器传过来的ResulteMessage返回错误信息
 *
 *  @return 错误信息
 */
-(NSString *)ErrorCode;

@end

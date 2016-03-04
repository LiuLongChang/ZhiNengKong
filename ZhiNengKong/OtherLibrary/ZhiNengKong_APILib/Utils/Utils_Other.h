//
//  ToolFunction.h
//  AndonFunction
//
//  Created by 宣佚 on 14/11/30.
//  Copyright (c) 2014年 刘宣佚. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_OPTIONS(BOOL, ENUM_NETSTATUS_TYPE) {
    
    //未连接
    NETSTATUS_TYPE_NONE    = NO,
    
    //已连接
    NETSTATUS_TYPE_ISREACHABLE = YES
};

@interface Utils_Other : NSObject

/**
 *  获取GUID
 *
 *  @param IsLower 是否为小写
 *
 *  @return GUID
 */
+(NSString *)GetGUID_IsLower:(BOOL)IsLower;



/**
 *  对字符串进行MD5加密
 *
 *  @param topInfo 需要加密的文字
 *  @param IsLower 是否为小写
 *
 *  @return 加密后的内容
 */
+(NSString *)MD5:(NSString *)topInfo IsLower:(BOOL)IsLower;



/**
 *  解QueryString成NSDictionary
 *
 *  @param queryString queryString
 *
 *  @return 解成的NSDictionary
 */
+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString;

/**
 *  字典变成QueryString
 *
 *  @param topInfo 数据字典
 *
 *  @return QueryString
 */
+ (NSString *)queryStringValue:(NSDictionary *)topInfo;

/**
 *  URL Encoded
 *
 *  @param URLString URLString
 *
 *  @return Encoded String
 */
+ (NSString *)URLEncodedString:(NSString *)URLString;

/**
 *  URL Decoded
 *
 *  @param URLString URLString
 *
 *  @return Decoded String
 */
+ (NSString *)URLDecodedString:(NSString *)URLString;

/**
 *  获取网络状态
 *
 *  @return ENUM_NETSTATUS_TYPE 连接状态
 */
+(ENUM_NETSTATUS_TYPE)getNetWorkIsExistence;

@end

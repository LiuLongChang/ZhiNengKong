//
//  ToolFunction.m
//  AndonFunction
//
//  Created by 宣佚 on 14/11/30.
//  Copyright (c) 2014年 刘宣佚. All rights reserved.
//

#import "Utils_Other.h"
#import <CommonCrypto/CommonDigest.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation Utils_Other

/**
 *  获取GUID
 *
 *  @param IsLower 是否为小写
 *
 *  @return GUID
 */
+(NSString *)GetGUID_IsLower:(BOOL)IsLower
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    NSString *str = [uuidString stringByReplacingOccurrencesOfString:@"-"
                                                          withString:@""];
    NSString *lowerStr = @"";
    if (IsLower) {
        lowerStr = [str lowercaseString];
    } else {
        lowerStr = [str uppercaseString];
    }
    return lowerStr;
}

/**
 *  对字符串进行MD5加密
 *
 *  @param topInfo 需要加密的文字
 *  @param IsLower 是否为小写
 *
 *  @return 加密后的内容
 */
+(NSString *)MD5:(NSString *)topInfo IsLower:(BOOL)IsLower
{
    NSData *data = [topInfo dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
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

/**
 *  解QueryString成NSDictionary
 *
 *  @param queryString queryString
 *
 *  @return 解成的NSDictionary
 */
+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *pairs = [queryString componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs)
    {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if (elements.count == 2)
        {
            NSString *key = elements[0];
            NSString *value = elements[1];
            NSString *decodedKey = [self URLDecodedString:key];
            NSString *decodedValue = [self URLDecodedString:value];
            
            if (![key isEqualToString:decodedKey])
                key = decodedKey;
            
            if (![value isEqualToString:decodedValue])
                value = decodedValue;
            
            [dictionary setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

/**
 *  字典变成QueryString
 *
 *  @param topInfo 数据字典
 *
 *  @return QueryString
 */
+ (NSString *)queryStringValue:(NSDictionary *)topInfo {
    
    NSMutableArray *pairs = [NSMutableArray array];
    for (NSString *key in [topInfo keyEnumerator])
    {
        id value = [topInfo objectForKey:key];
        NSString *escapedValue = [self URLEncodedString:value];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escapedValue]];
    }
    return [pairs componentsJoinedByString:@"&"];
}

/**
 *  URL Encoded
 *
 *  @param URLString URLString
 *
 *  @return Encoded String
 */
+ (NSString *)URLEncodedString:(id)URLString {
    __autoreleasing NSString *encodedString;
    NSString *originalString = (NSString *)URLString;
    encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                          NULL,
                                                                                          (__bridge CFStringRef)originalString,
                                                                                          NULL,
                                                                                          (CFStringRef)@":!*();@/&?#[]+$,='%’\"",
                                                                                          kCFStringEncodingUTF8
                                                                                          );
    return encodedString;
}

/**
 *  URL Decoded
 *
 *  @param URLString URLString
 *
 *  @return Decoded String
 */
+ (NSString *)URLDecodedString:(id)URLString {
    __autoreleasing NSString *decodedString;
    NSString *originalString = (NSString *)URLString;
    decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                                                          NULL,
                                                                                                          (__bridge CFStringRef)originalString,
                                                                                                          CFSTR(""),
                                                                                                          kCFStringEncodingUTF8
                                                                                                          );
    return decodedString;
}

/**
 *  获取网络状态
 *
 *  @return ENUM_NETSTATUS_TYPE 连接状态
 */
+(ENUM_NETSTATUS_TYPE)getNetWorkIsExistence{
    
    struct sockaddr_in zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    
    zeroAddress.sin_len = sizeof(zeroAddress);
    
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    
    CFRelease(defaultRouteReachability);
    
    
    if (!didRetrieveFlags){
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    return (isReachable && !needsConnection) ? NETSTATUS_TYPE_ISREACHABLE : NETSTATUS_TYPE_NONE;
}

@end

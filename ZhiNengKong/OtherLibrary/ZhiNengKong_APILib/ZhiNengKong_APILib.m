//
//  ZhiNengKong_APILib.m
//  ZhiNengKong_APILib
//
//  Created by 宣佚 on 15/5/26.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "ZhiNengKong_APILib.h"
#import "AppDotNetAPIClient.h"
#import "HeadInfo.h"
#import "ZNK_APIMacro_URL.h"
#import "PostRefreshTokenModel.h"
#import "RefreshTokenModel.h"
#import "Utils_UserDefaultInfo.h"

NSString *const kiAndon_CloudResult = @"Result";
NSString *const kiAndon_CloudResultMessage = @"ResultMessage";
NSString *const kiAndon_CloudReturnValue = @"ReturnValue";
NSString *const kiAndon_CloudTS = @"TS";

@interface ZhiNengKong_APILib ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end


@implementation NSString (NSString_Extended)

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    unsigned long sourceLen = strlen((const char *)source);
    for (unsigned long i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}
@end

@implementation ZhiNengKong_APILib

@synthesize Result = _Result;
@synthesize ResultMessage = _ResultMessage;
@synthesize ReturnValue = _ReturnValue;
@synthesize TS = _TS;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.Result = [self objectOrNilForKey:kiAndon_CloudResult fromDictionary:dict];
        self.ResultMessage = [self objectOrNilForKey:kiAndon_CloudResultMessage fromDictionary:dict];
        self.ReturnValue = [self objectOrNilForKey:kiAndon_CloudReturnValue fromDictionary:dict];
        self.TS = [[self objectOrNilForKey:kiAndon_CloudTS fromDictionary:dict] longValue];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.Result forKey:kiAndon_CloudResult];
    [mutableDict setValue:self.ResultMessage forKey:kiAndon_CloudResultMessage];
    [mutableDict setValue:self.ReturnValue forKey:kiAndon_CloudReturnValue];
    [mutableDict setValue:[NSNumber numberWithLong:self.TS] forKey:kiAndon_CloudTS];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.Result = [aDecoder decodeObjectForKey:kiAndon_CloudResult];
    self.ResultMessage = [aDecoder decodeObjectForKey:kiAndon_CloudResultMessage];
    self.ReturnValue = [aDecoder decodeObjectForKey:kiAndon_CloudReturnValue];
    self.TS = [aDecoder decodeIntForKey:kiAndon_CloudTS];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_Result forKey:kiAndon_CloudResult];
    [aCoder encodeObject:_ResultMessage forKey:kiAndon_CloudResultMessage];
    [aCoder encodeObject:_ReturnValue forKey:kiAndon_CloudReturnValue];
    [aCoder encodeInteger:_TS forKey:kiAndon_CloudTS];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZhiNengKong_APILib *copy = [[ZhiNengKong_APILib alloc] init];
    
    if (copy) {
        
        copy.Result = [self.Result copyWithZone:zone];
        copy.ResultMessage = [self.ResultMessage copyWithZone:zone];
        copy.ReturnValue = [self.ReturnValue copyWithZone:zone];
        copy.TS = self.TS;
    }
    
    return copy;
}

+(void)cancelAllOperations:(NSString *)serviceURL timeInterval:(NSTimeInterval)timeInterval
{
    AFHTTPRequestOperationManager *manager = [AppDotNetAPIClient sharedClient:timeInterval serviceURL:serviceURL];
    [manager.operationQueue cancelAllOperations];
}

- (void)globalTimelinePostURL:(NSString *)postURL
                 HeadInfoType:(ENUM_HEADINFO_TYPE)HeadInfoType
                           SC:(NSString *)SC
                           SV:(NSString *)SV
                   parameters:(id)parameters
                      success:(void (^)(ZhiNengKong_APILib *returnInfo))success
                      failure:(void (^)(ZhiNengKong_APILib *returnInfo))failure
                 SerException:(void (^)(ZhiNengKong_APILib *returnInfo))SerException
                 NetException:(void (^)(NSInteger ErrorCode,NSError *ErrorMessage))NetException
{
    NSString *URLString = @"";
    switch (HeadInfoType) {
        case HEADINFO_TYPE_ONE:
            URLString = [NSString stringWithFormat:@"%@?%@",postURL,[HeadInfo getHeadInfo]];
            break;
        case HEADINFO_TYPE_NONE:
            URLString = postURL;
            break;
        default:
            URLString = [NSString stringWithFormat:@"%@?%@",postURL,[HeadInfo getHeadInfo]];
            break;
    }
    
    NSMutableDictionary *temcontentDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [temcontentDic setObject:SC forKey:@"SC"];
    [temcontentDic setObject:SV forKey:@"SV"];
    
    NSData *contentJsonData = [NSJSONSerialization dataWithJSONObject:temcontentDic options:kNilOptions error:nil];
    NSString *contentString = [[NSString alloc] initWithData:contentJsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *contentDic = @{@"content": contentString};
    
    if (_timeInterval == 0) {
        _timeInterval = 10;
    }
    
    if (_serviceURL == nil || [_serviceURL isEqualToString:@""]) {
        _serviceURL = kSDebugBaseURL;
    }
    
//    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
//    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    view.center = CGPointMake(mainWindow.bounds.size.width /2.0, mainWindow.bounds.size.height/2.0);
//    [view startAnimating];
//    
//    UIView *maskView = [[UIView alloc] initWithFrame:mainWindow.frame];
//    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
//    [maskView addSubview:view];
//    [mainWindow addSubview:maskView];
    
    [[AppDotNetAPIClient sharedClient:_timeInterval serviceURL:_serviceURL] POST:URLString parameters:contentDic success:^(AFHTTPRequestOperation *__unused operation, id JSON) {
        ZhiNengKong_APILib *cloud = [ZhiNengKong_APILib modelObjectWithDictionary:JSON];
//        [maskView removeFromSuperview];
        
        //令牌错误，刷新令牌
        if ([@"2010.1" isEqualToString:cloud.ResultMessage] || [@"2010.2" isEqualToString:cloud.ResultMessage]) {
            
            PostRefreshTokenModel *model = [[PostRefreshTokenModel alloc] init];
            model.uN = [Utils_UserDefaultInfo GetUserIdentifer:nil];
            model.refreshToken = [Utils_UserDefaultInfo GetUserRefreshToken:nil];
            
            NSDictionary *topInfo = [model dictionaryRepresentation];
            
            [[AppDotNetAPIClient sharedClient:_timeInterval serviceURL:_serviceURL] POST:kRefreshTokenURL parameters:topInfo success:^(AFHTTPRequestOperation *__unused operation, id responseObject) {
                ZhiNengKong_APILib *apiCloud = [ZhiNengKong_APILib modelObjectWithDictionary:responseObject];
                
                //刷新令牌错误
                if ([@"2010.3" isEqualToString:apiCloud.ResultMessage]) {
                    //刷新令牌失败，跳转到登录
                    [Utils_UserDefaultInfo SetUserDeviceToken:nil];
                    [Utils_UserDefaultInfo SetUserIdentifer:nil];
                    
                    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    UIViewController *vc =[storybord instantiateViewControllerWithIdentifier:@"login"];
                    [[UIApplication sharedApplication] keyWindow].rootViewController = vc;
                }else{
                    //刷新成功，重新请求
                    NSDictionary *dic = (NSDictionary *)apiCloud.ReturnValue;
                    RefreshTokenModel *resultModel = [RefreshTokenModel modelObjectWithDictionary:dic];
                    
                    [Utils_UserDefaultInfo SetUserAccessKey:resultModel.token.accessToken];
                    [Utils_UserDefaultInfo SetUserRefreshToken:resultModel.token.refreshToken];
                    
                    [self globalTimelinePostURL:postURL
                                   HeadInfoType:HeadInfoType
                                             SC:SC
                                             SV:SV
                                     parameters:parameters
                                        success:success
                                        failure:failure
                                   SerException:SerException
                                   NetException:NetException];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //刷新令牌失败，跳转到登录
                [Utils_UserDefaultInfo SetUserDeviceToken:nil];
                [Utils_UserDefaultInfo SetUserIdentifer:nil];
                
                UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                UIViewController *vc =[storybord instantiateViewControllerWithIdentifier:@"login"];
                [[UIApplication sharedApplication] keyWindow].rootViewController = vc;
            }];
        }else{
            switch (cloud.Result.intValue) {
                case 1:
                    success(cloud);
                    break;
                case 2:
                    failure(cloud);
                    break;
                case 3:
                    SerException(cloud);
                    break;
                default:
                    failure(cloud);
                    break;
        }
        
        
    }
        
    } failure:^(AFHTTPRequestOperation *__unused operation, NSError *error) {
//        [maskView removeFromSuperview];
        NetException(error.code,error);
    }];
}

@end

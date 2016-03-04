//
//  ZNK_APIMacro.h
//  ZhiNengKong_APILib
//
//  Created by 宣佚 on 15/5/26.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#ifndef ZhiNengKong_APILib_ZNK_APIMacro_h
#define ZhiNengKong_APILib_ZNK_APIMacro_h

#import "ZNK_APIMacro_URL.h"
#import "ZNK_APIMacro_SV.h"

/**
 *  选择使用第几版主协议HeadInfo
 */
typedef NS_OPTIONS(NSUInteger, ENUM_HEADINFO_TYPE){
    /**
     *  不使用HeadInfo
     */
    HEADINFO_TYPE_NONE = 1,
    /**
     *  使用第一版
     */
    HEADINFO_TYPE_ONE  = 2,
};


static NSString *serviceURL = kSDebugBaseURL;

#endif

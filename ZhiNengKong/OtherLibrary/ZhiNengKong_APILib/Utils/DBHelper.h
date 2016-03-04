//
//  DBHelper.h
//  TomatoShop
//
//  Created by 高大为 on 14-6-26.
//  Copyright (c) 2014年 gaodawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHelper : NSObject

//创建数据库
+(void)createDatabase;

+(NSMutableArray *)getBasketList;

+(void)setCircleMessageWithMsgId:(NSString *)msgId Direction:(int)direction CircleId:(NSString *)circleId UserId:(NSString *)userId EuipId:(NSString *)equipId Text:(NSString *)text Time:(long long)time;

+(void)setEquipMessageWithMsgId:(NSString *)msgId Direction:(int)direction UserId:(int)userId EuipId:(NSString *)equipId Text:(NSString *)text Time:(long long)time;

+(NSMutableArray *)getCircleMessagesWithCircleId:(NSString *)circleId;

+(NSMutableArray *)getEQuipMessagesWithEquipId:(NSString *)equipId;

@end

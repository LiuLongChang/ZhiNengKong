//
//  DBHelper.m
//  TomatoShop
//
//  Created by 高大为 on 14-6-26.
//  Copyright (c) 2014年 gaodawei. All rights reserved.
//

#import "DBHelper.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Command.h"
#import "Message.h"

@implementation DBHelper

//获取数据库路径
+(NSString *)dataFilePath
{
    @synchronized(self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory , NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        
        NSString *dbPath = [docDir stringByAppendingPathComponent:@"db.sqlite"];
        
        NSLog(@"DB_PATH = %@",dbPath);
        
        return [docDir stringByAppendingPathComponent:@"db.sqlite"];
    }
}



//创建数据库
+(void)createDatabase
{
    NSString *dataFilePath = [DBHelper dataFilePath];
    NSURL *dataFileUrl = [NSURL URLWithString:dataFilePath];
    
    NSError*error =nil;
    BOOL success = [dataFileUrl setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];

    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [dataFileUrl lastPathComponent], error);
    }
    
    FMDatabase *db = [FMDatabase databaseWithPath:[DBHelper dataFilePath]] ;
    
    if (![db open]) {
        NSLog(@"[ERROR]:%@",@"Could not open db.");
    }
    
    NSString *sql =@"CREATE TABLE IF NOT EXISTS circle_messages (id TEXT PRIMARY KEY NOT NULL,circleId TEXT NOT NULL,userId TEXT,equipId TEXT,direction INT,content TEXT,sendTime TIMESTAMP NOT NULL)";
    
    if (![db executeUpdate:sql]) {
        NSLog(@"[ERROR]:%@",[db lastErrorMessage]);
    }
    
    sql = @"CREATE TABLE IF NOT EXISTS equip_messages (id TEXT PRIMARY KEY NOT NULL,userId INT,equipId TEXT NOT NULL,direction INT NOT NULL,content TEXT,sendTime TIMESTAMP NOT NULL)";
    
    if (![db executeUpdate:sql]) {
        NSLog(@"[ERROR]:%@",[db lastErrorMessage]);
    }
    
    [db close];
}

+(void)setCircleMessageWithMsgId:(NSString *)msgId Direction:(int)direction CircleId:(NSString *)circleId UserId:(NSString *)userId EuipId:(NSString *)equipId Text:(NSString *)text Time:(long long)time{
    FMDatabase *db = [FMDatabase databaseWithPath:[self dataFilePath]] ;
    
    if (![db open]) {
        NSLog(@"[ERROR]:%@",@"Could not open db.");
    }
    
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO circle_messages(id,circleId,userId,equipId,direction,content,sendTime) VALUES ('%@','%@','%@','%@',%d,'%@',%lld)",msgId,circleId,userId,equipId,direction,text,time];
    
    if (![db executeUpdate:sql]) {
        NSLog(@"[ERROR]:%@",[db lastErrorMessage]);
    }
    
    [db close];
}

+(void)setEquipMessageWithMsgId:(NSString *)msgId Direction:(int)direction UserId:(int)userId EuipId:(NSString *)equipId Text:(NSString *)text Time:(long long)time{
    FMDatabase *db = [FMDatabase databaseWithPath:[self dataFilePath]] ;
    
    if (![db open]) {
        NSLog(@"[ERROR]:%@",@"Could not open db.");
    }
    
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO equip_messages(id,userId,equipId,direction,content,sendTime) VALUES ('%@',%d,'%@',%d,'%@',%lld)",msgId,userId,equipId,direction,text,time];
    
    if (![db executeUpdate:sql]) {
        NSLog(@"[ERROR]:%@",[db lastErrorMessage]);
    }
    
    [db close];
}

+(NSMutableArray *)getCircleMessagesWithCircleId:(NSString *)circleId{
    NSMutableArray *queryResult = [NSMutableArray arrayWithCapacity:10];
    FMDatabase *db = [FMDatabase databaseWithPath:[self dataFilePath]] ;
    
    
    if (![db open]) {
        [db close];
        NSLog(@"[ERROR]:%@",@"Could not open db.");
        return queryResult;
    }
    
    NSString *sql =@"SELECT id,userId,equipId,direction,content,sendTime FROM circle_messages";
    
    sql = [sql stringByAppendingFormat:@" WHERE circleId = '%@' ORDER BY sendTime",circleId];
    
    FMResultSet *rs = [db executeQuery:sql];
    
    if (rs == nil) {
        [db close];
        return queryResult;
    }
    
    while ([rs next]) {
        Message *msg = [[Message alloc] init];
        msg.iD = [rs stringForColumnIndex:0];
        msg.userID = [rs stringForColumnIndex:1];
        msg.equipID = [rs stringForColumnIndex:2];
        msg.direction = [NSNumber numberWithInt:[rs intForColumnIndex:3]];
        msg.text = [rs stringForColumnIndex:4];
        msg.time = [NSNumber numberWithLongLong:[rs longLongIntForColumnIndex:5]];
        [queryResult addObject:msg];
    }
    
    [db close];
    return queryResult;
}

+(NSMutableArray *)getEQuipMessagesWithEquipId:(NSString *)equipId{
    NSMutableArray *queryResult = [NSMutableArray arrayWithCapacity:10];
    FMDatabase *db = [FMDatabase databaseWithPath:[self dataFilePath]] ;
    
    if (![db open]) {
        [db close];
        NSLog(@"[ERROR]:%@",@"Could not open db.");
        return queryResult;
    }
    
    NSString *sql =@"SELECT id,userId,direction,content,sendTime FROM equip_messages";
    
    sql = [sql stringByAppendingFormat:@" WHERE equipId = '%@' ORDER BY sendTime",equipId];
    
    FMResultSet *rs = [db executeQuery:sql];
    
    if (rs == nil) {
        [db close];
        return queryResult;
    }
    
    while ([rs next]) {
        Command *cmd = [[Command alloc] init];
        cmd.iD = [rs stringForColumnIndex:0];
        cmd.userID = [NSNumber numberWithInt:[rs intForColumnIndex:1]];
        cmd.direction = [NSNumber numberWithInt:[rs intForColumnIndex:2]];
        cmd.text = [rs stringForColumnIndex:3];
        cmd.time = [NSNumber numberWithLongLong:[rs longLongIntForColumnIndex:4]];
        [queryResult addObject:cmd];
    }
    
    [db close];
    return queryResult;
}

@end

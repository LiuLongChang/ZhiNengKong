//
//  Model/GetTopCommandsModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "GetTopCommandsModel.h"

NSString *const kGetTopCommandsModelRecentTS = @"RecentTS";
NSString *const kGetTopCommandsModelOldTS = @"OldTS";
NSString *const kGetTopCommandsModelLeftNumber = @"LeftNumber";
NSString *const kGetTopCommandsModelCommands = @"Commands";
NSString *const kGetTopCommandsModelUsers = @"Users";

@interface GetTopCommandsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetTopCommandsModel

@synthesize recentTS = _recentTS;
@synthesize oldTS = _oldTS;
@synthesize leftNumber = _leftNumber;
@synthesize commands = _commands;
@synthesize users = _users;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        
        long long timestamp1 = [[self objectOrNilForKey:kGetTopCommandsModelRecentTS fromDictionary:dict] longLongValue];
        float floatValue1 = timestamp1 /1000.0f;
        self.recentTS = [NSNumber numberWithFloat:floatValue1];
        
        long long timestamp2 = [[self objectOrNilForKey:kGetTopCommandsModelOldTS fromDictionary:dict] longLongValue];
        float floatValue2 = timestamp2 /1000.0f;
        self.oldTS = [NSNumber numberWithFloat:floatValue2];
        
        self.leftNumber = [self objectOrNilForKey:kGetTopCommandsModelLeftNumber fromDictionary:dict];
        self.commands = [self objectOrNilForKey:kGetTopCommandsModelCommands fromDictionary:dict];
        self.users = [self objectOrNilForKey:kGetTopCommandsModelUsers fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.recentTS forKey:kGetTopCommandsModelRecentTS];
	[mutableDict setValue:self.oldTS forKey:kGetTopCommandsModelOldTS];
	[mutableDict setValue:self.leftNumber forKey:kGetTopCommandsModelLeftNumber];
	[mutableDict setValue:self.commands forKey:kGetTopCommandsModelCommands];
	[mutableDict setValue:self.users forKey:kGetTopCommandsModelUsers];
    
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

	self.recentTS = [aDecoder decodeObjectForKey:kGetTopCommandsModelRecentTS];
	self.oldTS = [aDecoder decodeObjectForKey:kGetTopCommandsModelOldTS];
	self.leftNumber = [aDecoder decodeObjectForKey:kGetTopCommandsModelLeftNumber];
	self.commands = [aDecoder decodeObjectForKey:kGetTopCommandsModelCommands];
	self.users = [aDecoder decodeObjectForKey:kGetTopCommandsModelUsers];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_recentTS forKey:kGetTopCommandsModelRecentTS];
	[aCoder encodeObject:_oldTS forKey:kGetTopCommandsModelOldTS];
	[aCoder encodeObject:_leftNumber forKey:kGetTopCommandsModelLeftNumber];
	[aCoder encodeObject:_commands forKey:kGetTopCommandsModelCommands];
	[aCoder encodeObject:_users forKey:kGetTopCommandsModelUsers];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetTopCommandsModel *copy = [[GetTopCommandsModel alloc] init];
    
    if (copy) {
        
		copy.recentTS = [self.recentTS copyWithZone:zone];
		copy.oldTS = [self.oldTS copyWithZone:zone];
		copy.leftNumber = [self.leftNumber copyWithZone:zone];
		copy.commands = [self.commands copyWithZone:zone];
		copy.users = [self.users copyWithZone:zone];
    }
    
    return copy;
}


@end
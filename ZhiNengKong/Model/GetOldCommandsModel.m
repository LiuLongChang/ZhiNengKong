//
//  Model/GetOldCommandsModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "GetOldCommandsModel.h"

NSString *const kGetOldCommandsModelOldTS = @"OldTS";
NSString *const kGetOldCommandsModelCommands = @"Commands";
NSString *const kGetOldCommandsModelUsers = @"Users";

@interface GetOldCommandsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetOldCommandsModel

@synthesize oldTS = _oldTS;
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
        long long timestamp = [[self objectOrNilForKey:kGetOldCommandsModelOldTS fromDictionary:dict] longLongValue];
        float floatValue = timestamp /1000.0f;
        self.oldTS = [NSNumber numberWithFloat:floatValue];
        self.commands = [self objectOrNilForKey:kGetOldCommandsModelCommands fromDictionary:dict];
        self.users = [self objectOrNilForKey:kGetOldCommandsModelUsers fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.oldTS forKey:kGetOldCommandsModelOldTS];
	[mutableDict setValue:self.commands forKey:kGetOldCommandsModelCommands];
	[mutableDict setValue:self.users forKey:kGetOldCommandsModelUsers];
    
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

	self.oldTS = [aDecoder decodeObjectForKey:kGetOldCommandsModelOldTS];
	self.commands = [aDecoder decodeObjectForKey:kGetOldCommandsModelCommands];
	self.users = [aDecoder decodeObjectForKey:kGetOldCommandsModelUsers];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_oldTS forKey:kGetOldCommandsModelOldTS];
	[aCoder encodeObject:_commands forKey:kGetOldCommandsModelCommands];
	[aCoder encodeObject:_users forKey:kGetOldCommandsModelUsers];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetOldCommandsModel *copy = [[GetOldCommandsModel alloc] init];
    
    if (copy) {
        
		copy.oldTS = [self.oldTS copyWithZone:zone];
		copy.commands = [self.commands copyWithZone:zone];
		copy.users = [self.users copyWithZone:zone];
    }
    
    return copy;
}


@end
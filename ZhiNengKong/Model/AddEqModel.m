//
//  Model/AddEqModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "AddEqModel.h"

NSString *const kAddEqModelEqID = @"EqID";
NSString *const kAddEqModelName = @"Name";
NSString *const kAddEqModelAlias = @"Alias";
NSString *const kAddEqModelLastMessage = @"LastMessage";

@interface AddEqModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AddEqModel

@synthesize eqID = _eqID;
@synthesize name = _name;
@synthesize alias = _alias;
@synthesize lastMessage = _lastMessage;

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
        self.eqID = [self objectOrNilForKey:kAddEqModelEqID fromDictionary:dict];
        self.name = [self objectOrNilForKey:kAddEqModelName fromDictionary:dict];
        self.alias = [self objectOrNilForKey:kAddEqModelAlias fromDictionary:dict];
        self.lastMessage = [[LastMessage alloc] initWithDictionary:[self objectOrNilForKey:kAddEqModelLastMessage fromDictionary:dict]];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.eqID forKey:kAddEqModelEqID];
	[mutableDict setValue:self.name forKey:kAddEqModelName];
	[mutableDict setValue:self.alias forKey:kAddEqModelAlias];
	[mutableDict setValue:self.lastMessage forKey:kAddEqModelLastMessage];
    
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

	self.eqID = [aDecoder decodeObjectForKey:kAddEqModelEqID];
	self.name = [aDecoder decodeObjectForKey:kAddEqModelName];
	self.alias = [aDecoder decodeObjectForKey:kAddEqModelAlias];
	self.lastMessage = [aDecoder decodeObjectForKey:kAddEqModelLastMessage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_eqID forKey:kAddEqModelEqID];
	[aCoder encodeObject:_name forKey:kAddEqModelName];
	[aCoder encodeObject:_alias forKey:kAddEqModelAlias];
	[aCoder encodeObject:_lastMessage forKey:kAddEqModelLastMessage];
}

- (id)copyWithZone:(NSZone *)zone
{
    AddEqModel *copy = [[AddEqModel alloc] init];
    
    if (copy) {
        
		copy.eqID = [self.eqID copyWithZone:zone];
		copy.name = [self.name copyWithZone:zone];
		copy.alias = [self.alias copyWithZone:zone];
		copy.lastMessage = [self.lastMessage copyWithZone:zone];
    }
    
    return copy;
}


@end
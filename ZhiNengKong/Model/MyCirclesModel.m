//
//  Model/MyCirclesModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "MyCirclesModel.h"

NSString *const kMyCirclesModelName = @"Name";
NSString *const kMyCirclesModelAvatar = @"Avatar";
NSString *const kMyCirclesModelCircleID = @"CircleID";
NSString *const kMyCirclesModelIsCreater = @"IsCreater";

@interface MyCirclesModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MyCirclesModel

@synthesize name = _name;
@synthesize avatar = _avatar;
@synthesize circleID = _circleID;
@synthesize isCreater = _isCreater;

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
        self.name = [self objectOrNilForKey:kMyCirclesModelName fromDictionary:dict];
        self.avatar = [self objectOrNilForKey:kMyCirclesModelAvatar fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kMyCirclesModelCircleID fromDictionary:dict];
        self.isCreater = [self objectOrNilForKey:kMyCirclesModelIsCreater fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.name forKey:kMyCirclesModelName];
	[mutableDict setValue:self.avatar forKey:kMyCirclesModelAvatar];
	[mutableDict setValue:self.circleID forKey:kMyCirclesModelCircleID];
	[mutableDict setValue:self.isCreater forKey:kMyCirclesModelIsCreater];
    
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

	self.name = [aDecoder decodeObjectForKey:kMyCirclesModelName];
	self.avatar = [aDecoder decodeObjectForKey:kMyCirclesModelAvatar];
	self.circleID = [aDecoder decodeObjectForKey:kMyCirclesModelCircleID];
	self.isCreater = [aDecoder decodeObjectForKey:kMyCirclesModelIsCreater];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_name forKey:kMyCirclesModelName];
	[aCoder encodeObject:_avatar forKey:kMyCirclesModelAvatar];
	[aCoder encodeObject:_circleID forKey:kMyCirclesModelCircleID];
	[aCoder encodeObject:_isCreater forKey:kMyCirclesModelIsCreater];
}

- (id)copyWithZone:(NSZone *)zone
{
    MyCirclesModel *copy = [[MyCirclesModel alloc] init];
    
    if (copy) {
        
		copy.name = [self.name copyWithZone:zone];
		copy.avatar = [self.avatar copyWithZone:zone];
		copy.circleID = [self.circleID copyWithZone:zone];
		copy.isCreater = [self.isCreater copyWithZone:zone];
    }
    
    return copy;
}


@end
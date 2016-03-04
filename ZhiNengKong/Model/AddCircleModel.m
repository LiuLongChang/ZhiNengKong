//
//  Model/AddCircleModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "AddCircleModel.h"

NSString *const kAddCircleModelIsSuccess = @"IsSuccess";
NSString *const kAddCircleModelErrors = @"Errors";

@interface AddCircleModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AddCircleModel

@synthesize isSuccess = _isSuccess;
@synthesize errors = _errors;

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
        self.isSuccess = [self objectOrNilForKey:kAddCircleModelIsSuccess fromDictionary:dict];
        self.errors = [self objectOrNilForKey:kAddCircleModelErrors fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.isSuccess forKey:kAddCircleModelIsSuccess];
	[mutableDict setValue:self.errors forKey:kAddCircleModelErrors];
    
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

	self.isSuccess = [aDecoder decodeObjectForKey:kAddCircleModelIsSuccess];
	self.errors = [aDecoder decodeObjectForKey:kAddCircleModelErrors];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_isSuccess forKey:kAddCircleModelIsSuccess];
	[aCoder encodeObject:_errors forKey:kAddCircleModelErrors];
}

- (id)copyWithZone:(NSZone *)zone
{
    AddCircleModel *copy = [[AddCircleModel alloc] init];
    
    if (copy) {
        
		copy.isSuccess = [self.isSuccess copyWithZone:zone];
		copy.errors = [self.errors copyWithZone:zone];
    }
    
    return copy;
}


@end
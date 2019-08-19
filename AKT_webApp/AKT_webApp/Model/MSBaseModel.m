//
//  MSBaseModel.m
//  MisaBaseDemo
//
//  Created by stone on 2018/10/6.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import "MSBaseModel.h"

@implementation MSBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

//+ (NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{@"unreadMessageCount":@"new_message"
//             };
//}

//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
//{
//    if ([self isEmptyTest:oldValue]) {
//        return  @"";
//    }
//    return oldValue;
//}
//
//- (BOOL)isEmptyTest:(id)object
//{
//    if (!object)
//    {
//        return YES;
//    }
//    return NO;
//}

+ (instancetype)initWithKeyValue:(NSDictionary *)kv{
    return [[self class] mj_objectWithKeyValues:kv];
}

+ (NSArray *)objectsWithKeyValues:(NSArray *)kvs{
    return [[self class] mj_objectArrayWithKeyValuesArray:kvs];
}

- (NSMutableDictionary *)toDictionary{
    return [self mj_keyValues];
}

@end

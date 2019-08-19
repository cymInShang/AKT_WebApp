//
//  MSBaseModel.h
//  MisaBaseDemo
//
//  Created by stone on 2018/10/6.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSBaseModel : NSObject
@property (nonatomic, copy) NSNumber *ID;


+ (instancetype)initWithKeyValue:(NSDictionary *)kv;
+ (NSArray *)objectsWithKeyValues:(NSArray *)kvs;
- (NSMutableDictionary *)toDictionary;
@end

NS_ASSUME_NONNULL_END

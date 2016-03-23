//
//  WeakSet.h
//  IteratorPattern
//
//  Created by YouXianMing on 15/9/12.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakSet : NSObject

/**
 *  元素个数
 */
@property (readonly)            NSUInteger  count;

/**
 *  所有对象
 */
@property (readonly, copy)      NSArray    *allObjects;

/**
 *  获取一个对象
 */
@property (readonly, nonatomic) id          anyObject;

/**
 *  获取集合
 */
@property (readonly, copy)      NSSet      *setRepresentation;

- (id)member:(id)object;
- (NSEnumerator *)objectEnumerator;
- (void)addObject:(id)object;
- (void)removeObject:(id)object;
- (void)removeAllObjects;
- (BOOL)containsObject:(id)anObject;

@end

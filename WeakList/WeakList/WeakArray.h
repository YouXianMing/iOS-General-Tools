//
//  WeakArray.h
//  IteratorPattern
//
//  Created by YouXianMing on 15/9/12.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakArray : NSObject

@property (readonly, copy) NSArray    *allObjects;
@property (readonly)       NSUInteger  count;

- (id)objectAtIndex:(NSUInteger)index;
- (void)addObject:(id)object;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withPointer:(id)object;
- (void)compact;

@end

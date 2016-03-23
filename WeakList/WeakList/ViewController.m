//
//  ViewController.m
//  IteratorPattern
//
//  Created by YouXianMing on 15/9/12.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "ViewController.h"

#import "Model.h"

#import "WeakArray.h"
#import "WeakDictionary.h"
#import "WeakSet.h"

@interface ViewController ()

@property (nonatomic, strong) Model           *model;

@property (nonatomic, strong) WeakArray       *weakArray;
@property (nonatomic, strong) WeakDictionary  *weakDictionary;
@property (nonatomic, strong) WeakSet         *weakSet;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.model = [[Model alloc] init];
    
    [self testWeakArray];
    
    [self testWeakDictionary];
    
    [self testWeakSet];
}

- (void)testWeakArray {
    
    self.weakArray = [[WeakArray alloc] init];
    
    [self.weakArray addObject:[Model new]];
    [self.weakArray addObject:self.model];
    
    NSLog(@"count = %lu", (unsigned long)self.weakArray.count);
    NSLog(@"%@", self.weakArray);
}

- (void)testWeakDictionary {
    
    self.weakDictionary = [[WeakDictionary alloc] init];
    
    [self.weakDictionary setObject:[Model new] forKey:@"Model"];
    [self.weakDictionary setObject:self.model forKey:@"flagDictionary"];
    
    NSLog(@"count = %lu", (unsigned long)self.weakDictionary.count);
    NSLog(@"%@", self.weakDictionary);
}

- (void)testWeakSet {
    
    self.weakSet = [[WeakSet alloc] init];
    [self.weakSet addObject:[Model new]];
    [self.weakSet addObject:self.model];
    
    NSLog(@"count = %lu", (unsigned long)self.weakSet.count);
    NSLog(@"%@", self.weakSet);
}

@end

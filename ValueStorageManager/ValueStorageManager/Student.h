//
//  Student.h
//  ValueStorageManager
//
//  Created by YouXianMing on 16/3/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BaseValueStorageManager.h"

@interface Student : BaseValueStorageManager

@property (nonatomic, strong) NSString      *name;
@property (nonatomic, strong) NSNumber      *age;
@property (nonatomic, strong) NSDictionary  *infomation;
@property (nonatomic)         BOOL           isMan;

@end

inline static Student *student() {

    return [Student sharedInstance];
}
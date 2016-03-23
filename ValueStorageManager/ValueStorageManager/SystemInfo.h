//
//  SystemInfo.h
//  ValueStorageManager
//
//  Created by YouXianMing on 16/3/17.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "BaseValueStorageManager.h"
#import <UIKit/UIKit.h>

@interface SystemInfo : BaseValueStorageManager

@property (nonatomic) CGFloat  systemVolume;

@end

inline static SystemInfo *systemInfo() {

    return [SystemInfo sharedInstance];
}
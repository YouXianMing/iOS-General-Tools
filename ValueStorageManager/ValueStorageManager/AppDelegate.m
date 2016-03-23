//
//  AppDelegate.m
//  ValueStorageManager
//
//  Created by YouXianMing on 16/3/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AppDelegate.h"
#import "AES256EncryptMode.h"
#import "DESEncryptMode.h"
#import "CASTEncryptMode.h"
#import "Student.h"
#import "SystemInfo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [Student configEncryptingMode:[AES256EncryptMode new] prefix:nil];
    [SystemInfo configEncryptingMode:[DESEncryptMode new] prefix:nil];
    
    return YES;
}

@end

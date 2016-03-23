//
//  ViewController.m
//  ValueStorageManager
//
//  Created by YouXianMing on 16/3/16.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "SystemInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"%@", student().name);
    NSLog(@"%@", student().age);
    NSLog(@"%@", student().infomation);
    NSLog(@"%d", student().isMan);
    NSLog(@"%f", systemInfo().systemVolume);

    student().name            = @"YouXianMing";
    student().age             = @(28);
    student().infomation      = @{@"ValueStorageManager" : @"Useful tool"};
    student().isMan           = YES;
    systemInfo().systemVolume = 100.f;
}

@end

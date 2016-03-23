//
//  ViewController.m
//  FileManager
//
//  Created by YouXianMing on 15/11/19.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "FileManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Scan files.
    File *file = [FileManager scanRelatedFilePath:@"~/Library" maxTreeLevel:1];
    NSLog(@"\n\n%@ \n%@\n\n", file, file.subFiles);
    
    // Get the real file path from related file path.
    NSLog(@"%@", [FileManager theRealFilePath:@"~/Documents"]);
    NSLog(@"%@", [FileManager theRealFilePath:@"-"]);
    
    // Check the file at the given path exist or not.
    NSLog(@"%d", [FileManager fileExistWithRealFilePath:[FileManager theRealFilePath:@"~/Library/Caches"]]);
    NSLog(@"%d", [FileManager fileExistWithRealFilePath:[FileManager theRealFilePath:@"~/YouXianMing"]]);
}

@end

//
//  ViewController.m
//  PCM-to-MP3
//
//  Created by YouXianMing on 16/7/28.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "PcmToMp3Manager.h"
#import "FileManager.h"
#import "AudioPlayer.h"

@interface ViewController () <PcmToMp3ManagerDelegate>

@property (nonatomic, strong) PcmToMp3Manager  *manager;
@property (nonatomic, strong) AudioPlayer      *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Lame-for-iOS https://github.com/wuqiong/mp3lame-for-iOS
    
    self.manager             = [PcmToMp3Manager new];
    self.manager.pcmFilePath = [FileManager bundleFileWithName:@"demo.caf"];
    self.manager.mp3FilePath = filePath(@"~/Documents/demo.mp3");
    self.manager.delegate    = self;
    [self.manager startConvert];
}

- (void)didConvertPcmToMp3:(PcmToMp3Manager *)manager sucess:(BOOL)sucess errorInfo:(NSString *)errorInfo {

    if (sucess) {
        
        self.player              = [AudioPlayer new];
        self.player.absolutePath = manager.mp3FilePath;
        self.player.timeInterval = 0.1f;
        if ([self.player prepare] && [self.player play]) {
            
            [self.player audioPlayerStatus:nil audioPlayerTimerEvent:^(NSTimeInterval currentTime, NSTimeInterval totalDuration) {
                
                NSLog(@"%f / %f", currentTime, totalDuration);
                
            } didFinishPlaying:nil errorDidOccur:nil];
        }
    }
}

@end

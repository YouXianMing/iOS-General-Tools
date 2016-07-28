//
//  AudioPlayer.m
//  RecordMusic
//
//  Created by YouXianMing on 16/7/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AudioPlayer.h"

@interface AudioPlayer () <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic)         BOOL           firstTimePlay;

@property (nonatomic, copy) audioPlayerStatus_t               playerStatusBlock;
@property (nonatomic, copy) audioPlayerTimerEvent_t           timerEventBlock;
@property (nonatomic, copy) audioPlayerDidFinishPlaying_t     didFinishPlayingBlock;
@property (nonatomic, copy) audioPlayerDecodeErrorDidOccur_t  encodeErrorDidOccurBlock;

@property (nonatomic, strong) NSTimer  *currentTimer;

@end

@implementation AudioPlayer

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.timeInterval = 0.1f;
    }
    
    return self;
}

- (BOOL)prepare {
    
    NSParameterAssert(self.absolutePath);
    
    self.firstTimePlay           = YES;
    BOOL     result              = NO;
    NSError *error               = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    if ([audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error]) {
        
        if ([audioSession setActive:YES error:&error]) {
        
            self.player           = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.absolutePath] error:&error];
            self.player.delegate  = self;
        }
    }
    
    error ? NSLog(@"%@", error) : (result = YES);
    
    return result;
}

- (void)stop {

    [self.player stop];
    [self timerEnable:NO];
    self.firstTimePlay      = YES;
    self.player.currentTime = 0.f;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
    self.playerStatusBlock ? self.playerStatusBlock(kPlayerStop) : 0;
}

- (BOOL)play {

    BOOL            result  = NO;
    NSError        *error   = nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([session setActive:YES error:&error] && self.player.isPlaying == NO) {
        
        result = [self.player play];
        result ? [self timerEnable:YES] : 0;
        
        if (self.firstTimePlay == YES) {
            
            self.firstTimePlay = NO;
            self.playerStatusBlock ? self.playerStatusBlock(kPlayerStart) : 0;
            
        } else {
            
            self.playerStatusBlock ? self.playerStatusBlock(kPlayerResume) : 0;
        }
    }
    
    error ? NSLog(@"%@", error) : 0;
    
    return result;
}

- (void)pause {

    if (self.player.isPlaying) {
        
        [self timerEnable:NO];
        [self.player pause];
        self.playerStatusBlock ? self.playerStatusBlock(kPlayerPause) : 0;
    }
}

#pragma mark - Timer related.

- (void)setupTimerWithTimeInterval:(NSTimeInterval)timeInterval {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _currentTimer = timer;
}

- (void)timerEnable:(BOOL)enabled {
    
    if (enabled) {
        
        [_currentTimer invalidate];
        _currentTimer = nil;
        [self setupTimerWithTimeInterval:self.timeInterval <= 0.f ? 0.1 : self.timeInterval];
        
    } else {
        
        [_currentTimer invalidate];
        _currentTimer = nil;
    }
}

- (void)timerEvent {
    
    if (self.player.isPlaying && self.timerEventBlock) {
        
        self.timerEventBlock(self.player.currentTime, self.player.duration);
    }
}

#pragma mark - Register properties blocks.

- (void)audioPlayerStatus:(audioPlayerStatus_t)playerStatus
    audioPlayerTimerEvent:(audioPlayerTimerEvent_t)timerEvent
         didFinishPlaying:(audioPlayerDidFinishPlaying_t)didFinishPlaying
            errorDidOccur:(audioPlayerDecodeErrorDidOccur_t)encodeErrorDidOccur {

    self.playerStatusBlock        = playerStatus;
    self.timerEventBlock          = timerEvent;
    self.didFinishPlayingBlock    = didFinishPlaying;
    self.encodeErrorDidOccurBlock = encodeErrorDidOccur;
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {

    [self timerEnable:NO];
    self.firstTimePlay     = YES;
    self.playerStatusBlock ? self.playerStatusBlock(kPlayerStop) : 0;
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {

    [self timerEnable:NO];
    self.firstTimePlay     = YES;
    self.playerStatusBlock ? self.playerStatusBlock(kPlayerStop) : 0;
}

#pragma makr - Release properties.

- (void)dealloc {

    self.playerStatusBlock        = nil;
    self.timerEventBlock          = nil;
    self.didFinishPlayingBlock    = nil;
    self.encodeErrorDidOccurBlock = nil;
    [self timerEnable:NO];
}

@end

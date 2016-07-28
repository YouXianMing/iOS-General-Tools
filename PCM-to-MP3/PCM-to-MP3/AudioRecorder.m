//
//  AudioRecorder.m
//  RecordMusic
//
//  Created by YouXianMing on 16/7/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "AudioRecorder.h"

@interface AudioRecorder () <AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer         *currentTimer;

@property (nonatomic)         BOOL             firstTimeRecord;
@property (nonatomic)         NSTimeInterval   recordDurationInterval;

@property (nonatomic, copy)   audioRecorderStatus_t              statusBlock;
@property (nonatomic, copy)   audioRecorderTimerEvent_t          timerEventBlock;
@property (nonatomic, copy)   audioRecorderDidFinishRecording_t  finishRecordingBlock;
@property (nonatomic, copy)   audioRecorderEncodeErrorDidOccur_t encodeErrorDidOccurBlock;

@end

@implementation AudioRecorder

- (instancetype)init {
    
    if (self = [super init]) {
    
        self.timeInterval = 0.1f;
    }
    
    return self;
}

- (BOOL)record {
    
    BOOL     result = NO;
    NSError *error  = nil;
    
    if ([self.recorder prepareToRecord] && self.recorder && self.recorder.isRecording == NO) {
        
        self.recordDurationInterval = 0.f;
        AVAudioSession *session     = [AVAudioSession sharedInstance];
        
        if ([session setActive:YES error:&error]) {
            
            result = [self.recorder record];
            result ? [self timerEnable:YES] : 0;
            
            if (self.firstTimeRecord == YES) {
                
                self.firstTimeRecord = NO;
                self.statusBlock ? self.statusBlock(kRecordStart) : 0;
                
            } else {
            
                self.statusBlock ? self.statusBlock(kRecordResume) : 0;
            }
        }
    }
    
    error ? NSLog(@"%@", error) : 0;
    
    return result;
}

- (BOOL)recordForDuration:(NSTimeInterval)duration {
    
    BOOL     result = NO;
    NSError *error  = nil;
    
    if ([self.recorder prepareToRecord] && self.recorder && self.recorder.isRecording == NO) {
        
        self.recordDurationInterval = duration;
        AVAudioSession *session     = [AVAudioSession sharedInstance];
        
        if ([session setActive:YES error:&error]) {
            
            result = [self.recorder recordForDuration:duration];
            result ? [self timerEnable:YES] : 0;
            
            if (self.firstTimeRecord == YES) {
                
                self.firstTimeRecord = NO;
                self.statusBlock ? self.statusBlock(kRecordStart) : 0;
                
            } else {
                
                self.statusBlock ? self.statusBlock(kRecordResume) : 0;
            }
            
        } else {
            
            NSLog(@"%@", error);
        }
    }
    
    return result;
}

- (void)pause {
    
    if (self.recorder && self.recorder.isRecording) {
        
        [self timerEnable:NO];
        [self.recorder pause];
        self.statusBlock ? self.statusBlock(kRecordPause) : 0;
    }
}

- (void)stop {
    
    if (self.recorder) {
        
        // Stop record.
        [self.recorder stop];
        [self timerEnable:NO];
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
        self.statusBlock ? self.statusBlock(kRecordStop) : 0;
    }
}

- (BOOL)prepare {
    
    NSParameterAssert(self.absolutePath);
    
    self.firstTimeRecord    = YES;
    BOOL            result  = NO;
    NSError        *error   = nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    if ([session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error]) {
        
        NSURL *url = [NSURL fileURLWithPath:self.absolutePath];
        
        // Define the recorder setting.
        NSMutableDictionary *recordSettingValue   = [[NSMutableDictionary alloc] init];
        
        recordSettingValue[AVFormatIDKey]            = @(kAudioFormatLinearPCM);
        recordSettingValue[AVSampleRateKey]          = @(44100.0);
        recordSettingValue[AVNumberOfChannelsKey]    = @(2);
        recordSettingValue[AVLinearPCMBitDepthKey]   = @(16);
        recordSettingValue[AVEncoderAudioQualityKey] = @(AVAudioQualityMin);
        
        // Initiate and prepare the recorder.
        self.recorder                 = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettingValue error:&error];
        self.recorder.delegate        = self;
        self.recorder.meteringEnabled = YES;
        error == nil ? result = YES : 0;
    }
    
    error ? NSLog(@"%@", error) : 0;
    
    return result;
}

- (void)audioRecordStatus:(audioRecorderStatus_t)recorderStatus
    audioRecordTimerEvent:(audioRecorderTimerEvent_t)timerEvent
          finishRecording:(audioRecorderDidFinishRecording_t)finishRecording
      encodeErrorDidOccur:(audioRecorderEncodeErrorDidOccur_t)encodeErrorDidOccur {

    self.statusBlock              = recorderStatus;
    self.timerEventBlock          = timerEvent;
    self.finishRecordingBlock     = finishRecording;
    self.encodeErrorDidOccurBlock = encodeErrorDidOccur;
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
    
    if (self.recorder.isRecording && self.timerEventBlock) {
        
        self.timerEventBlock(self.recorder.currentTime, self.recordDurationInterval);
    }
}

#pragma mark -

+ (AVAudioSessionRecordPermission)recordPermission {
    
    return [[AVAudioSession sharedInstance] recordPermission];
}

#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)audioRecorder successfully:(BOOL)flag {
    
    [self timerEnable:NO];
    self.finishRecordingBlock ? self.finishRecordingBlock(audioRecorder, flag) : 0;
    self.firstTimeRecord = YES;
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)audioRecorder error:(NSError *)error {
    
    [self timerEnable:NO];
    self.encodeErrorDidOccurBlock ? self.encodeErrorDidOccurBlock(audioRecorder, error) : 0;
    self.firstTimeRecord = YES;
}

#pragma mark - Dealloc

- (void)dealloc {

    self.statusBlock              = nil;
    self.timerEventBlock          = nil;
    self.finishRecordingBlock     = nil;
    self.encodeErrorDidOccurBlock = nil;
    [self timerEnable:NO];
}

@end

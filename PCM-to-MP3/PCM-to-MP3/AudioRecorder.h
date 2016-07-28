//
//  AudioRecorder.h
//  RecordMusic
//
//  Created by YouXianMing on 16/7/26.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSUInteger {
    
    /**
     *  Start record.
     */
    kRecordStart = 1000,
    
    /**
     *  Pause record.
     */
    kRecordPause,
    
    /**
     *  Resume record.
     */
    kRecordResume,
    
    /**
     *  Stop record.
     */
    kRecordStop,
    
} EAudioRecorderStatus;

typedef void (^audioRecorderStatus_t)(EAudioRecorderStatus recorderStatus);
typedef void (^audioRecorderTimerEvent_t)(NSTimeInterval currentTime, NSTimeInterval totalDuration);
typedef void (^audioRecorderDidFinishRecording_t)(AVAudioRecorder *audioRecorder, BOOL successfully);
typedef void (^audioRecorderEncodeErrorDidOccur_t)(AVAudioRecorder *audioRecorder, NSError *error);

@interface AudioRecorder : NSObject

/**
 *  The recorder object, read only.
 */
@property (nonatomic, strong, readonly) AVAudioRecorder *recorder;

/**
 *  The audio file absolute path.
 */
@property (nonatomic, strong) NSString *absolutePath;

/**
 *  The number of seconds between firings of the timer, default is 0.1s.
 */
@property (nonatomic) NSTimeInterval  timeInterval;

/**
 *  Before record, you should run this method to indicate wheather you can record or not.
 *
 *  @return Can record or not.
 */
- (BOOL)prepare;

/**
 *  Start record.
 *
 *  @return Success or not.
 */
- (BOOL)record;

/**
 *  Records for a specified duration of time.
 *
 *  @param duration Specified duration for the record.
 *
 *  @return Success or not.
 */
- (BOOL)recordForDuration:(NSTimeInterval)duration;

/**
 *  Pause the record.
 */
- (void)pause;

/**
 *  Stop the record.
 */
- (void)stop;

/**
 *  To get the record permission.
 *
 *  @return AVAudioSessionRecordPermission
 */
+ (AVAudioSessionRecordPermission)recordPermission;

- (void)audioRecordStatus:(audioRecorderStatus_t)recorderStatus
    audioRecordTimerEvent:(audioRecorderTimerEvent_t)timerEvent
          finishRecording:(audioRecorderDidFinishRecording_t)finishRecording
      encodeErrorDidOccur:(audioRecorderEncodeErrorDidOccur_t)encodeErrorDidOccur;

@end

//
//  AudioPlayer.h
//  RecordMusic
//
//  Created by YouXianMing on 16/7/27.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSUInteger {
    
    /**
     *  Start record.
     */
    kPlayerStart = 1000,
    
    /**
     *  Pause record.
     */
    kPlayerPause,
    
    /**
     *  Resume record.
     */
    kPlayerResume,
    
    /**
     *  Stop record.
     */
    kPlayerStop,
    
} EAudioPlayerStatus;

typedef void (^audioPlayerStatus_t)(EAudioPlayerStatus recorderStatus);
typedef void (^audioPlayerTimerEvent_t)(NSTimeInterval currentTime, NSTimeInterval totalDuration);
typedef void (^audioPlayerDidFinishPlaying_t)(AVAudioPlayer *player, BOOL successfully);
typedef void (^audioPlayerDecodeErrorDidOccur_t)(AVAudioPlayer *player, NSError *error);

@interface AudioPlayer : NSObject

@property (nonatomic, strong, readonly) AVAudioPlayer *player;

/**
 *  The audio file absolute path.
 */
@property (nonatomic, strong) NSString *absolutePath;

/**
 *  The number of seconds between firings of the timer, default is 0.1s.
 */
@property (nonatomic) NSTimeInterval  timeInterval;

/**
 *  Before you start play, you must run the method.
 *
 *  @return Sucess or not.
 */
- (BOOL)prepare;

/**
 *  Stop the play.
 */
- (void)stop;

/**
 *  Start the play.
 *
 *  @return Success or not.
 */
- (BOOL)play;

/**
 *  Pause.
 */
- (void)pause;

- (void)audioPlayerStatus:(audioPlayerStatus_t)playerStatus
    audioPlayerTimerEvent:(audioPlayerTimerEvent_t)timerEvent
         didFinishPlaying:(audioPlayerDidFinishPlaying_t)didFinishPlaying
            errorDidOccur:(audioPlayerDecodeErrorDidOccur_t)encodeErrorDidOccur;

@end


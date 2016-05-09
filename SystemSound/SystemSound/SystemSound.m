//
//  SystemSound.m
//  SystemSound
//
//  Created by YouXianMing on 15/8/24.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "SystemSound.h"
#import <AudioToolbox/AudioToolbox.h>

static NSMutableArray *_systemSounds = nil;

@implementation SystemSound

+ (void)accessSystemSoundsList {

    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableArray *audioFileList = [NSMutableArray array];
            _systemSounds                 = [NSMutableArray array];
            
            // 读取文件系统
            NSFileManager *fileManager  = [[NSFileManager alloc] init];
            NSURL         *directoryURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds"];
            NSArray       *keys         = [NSArray arrayWithObject:NSURLIsDirectoryKey];
            
            NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtURL:directoryURL
                                                  includingPropertiesForKeys:keys
                                                                     options:0
                                                                errorHandler:^(NSURL *url, NSError *error) {
                                                                    return YES;
                                                                }];
            
            for (NSURL *url in enumerator) {
                
                NSError  *error;
                NSNumber *isDirectory = nil;
                if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
                    
                } else if (![isDirectory boolValue]) {
                    
                    [audioFileList addObject:url];
                    
                    SystemSoundID soundID;
                    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)url, &soundID);
                    
                    SoundInfomation *sound = [[SoundInfomation alloc] init];
                    sound.soundID   = soundID;
                    sound.soundUrl  = url;
                    sound.soundName = url.lastPathComponent;
                    
                    [_systemSounds addObject:sound];
                }
            }
            
            // 读取文件
            NSString *path = [[NSBundle mainBundle] pathForResource:@"SystemSoundList" ofType:nil];
            NSData   *data = [[NSData alloc] initWithContentsOfFile:path];
            
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray  *array  = [string componentsSeparatedByString:@"\n"];
            
            for (int i = 0; i < array.count; i++) {
                
                NSString *tmp = array[i];
                
                NSArray         *soundInfo = [tmp componentsSeparatedByString:@"\t"];
                SoundInfomation *sound     = [[SoundInfomation alloc] init];
                
                sound.soundID   = (unsigned int)[soundInfo[0] integerValue];
                sound.soundName = soundInfo[1];
                [_systemSounds addObject:sound];
            }
        });
    });
}

+ (NSArray *)systemSounds {

    return _systemSounds;
}

+ (void)playWithSound:(SoundInfomation *)sound {

    AudioServicesPlaySystemSound(sound.soundID);
}

+ (void)playWithSoundID:(UInt32)soundID {
    
    AudioServicesPlaySystemSound(soundID);
}

@end

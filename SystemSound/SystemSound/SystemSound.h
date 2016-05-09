//
//  SystemSound.h
//  SystemSound
//
//  Created by YouXianMing on 15/8/24.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoundInfomation.h"

@interface SystemSound : NSObject

/**
 *  获取系统消息列表
 */
+ (void)accessSystemSoundsList;

/**
 *  系统声音的列表
 *
 *  @return SoundInfomation对象数组
 */
+ (NSArray *)systemSounds;

/**
 *  播放声音
 *
 *  @param sound 声音
 */
+ (void)playWithSound:(SoundInfomation *)sound;

/**
 *  根据声音ID号播放声音
 *
 *  @param soundID 声音ID号码
 */
+ (void)playWithSoundID:(UInt32)soundID;

@end

//
//  PcmToMp3Manager.h
//  RecordMusic
//
//  Created by YouXianMing on 16/7/28.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//
//  Lame-for-iOS https://github.com/wuqiong/mp3lame-for-iOS
//

#import <Foundation/Foundation.h>
@class PcmToMp3Manager;

@protocol PcmToMp3ManagerDelegate <NSObject>

@optional

/**
 *  Did convert the pcm to mp3.
 *
 *  @param manager   The PcmToMp3Manager object.
 *  @param sucess    Sucess or not.
 *  @param errorInfo Error info.
 */
- (void)didConvertPcmToMp3:(PcmToMp3Manager *)manager sucess:(BOOL)sucess errorInfo:(NSString *)errorInfo;

@end

/**
 *  In "Build Phases", You can add '-Wno-shorten-64-to-32' to the file 'PcmToMp3Manager.m' to ignore the warning.
 */
@interface PcmToMp3Manager : NSObject

/**
 *  The PcmToMp3Manager's delegate.
 */
@property (nonatomic, weak) id <PcmToMp3ManagerDelegate> delegate;

/**
 *  The pcm file's path.
 */
@property (nonatomic, strong) NSString *pcmFilePath;

/**
 *  The mp3 file's path you specified.
 */
@property (nonatomic, strong) NSString *mp3FilePath;

/**
 *  Before you start convert, you should specified the pcm file's path.
 */
- (void)startConvert;

@end



//
//  PcmToMp3Manager.m
//  RecordMusic
//
//  Created by YouXianMing on 16/7/28.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "PcmToMp3Manager.h"
#import <lame/lame.h>

@implementation PcmToMp3Manager

- (void)startConvert {
    
    NSParameterAssert(self.pcmFilePath);
    
    BOOL isDirectory = NO;
    BOOL isExist     = [[NSFileManager defaultManager] fileExistsAtPath:self.pcmFilePath isDirectory:&isDirectory];
    
    if (isExist && isDirectory == NO) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            @try {
                
                int read, write;
                
                FILE *pcm = fopen([self.pcmFilePath cStringUsingEncoding:1], "rb");  //source
                fseek(pcm, 4*1024, SEEK_CUR);                                        //skip file header
                FILE *mp3 = fopen([self.mp3FilePath cStringUsingEncoding:1], "wb");  //output
                
                const int PCM_SIZE = 8192;
                const int MP3_SIZE = 8192;
                short int pcm_buffer[PCM_SIZE * 2];
                unsigned char mp3_buffer[MP3_SIZE];
                
                lame_t lame = lame_init();
                lame_set_in_samplerate(lame, 44100);
                lame_set_VBR(lame, vbr_default);
                lame_init_params(lame);
                
                do {
                    read = fread(pcm_buffer, 2 * sizeof(short int), PCM_SIZE, pcm);
                    
                    if (read == 0) {
                        
                        write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
                        
                    } else {
                        
                        write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
                    }
                    
                    fwrite(mp3_buffer, write, 1, mp3);
                    
                } while (read != 0);
                
                lame_close(lame);
                fclose(mp3);
                fclose(pcm);
                
            } @catch (NSException *exception) {
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(didConvertPcmToMp3:sucess:errorInfo:)]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.delegate didConvertPcmToMp3:self sucess:NO errorInfo:exception.description];
                    });
                }
                
            } @finally {
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(didConvertPcmToMp3:sucess:errorInfo:)]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.delegate didConvertPcmToMp3:self sucess:YES errorInfo:nil];
                    });
                }
            }
        });
        
    } else {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didConvertPcmToMp3:sucess:errorInfo:)]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.delegate didConvertPcmToMp3:self sucess:NO errorInfo:[NSString stringWithFormat:@"'%@' not exist.", self.pcmFilePath]];
            });
        }
    }
}

@end

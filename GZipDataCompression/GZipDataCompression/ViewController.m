//
//  ViewController.m
//  GZipDataCompression
//
//  Created by YouXianMing on 16/3/12.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "Godzippa.h"
#import "NSData+JSONData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // https://github.com/mattt/Godzippa
    
    /*
     Error Domain=com.alamofire.error.serialization.response Code=-1016 "Request failed: unacceptable content-type: application/x-gzip" UserInfo={com.alamofire.serialization.response.error.response=<NSHTTPURLResponse: 0x7fd8f25293e0>{ status code: 200, headers {
     Date = "Sat, 12 Mar 2016 03:48:00 GMT";
     Server = "Apache-Coyote/1.1";
     "Transfer-Encoding" = Identity;
     } }, com.alamofire.serialization.response.error.data=<1f8b0800 00000000 0000ab56 4ace4f49 55b2520a 08720d34 30303054 d2514a49 2c4954b2 aaaed551 ca2d4e07 4a3ded6f 7a367543 746671ee f33dd39e f66f8f7d b2a3f745 f3de273b 763d5fb9 0ba8bea4 b2006482 9b522d00 1076388e 4e000000>, NSLocalizedDescription=Request failed: unacceptable content-type: application/x-gzip}
     */
    
    NSURL  *fileURL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"GZipData" ofType:nil]];
    NSData *GZipData = [NSData dataWithContentsOfURL:fileURL];
    NSLog(@"%@ %@", GZipData, [GZipData toListProperty]);
    
    NSData *decompressingData = [GZipData dataByGZipDecompressingDataWithError:nil];
    NSLog(@"%@ %@", decompressingData, [decompressingData toListProperty]);
}

@end

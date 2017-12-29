//
//  GridCollectionViewCell.m
//  FontInfo
//
//  Created by YouXianMing on 2017/12/29.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "GridCollectionViewCell.h"
#import "UIView+SetRect.h"
#import "NSString+HexUnicode.h"

@interface GridCollectionViewCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *hexLabel;

@end

@implementation GridCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.label           = [UILabel new];
        self.label.textColor = [UIColor redColor];
        [self.contentView addSubview:self.label];
        
        self.hexLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 12.f)];
        self.hexLabel.font          = [UIFont systemFontOfSize:8.f];
        self.hexLabel.textColor     = [UIColor blackColor];
        self.hexLabel.textAlignment = NSTextAlignmentCenter;
        self.hexLabel.bottom        = self.height - 2.f;
        [self.contentView addSubview:self.hexLabel];
    }
    
    return self;
}

- (void)loadContent {
    
    self.label.font   = [UIFont fontWithName:self.data[@"name"] size:30.f];
    self.label.text   = [NSString unicodeWithHexString:self.data[@"hex"]];
    [self.label sizeToFit];
    self.label.center = self.middlePoint;
    
    self.hexLabel.text = self.data[@"hex"];
}

@end

//
//  SoundCell.m
//  SystemSound
//
//  Created by YouXianMing on 15/8/24.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "SoundCell.h"

@interface SoundCell ()

@property (nonatomic, strong) UILabel *soundIDLabel;
@property (nonatomic, strong) UILabel *soundNameLabel;
@property (nonatomic, strong) UIView  *lineView;

@end

@implementation SoundCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        [self buildViews];
    }
    
    return self;
}

- (void)setup {

}

- (void)buildViews {

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self.soundIDLabel           = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 100, 14)];
    self.soundIDLabel.font      = [UIFont fontWithName:@"Avenir-BookOblique" size:12.f];
    self.soundIDLabel.textColor = [UIColor redColor];
    [self addSubview:self.soundIDLabel];
    
    self.soundNameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, width, CELL_HEIGHT)];
    self.soundNameLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:20.f];
    [self addSubview:self.soundNameLabel];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT - 0.5f, width, 0.5f)];
    self.lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
    [self addSubview:self.lineView];
}

- (void)loadData:(id)data {

    SoundInfomation *sound = data;
    
    self.soundIDLabel.text   = [NSString stringWithFormat:@"%d", sound.soundID];
    self.soundNameLabel.text = sound.soundName;
}

@end

//
//  ViewController.m
//  SystemSound
//
//  Created by YouXianMing on 15/8/24.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "SystemSound.h"
#import "SoundCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *datasArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [SystemSound accessSystemSoundsList];
    
    [super viewDidLoad];
    
    self.datasArray = [NSMutableArray array];
    
    [self createTableView];
    
    [self performSelector:@selector(event) withObject:nil afterDelay:0.5f];
}

- (void)event {

    NSArray *sounds = [SystemSound systemSounds];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i = 0; i < sounds.count; i++) {
        
        [self.datasArray addObject:sounds[i]];
        [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - tableView相关
- (void)createTableView {

    self.tableView                = [[UITableView alloc] initWithFrame:self.view.bounds
                                                                 style:UITableViewStylePlain];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SoundCell class] forCellReuseIdentifier:@"SoundCell"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SoundInfomation *sound = self.datasArray[indexPath.row];
    SoundCell       *cell  = [tableView dequeueReusableCellWithIdentifier:@"SoundCell"];
    [cell loadData:sound];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [SystemSound playWithSound:self.datasArray[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

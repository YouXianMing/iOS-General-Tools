//
//  ViewController.m
//  IconFonts
//
//  Created by YouXianMing on 2017/12/29.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "ViewController.h"
#import "NSString+HexUnicode.h"
#import "UIView+SetRect.h"
#import "GridCollectionViewCell.h"
#import "NSArray+JSONData.h"
#import "FileManager.h"

static NSString *fontName = @"Weather&Time";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray             *datas;

@property (nonatomic, strong) UIButton *createButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Use 'Glyphs' to open font file.
    
    self.datas = [NSMutableArray array];
    
    NSArray <NSString *> *numbers_1 = @[@"0"];
    NSArray <NSString *> *numbers_2 = @[@"0"];
    NSArray <NSString *> *numbers_3 = @[@"4", @"5", @"6", @"7"];
    NSArray <NSString *> *numbers_4 = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7",
                                        @"8", @"9", @"A", @"B", @"C", @"D", @"E", @"F"];
    
    [numbers_1 enumerateObjectsUsingBlock:^(NSString * _Nonnull obj_1, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [numbers_2 enumerateObjectsUsingBlock:^(NSString * _Nonnull obj_2, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [numbers_3 enumerateObjectsUsingBlock:^(NSString * _Nonnull obj_3, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [numbers_4 enumerateObjectsUsingBlock:^(NSString * _Nonnull obj_4, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    NSString *hexString = [NSString stringWithFormat:@"0x%@%@%@%@", obj_1, obj_2, obj_3, obj_4];
                    [self.datas addObject:@{@"name" : fontName, @"hex"  : hexString}];
                }];
            }];
        }];
    }];
    
    // 布局
    CGFloat count                       = 5.f;
    self.layout                         = [UICollectionViewFlowLayout new];
    self.layout.minimumInteritemSpacing = 0.f;
    self.layout.minimumLineSpacing      = 0.f;
    self.layout.itemSize                = CGSizeMake(Width / count, Width / count);
    
    // collectionView
    self.collectionView                 = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    self.collectionView.contentInset    = UIEdgeInsetsMake(0, 0, 50.f, 0);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    // 注册cell
    [self.collectionView registerClass:[GridCollectionViewCell class] forCellWithReuseIdentifier:@"GridCollectionViewCell"];
    
    // 按钮
    self.createButton                 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, 50)];
    self.createButton.backgroundColor = [UIColor grayColor];
    self.createButton.right           = Width;
    self.createButton.bottom          = Height;
    [self.createButton setTitle:@"生成JSON数据" forState:UIControlStateNormal];
    [self.createButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.createButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
    [self.createButton addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.createButton];
}

- (void)buttonEvent {
    
    NSData *data = [self.datas toJSONData];
    [data writeToFile:filePath(@"~/Documents/WeatherAndTime.json") atomically:YES];
    NSLog(@"%@", filePath(@"~/Documents"));
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridCollectionViewCell" forIndexPath:indexPath];
    cell.data                    = self.datas[indexPath.row];
    [cell loadContent];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.datas removeObjectAtIndex:indexPath.row];
    [collectionView reloadData];
}


@end


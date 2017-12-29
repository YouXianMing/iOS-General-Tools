//
//  GridCollectionViewCell.h
//  FontInfo
//
//  Created by YouXianMing on 2017/12/29.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id data;

- (void)loadContent;

@end

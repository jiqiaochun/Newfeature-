//
//  GuideCell.h
//  107-网易彩票
//
//  Created by ji on 15/7/18.
//  Copyright (c) 2015年 ji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;

- (void)setIndexPath:(NSIndexPath *)idxPath withCellCount:(int)count;
@end

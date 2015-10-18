//
//  GuideViewController.m
//  107-网易彩票
//
//  Created by ji on 15/7/18.
//  Copyright (c) 2015年 ji. All rights reserved.
//

#import "GuideViewController.h"
#import "UIView+extension.h"
#import "GuideCell.h"


@interface GuideViewController ()
@property (nonatomic, weak) UIImageView *imgView1;
@property (nonatomic, weak) UIImageView *imgLargeText;
@property (nonatomic, weak) UIImageView *imgSmallText;
@end

@implementation GuideViewController

- (instancetype)init{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]
                                              init];
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing= 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:flowLayout];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:flowLayout];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 1. 获取数据
    NSString *imgName = [NSString stringWithFormat:@"guide%@Background", @(indexPath.row + 1)];
    
    // 2. 创建Cell
    GuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 3. 把数据赋值给cell
    cell.image = [UIImage imageNamed:imgName];
    
    [cell setIndexPath:indexPath withCellCount:4];
    
    // 4. 返回cell
    return cell;
}


static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[GuideCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
    
    // 1. "足球、篮球"图片
    UIImageView *imgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    [self.collectionView addSubview:imgView1];
    self.imgView1 = imgView1;
    
    // 2. "波浪线"图片
    UIImageView *imgLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    imgLine.x = -202;
    [self.collectionView addSubview:imgLine];
    
    
    
    // 3. "大文字"图片
    UIImageView *imgLargeText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    imgLargeText.y =  [UIScreen mainScreen].bounds.size.height * 0.7;
    [self.collectionView addSubview:imgLargeText];
    self.imgLargeText = imgLargeText;
    
    
    // 4. "小文字"图片
    UIImageView *imgSmallText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    imgSmallText.y = [UIScreen mainScreen].bounds.size.height * 0.8;
    [self.collectionView addSubview:imgSmallText];
    self.imgSmallText = imgSmallText;

}


// Scroll View 滚动结束事件（滚动已经减速完成）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"--------%@-------------", NSStringFromCGRect(scrollView.bounds));
    // 1. 获取滚动偏移的x值
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 获取当前要显示的下一张图片的名称
    int page = offsetX / scrollView.bounds.size.width;
    NSString *guide = [NSString stringWithFormat:@"guide%d", (page + 1)];
    NSString *largeText = [NSString stringWithFormat:@"guideLargeText%d", (page + 1)];
    NSString *smallText = [NSString stringWithFormat:@"guideSmallText%d", (page + 1)];
    
    // 把图片名称设置给图片框
    self.imgView1.image = [UIImage imageNamed:guide];
    self.imgLargeText.image = [UIImage imageNamed:largeText];
    self.imgSmallText.image = [UIImage imageNamed:smallText];
    
    
    
    // 判断滚动方向（向左滚还是向右滚动）
    CGFloat startX = offsetX;
    if (offsetX > self.imgView1.x) {
        // 向左滚
        startX = offsetX + scrollView.bounds.size.width;
    } else if (offsetX < self.imgView1.x) {
        //向右滚动
        startX = offsetX - scrollView.bounds.size.width;
    }
    // 根据向左滚动还是向右滚动，先设置一下每个图片框的起始x值
    self.imgView1.x = startX;
    self.imgLargeText.x = startX;
    self.imgSmallText.x = startX;
    
    // 2. 设置那几个图片框的x值等于滚动偏移的x值
    [UIView animateWithDuration:0.3 animations:^{
        self.imgView1.x = offsetX;
        self.imgLargeText.x = offsetX;
        self.imgSmallText.x = offsetX;
    }];
    
}


@end

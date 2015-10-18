//
//  WBNewfeatureViewController.m
//  微博
//
//  Created by ji on 15/8/7.
//  Copyright (c) 2015年 ji. All rights reserved.
//

#import "WBNewfeatureViewController.h"
#import "WBTabBarController.h"

@interface WBNewfeatureViewController () <UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageControl;
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation WBNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建一个scrollView 显示所有的新也行图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    // 添加图片到scrollView中
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        self.imageView = imageView;
    }
    
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize = CGSizeMake(4 * scrollW, 0);
    // 去掉scroll的弹簧效果
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.delegate = self;
    // 添加pageControl：分页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 4;
    pageControl.currentPageIndicatorTintColor = WBColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = WBColor(189, 189, 189);
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
    
    if (self.pageControl.currentPage == 3) {
        
        UIButton *shareBtn = [[UIButton alloc] init];
        [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        shareBtn.width = 120;
        shareBtn.height = 30;
        shareBtn.centerX = self.imageView.width * 0.5;
        shareBtn.centerY = self.imageView.height * 0.68;
        //shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [self.imageView addSubview:shareBtn];
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *startButton = [[UIButton alloc] init];
        [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        startButton.size = startButton.currentBackgroundImage.size;
        startButton.centerX = shareBtn.centerX;
        startButton.centerY = self.imageView.height * 0.75;
        [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
        [self.imageView addSubview:startButton];
        // 注册单机事件
        [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)shareClick:(UIButton *)shareBtn{
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startButtonClick{
    WBTabBarController *mainVc = [[WBTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVc;
}

@end

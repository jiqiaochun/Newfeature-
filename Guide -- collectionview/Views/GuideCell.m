//
//  GuideCell.m
//  107-网易彩票
//
//  Created by ji on 15/7/18.
//  Copyright (c) 2015年 ji. All rights reserved.
//

#import "GuideCell.h"
#import "NavTableBarViewController.h"
#import "UIView+extension.h"

@interface GuideCell ()
@property (nonatomic, strong) UIImageView *imgViewIcon;
@property (nonatomic, strong) UIButton *startButton;
@end

@implementation GuideCell
- (UIButton *)startButton
{
    if (_startButton == nil) {
        _startButton = [[UIButton alloc] init];
        [_startButton setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        [_startButton sizeToFit];
        [self addSubview:_startButton];
        
        // 注册单机事件
        [_startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (void)startButtonClick
{
    NavTableBarViewController *mainVc = [[NavTableBarViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVc;
}

- (UIImageView *)imgViewIcon
{
    if (_imgViewIcon == nil) {
        _imgViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgViewIcon];
    }
    return _imgViewIcon;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imgViewIcon.frame = self.bounds;
    CGFloat x = (self.w - self.startButton.w) * 0.5;
    CGFloat y = self.h * 0.85;
    self.startButton.x = x;
    self.startButton.y = y;
    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imgViewIcon.image = image;
}


- (void)setIndexPath:(NSIndexPath *)idxPath withCellCount:(int)count
{
    if (idxPath.row == count - 1) {
        // 表示滚动到了最后一个Cell, 创建并显示"立即体验"按钮
        self.startButton.hidden = NO;
    } else {
        // 隐藏"立即体验"按钮
        self.startButton.hidden = YES;
    }
}



@end

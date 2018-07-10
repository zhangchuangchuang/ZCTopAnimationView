//
//  ZCTopNavView.m
//  ZCTopAnimationView
//
//  Created by 张闯闯 on 2018/7/9.
//  Copyright © 2018年 张闯闯. All rights reserved.
//

#import "ZCTopNavView.h"
@interface ZCTopNavView()
/* 通知 */
@property (weak ,nonatomic) id dcObserve;

@end
@implementation ZCTopNavView

#define CreateWeakSelf __weak __typeof(self) weakSelf = self
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        [self acceptanceNote];
    }
    return self;
}

- (void)setUpUI
{
    //左边返回按钮
    _leftItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftItemButton setBackgroundImage:[UIImage imageNamed:@"spxq_zjt"] forState:UIControlStateNormal];
    [_leftItemButton addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftItemButton];
    
    //右边第一个分享按钮
    _rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightItemButton setBackgroundImage:[UIImage imageNamed:@"spxq_fx"] forState:UIControlStateNormal];
    [_rightItemButton addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightItemButton];
    //右边第二个首页按钮
    _rightRItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightRItemButton setBackgroundImage:[UIImage imageNamed:@"spxq_fh"] forState:UIControlStateNormal];
    [_rightRItemButton addTarget:self action:@selector(rightRButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightRItemButton];
    
    //头部中心图片
    _topCenterTitleImage = [[UIImageView alloc]init];
    _topCenterTitleImage.contentMode=UIViewContentModeScaleAspectFill;
    _topCenterTitleImage.hidden = YES;
    [self addSubview:_topCenterTitleImage];
    
    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.15].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.05].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.03].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.01].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    [self.layer addSublayer:layer];
}

#pragma mark - 接受通知
- (void)acceptanceNote
{
    //滚动到详情
    CreateWeakSelf;
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:@"SHOWTOPTOOLVIEW" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.topCenterTitleImage.hidden = NO;
        [weakSelf.leftItemButton setBackgroundImage:[UIImage imageNamed:@"pplm_jt"] forState:0];
        [weakSelf.rightItemButton setBackgroundImage:[UIImage imageNamed:@"xq_fx"] forState:0];
        [weakSelf.rightRItemButton setBackgroundImage:[UIImage imageNamed:@"xqsy"] forState:0];
    }];
    
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:@"HIDETOPTOOLVIEW" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.topCenterTitleImage.hidden = YES;
        [weakSelf.leftItemButton setBackgroundImage:[UIImage imageNamed:@"spxq_zjt"] forState:0];
        [weakSelf.rightItemButton setBackgroundImage:[UIImage imageNamed:@"spxq_fx"] forState:0];
        [weakSelf.rightRItemButton setBackgroundImage:[UIImage imageNamed:@"spxq_fh"] forState:0];
    }];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    _leftItemButton.frame =CGRectMake(11, HEIGHT(self) -35, 30, 30);
    ViewRadius(_leftItemButton, _leftItemButton.frame.size.width/2);
    
    _rightItemButton.frame = CGRectMake(WIDTH(self)-41, HEIGHT(self.self) - 35,30,30);
    ViewRadius(_rightItemButton, _rightItemButton.frame.size.width/2);
    
    _rightRItemButton.frame = CGRectMake(_rightItemButton.frame.origin.x-40, HEIGHT(self.self) - 35, 30, 30);
    ViewRadius(_rightRItemButton, _rightRItemButton.frame.size.width/2);
    
    _topCenterTitleImage.frame = CGRectMake(self.center.x-15, HEIGHT(self) -35, 30, 30);
    
}

#pragma mark - 消失
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObserve];
}
#pragma 自定义右边导航Item点击
- (void)rightButtonItemClick {
    !_rightItemClickBlock ? : _rightItemClickBlock();
}

#pragma 自定义左边导航Item点击
- (void)leftButtonItemClick {
    
    !_leftItemClickBlock ? : _leftItemClickBlock();
}

#pragma mark - 自定义右边第二个导航Item点击
- (void)rightRButtonItemClick
{
    !_rightRItemClickBlock ? : _rightRItemClickBlock();
}

@end

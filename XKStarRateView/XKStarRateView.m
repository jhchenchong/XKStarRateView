//
//  XKStartRateView.m
//  XKStarRateView
//
//  Created by 浪漫恋星空 on 2017/7/10.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "XKStarRateView.h"

#define NormalImageName @"b27_icon_star_yellow"

#define SelectedImageName @"b27_icon_star_gray"

typedef void(^completeBlock)(CGFloat currentScore);

@interface XKStarRateView ()

@property (nonatomic, strong) UIView *foregroundStarView;

@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;

@property (nonatomic, assign) CGFloat currentScore;

@property (nonatomic, strong) completeBlock complete;

@end

@implementation XKStarRateView

#pragma mark -- 构造方法

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _numberOfStars = 5;
        
        _rateStyle = XKWholeStarStyle;
        
        [self initStarView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars
                    rateStyle:(XKStarRateStyle)rateStyle
                  isAnination:(BOOL)isAnimation
                     delegate:(id<XKStarRateViewDelegate>)delegate {
    
    if (self = [super initWithFrame:frame]) {
        
        _numberOfStars = numberOfStars;
        
        _rateStyle = rateStyle;
        
        _isAnimation = isAnimation;
        
        _delegate = delegate;
        
        [self initStarView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
        starRateSelectedBlock:(XKStarRateSelectedBlock)starRateSelectedBlock{
    
    if (self = [super initWithFrame:frame]) {
        
        _numberOfStars = 5;
        
        _rateStyle = XKWholeStarStyle;
        
        _complete = ^(CGFloat currentScore){
            
            starRateSelectedBlock(currentScore);
        };
        
        [self initStarView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars
                    rateStyle:(XKStarRateStyle)rateStyle
                  isAnination:(BOOL)isAnimation
        starRateSelectedBlock:(XKStarRateSelectedBlock)starRateSelectedBlock {
    
    if (self = [super initWithFrame:frame]) {
        
        _numberOfStars = numberOfStars;
        
        _rateStyle = rateStyle;
        
        _isAnimation = isAnimation;
        
        _complete = ^(CGFloat currentScore) {
            
            starRateSelectedBlock(currentScore);
        };
        
        [self initStarView];
    }
    
    return self;
}

#pragma mark -- 私有方法

/**
 初始化评论视图
 */
- (void)initStarView {
    
    self.foregroundStarView = [self createStarViewWithImageName:NormalImageName];
    
    self.backgroundStarView = [self createStarViewWithImageName:SelectedImageName];
    
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width * _currentScore / self.numberOfStars, self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    
    [self addSubview:self.foregroundStarView];
}

/**
 根据图片名称创建StarView

 @param imageName 图片名称
 */
- (UIView *)createStarViewWithImageName:(NSString *)imageName {
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    
    view.clipsToBounds = YES;
    
    view.backgroundColor = [UIColor clearColor];
    
    for (NSInteger i = 0; i < self.numberOfStars; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [view addSubview:imageView];
    }
    
    return view;
}

/**
 根据偏移量计算最终的评分

 @param realStarScore 真实的偏移量
 */
- (void)handleRealStarScore:(CGFloat)realStarScore {
    
    switch (_rateStyle) {
            
        case XKWholeStarStyle:
            
            if (realStarScore < 0.5) {
                
                self.currentScore = 0;
                
            } else {
                
                self.currentScore = ceilf(realStarScore);
            }
            
            break;
            
        case XKHalfStarStyle:
            
            if (realStarScore < 0.4) {
                
                self.currentScore = 0;
                
            } else {
                
                self.currentScore = roundf(realStarScore) > realStarScore ? ceilf(realStarScore) : (ceilf(realStarScore) - 0.5);
            }
            
            break;
            
        case XKIncompleteStarStyle:
            
            self.currentScore = realStarScore;
            
            break;
            
        default:
            
            break;
    }
}

#pragma mark -- touch事件处理

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [event touchesForView:self];
    
    NSSet *allTouches = [event allTouches];
    
    UITouch *touch = [allTouches anyObject];
    
    CGPoint point = [touch locationInView:[touch view]];
    
    CGFloat offset = point.x;
    
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    
    [self handleRealStarScore:realStarScore];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [event touchesForView:self];
    
    NSSet *allTouches = [event allTouches];
    
    UITouch *touch = [allTouches anyObject];
    
    CGPoint point = [touch locationInView:[touch view]];
    
    CGFloat offset = point.x;
    
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    
    [self handleRealStarScore:realStarScore];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak XKStarRateView *weakSelf = self;
    
    CGFloat animationTimeInterval = self.isAnimation ? 0.2 : 0;
    
    [UIView animateWithDuration:animationTimeInterval animations:^{
        
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentScore/self.numberOfStars, weakSelf.bounds.size.height);
    }];
}

#pragma mark -- setter方法

- (void)setCurrentScore:(CGFloat)currentScore {
    
    if (_currentScore == currentScore) {
        
        return;
    }
    
    if (currentScore < 0) {
        
        _currentScore = 0;
        
    } else if (currentScore > _numberOfStars) {
        
        _currentScore = _numberOfStars;
        
    } else {
        
        _currentScore = currentScore;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(starRateView:currentScore:)]) {
        
        [self.delegate starRateView:self currentScore:_currentScore];
    }
    
    if (self.complete) {
        
        _complete(_currentScore);
    }
    
    [self setNeedsLayout];
}

@end

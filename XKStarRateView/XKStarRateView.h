//
//  XKStartRateView.h
//  XKStarRateView
//
//  Created by 浪漫恋星空 on 2017/7/10.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XKStarRateStyle) {
    
    XKWholeStarStyle = 0,
    
    XKHalfStarStyle = 1,
    
    XKIncompleteStarStyle = 2
};

typedef void(^XKStarRateSelectedBlock)(CGFloat score);

@class XKStarRateView;

@protocol XKStarRateViewDelegate <NSObject>

- (void)starRateView:(XKStarRateView *)starRateView currentScore:(CGFloat)currentScore;

@end


@interface XKStarRateView : UIView

/// 是否显示动画
@property (nonatomic, assign) BOOL isAnimation;

/// 评分样式 (XKWholeStarStyle 整星评论 XKHalfStarStyle 半星评论 XKIncompleteStarStyle 不完整星评论)
@property (nonatomic, assign) XKStarRateStyle rateStyle;

/// 代理
@property (nonatomic, weak) id<XKStarRateViewDelegate> delegate;

/**
 初始化方法

 @param frame 控件frame
 @param numberOfStars 星星数量
 @param rateStyle 评分样式 (XKWholeStarStyle 整星评论 XKHalfStarStyle 半星评论 XKIncompleteStarStyle 不完整星评论)
 @param isAnimation 是否动画
 @param delegate 代理
 @return XKStarRateView
 */
- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars
                    rateStyle:(XKStarRateStyle)rateStyle
                  isAnination:(BOOL)isAnimation
                     delegate:(id<XKStarRateViewDelegate>)delegate;


/**
 初始化方法

 @param frame 控件frame
 @param starRateSelectedBlock 点击星星的回调
 @return XKStarRateView
 */
- (instancetype)initWithFrame:(CGRect)frame
        starRateSelectedBlock:(XKStarRateSelectedBlock)starRateSelectedBlock;


/**
 初始化方法

 @param frame 控件frame
 @param numberOfStars 星星数量
 @param rateStyle 评分样式 (XKWholeStarStyle 整星评论 XKHalfStarStyle 半星评论 XKIncompleteStarStyle 不完整星评论)
 @param isAnimation 是否动画
 @param starRateSelectedBlock 点击星星的回调
 @return XKStarRateView
 */
- (instancetype)initWithFrame:(CGRect)frame
                numberOfStars:(NSInteger)numberOfStars
                    rateStyle:(XKStarRateStyle)rateStyle
                  isAnination:(BOOL)isAnimation
        starRateSelectedBlock:(XKStarRateSelectedBlock)starRateSelectedBlock;

@end

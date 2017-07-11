//
//  ViewController.m
//  XKStarRateView
//
//  Created by 浪漫恋星空 on 2017/7/10.
//  Copyright © 2017年 浪漫恋星空. All rights reserved.
//

#import "ViewController.h"
#import "XKStarRateView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    XKStarRateView *starRateView = [[XKStarRateView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    
    starRateView.center = self.view.center;
    
    starRateView.isAnimation = YES;
    
    starRateView.rateStyle = XKWholeStarStyle;
    
    [self.view addSubview:starRateView];
    
}

@end

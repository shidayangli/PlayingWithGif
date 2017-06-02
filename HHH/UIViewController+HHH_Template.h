//
//  UIViewController+HHH_Template.h
//  HHH
//
//  Created by yangli on 2017/6/2.
//  Copyright © 2017年 BigCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HHH_Template)

@property (nonatomic, strong) UIActivityIndicatorView *hhh_indicator;
@property (nonatomic, strong) UIView *hhh_maskView;
@property (nonatomic, strong) UIButton *hhh_loadButton;
@property (nonatomic, strong) UIButton *hhh_dismissButton;

- (void)hhh_setupButtons;
- (void)hhh_setupActivityIndicator;

- (void)hhh_stopIndicatorAnimate;
- (void)hhh_startIndicatorAnimate;

@end

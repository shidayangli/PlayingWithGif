//
//  UIViewController+HHH_Template.m
//  HHH
//
//  Created by yangli on 2017/6/2.
//  Copyright © 2017年 BigCompany. All rights reserved.
//

#import "UIViewController+HHH_Template.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation UIViewController (HHH_Template)

#pragma mark - SetupInitialUIMethods

- (void)hhh_setupButtons {
    self.hhh_loadButton = ({
        UIButton *loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loadButton.frame = CGRectMake(SCREEN_WIDTH/2.0 - 50, SCREEN_HEIGHT - 110, 100, 100);
        [loadButton setTitle:@"Load" forState:UIControlStateNormal];
        [loadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.view addSubview:loadButton];
        loadButton;
    });
    
    self.hhh_dismissButton = ({
        UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissButton.frame = CGRectMake(SCREEN_WIDTH/2.0 - 50, SCREEN_HEIGHT - 220, 100, 100);
        [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
        [dismissButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.view addSubview:dismissButton];
        dismissButton;
    });
}

- (void)hhh_setupActivityIndicator {
    self.hhh_maskView = ({
        UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.3;
        [self.view addSubview:maskView];
        maskView.hidden = YES;
        maskView;
    });
    
    self.hhh_indicator = ({
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.hhh_maskView addSubview:indicator];
        indicator.center = self.hhh_maskView.center;
        indicator;
    });
}

#pragma mark - IndicatorAnimateMethods

- (void)hhh_stopIndicatorAnimate {
    [self.hhh_indicator stopAnimating];
    self.hhh_maskView.hidden = YES;
}

- (void)hhh_startIndicatorAnimate {
    self.hhh_maskView.hidden = NO;
    [self.hhh_indicator startAnimating];
}

#pragma mark - setter or getter

- (UIButton *)hhh_loadButton {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHhh_loadButton:(UIButton *)hhh_loadButton {
    objc_setAssociatedObject(self, @selector(hhh_loadButton), hhh_loadButton, OBJC_ASSOCIATION_RETAIN);
}

- (UIButton *)hhh_dismissButton {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHhh_dismissButton:(UIButton *)hhh_dismissButton {
    objc_setAssociatedObject(self, @selector(hhh_dismissButton), hhh_dismissButton, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)hhh_maskView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHhh_maskView:(UIView *)hhh_maskView  {
    objc_setAssociatedObject(self, @selector(hhh_maskView), hhh_maskView, OBJC_ASSOCIATION_RETAIN);
}

- (UIActivityIndicatorView *)hhh_indicator {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHhh_indicator:(UIActivityIndicatorView *)hhh_indicator {
    objc_setAssociatedObject(self, @selector(hhh_indicator), hhh_indicator, OBJC_ASSOCIATION_RETAIN);
}

@end

//
//  ViewController.m
//  HHH
//
//  Created by 杨立 on 2017/4/8.
//  Copyright © 2017年 BigCompany. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    indicator.center = CGPointMake(screenWidth/2.0, screenHeight/2.0);
    [self.view addSubview:indicator];
    [indicator startAnimating];
}

- (IBAction)firstButtonClick:(id)sender {
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    [self presentViewController:firstViewController animated:YES completion:nil];
}

- (IBAction)secondButtonClick:(id)sender {
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self presentViewController:secondViewController animated:YES completion:nil];
}

@end

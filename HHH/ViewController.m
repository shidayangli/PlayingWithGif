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

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - event response

- (IBAction)firstButtonClick:(id)sender {
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    [self presentViewController:firstViewController animated:YES completion:nil];
}

- (IBAction)secondButtonClick:(id)sender {
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self presentViewController:secondViewController animated:YES completion:nil];
}

@end

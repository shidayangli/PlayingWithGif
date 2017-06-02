//
//  SecondViewController.m
//  HHH
//
//  Created by 杨立 on 2017/4/9.
//  Copyright © 2017年 BigCompany. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation SecondViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchGIFData];
}

- (void)setupWebView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2.0)];
    [self.view addSubview:webView];
    webView.scalesPageToFit = YES;
    self.webView = webView;
}

#pragma mark - SetupInitialUIMethods

- (void)setupButtons {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIButton *loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loadButton.frame = CGRectMake(screenWidth/2.0 - 50, screenHeight - 110, 100, 100);
    [loadButton setTitle:@"Load" forState:UIControlStateNormal];
    [loadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [loadButton addTarget:self action:@selector(showGif) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadButton];
    self.loadButton = loadButton;
    
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.frame = CGRectMake(screenWidth/2.0 - 50, screenHeight - 220, 100, 100);
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    self.dismissButton = dismissButton;
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.center = CGPointMake(screenWidth/2.0, screenHeight/2.0);
    [self.view addSubview:self.indicator];
}

- (void)setupActivityIndicator {
    self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.3;
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.center = self.maskView.center;
}

- (void)fetchGIFData {
    NSData *gifData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://media.giphy.com/media/l3q2AgQ1a9nCxJTFe/giphy.gif"]];
    [self.webView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:[NSURL URLWithString:@"https://"]];
}

@end

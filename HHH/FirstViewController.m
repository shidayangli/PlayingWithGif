//
//  FirstViewController.m
//  HHH
//
//  Created by 杨立 on 2017/4/8.
//  Copyright © 2017年 BigCompany. All rights reserved.
//

#import "FirstViewController.h"
#import <ImageIO/ImageIO.h>

@interface FirstViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) size_t imageCount;
@property (nonatomic, assign) size_t imageIndex;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGImageSourceRef gifImageSourceRef;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *dismissButton;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupButtons];
    [self setupActivityIndicator];
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

#pragma mark - SetupGIFImageMethods

- (void)showGif {
    [self startIndicatorAnimate];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self setupNecessaryParameters];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupImageView];
        });
    });
}

- (void)setupNecessaryParameters {
    NSURL *gifURL= [NSURL URLWithString:@"https://media.giphy.com/media/xUA7bg3C6oxt0EoMbm/giphy.gif"];
    self.gifImageSourceRef = CGImageSourceCreateWithURL((__bridge CFTypeRef)gifURL, NULL);
    self.imageCount = CGImageSourceGetCount(self.gifImageSourceRef);
    self.imageIndex = 1;
    if (self.imageCount <= 0) {
        return;
    }
}

- (void)setupImageView {
    CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(self.gifImageSourceRef, self.imageIndex - 1, NULL);
    NSNumber *GIFWidthNumber = (__bridge_transfer NSNumber *)CFDictionaryGetValue(properties, kCGImagePropertyPixelWidth);
    NSNumber *GIFHeightNumber = (__bridge_transfer NSNumber *)CFDictionaryGetValue(properties, kCGImagePropertyPixelHeight);
    if (GIFWidthNumber == nil || GIFHeightNumber == nil) {
        return;
    }
    
    CGFloat GIFWidth = GIFWidthNumber.floatValue;
    CGFloat GIFHeight = GIFHeightNumber.floatValue;
    CGFloat imageViewWidth = [UIScreen mainScreen].bounds.size.width - 20;
    CGFloat imageViewHeight = imageViewWidth * GIFHeight / GIFWidth;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, imageViewWidth, imageViewHeight)];
    [self.view addSubview:self.imageView];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    CGImageRef gifFirstFrameImageRef = CGImageSourceCreateImageAtIndex(self.gifImageSourceRef, self.imageIndex - 1, NULL);
    self.imageView.image = [UIImage imageWithCGImage:gifFirstFrameImageRef];
    [self stopIndicatorAnimate];
    self.loadButton.hidden = YES;
    self.dismissButton.hidden = YES;
    CFRelease(properties);
    CGImageRelease(gifFirstFrameImageRef);
    [self.indicator stopAnimating];
    self.timer = [NSTimer timerWithTimeInterval:0.12 target:self selector:@selector(animate) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)animate {
    self.imageCount --;
    self.imageIndex ++;
    if (self.imageCount <= 0) {
        if (self.timer && [self.timer isValid]) {
            [self.timer invalidate];
            self.timer = nil;
            CFRelease(self.gifImageSourceRef);
            self.loadButton.hidden = NO;
            self.dismissButton.hidden = NO;
        }
        return;
    }
    CGImageRef currentFrameImageRef = CGImageSourceCreateImageAtIndex(self.gifImageSourceRef, self.imageIndex - 1, NULL);
    self.imageView.image = [UIImage imageWithCGImage:currentFrameImageRef];
    CGImageRelease(currentFrameImageRef);
}

#pragma mark - IndicatorAnimateMethods

- (void)stopIndicatorAnimate {
    [self.indicator stopAnimating];
    [self.indicator removeFromSuperview];
    [self.maskView removeFromSuperview];
}

- (void)startIndicatorAnimate {
    [self.view addSubview:self.maskView];
    [self.maskView addSubview:self.indicator];
    [self.indicator startAnimating];
}

#pragma mark - DismissMethod

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

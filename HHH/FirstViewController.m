//
//  FirstViewController.m
//  HHH
//
//  Created by 杨立 on 2017/4/8.
//  Copyright © 2017年 BigCompany. All rights reserved.
//

#import "FirstViewController.h"
#import <ImageIO/ImageIO.h>
#import "UIViewController+HHH_Template.h"

@interface FirstViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) size_t imageCount;
@property (nonatomic, assign) size_t imageIndex;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGImageSourceRef gifImageSourceRef;

@end

@implementation FirstViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self hhh_setupButtons];
    [self hhh_setupActivityIndicator];
    [self.hhh_loadButton addTarget:self action:@selector(showGif) forControlEvents:UIControlEventTouchUpInside];
    [self.hhh_dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - SetupGIFImageMethods

- (void)showGif {
    [self hhh_startIndicatorAnimate];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self setupNecessaryParameters];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupImageView];
        });
    });
}

- (void)setupNecessaryParameters {
    NSURL *gifURL= [NSURL URLWithString:@"https://media.giphy.com/media/xUPGcELu51fFQ76TzG/giphy.gif"];
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
    [self hhh_stopIndicatorAnimate];
    self.hhh_loadButton.hidden = YES;
    self.hhh_dismissButton.hidden = YES;
    CFRelease(properties);
    CGImageRelease(gifFirstFrameImageRef);
    [self.hhh_indicator stopAnimating];
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
            self.hhh_loadButton.hidden = NO;
            self.hhh_dismissButton.hidden = NO;
        }
        return;
    }
    CGImageRef currentFrameImageRef = CGImageSourceCreateImageAtIndex(self.gifImageSourceRef, self.imageIndex - 1, NULL);
    self.imageView.image = [UIImage imageWithCGImage:currentFrameImageRef];
    CGImageRelease(currentFrameImageRef);
}

#pragma mark - DismissMethod

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

//
//  AdbertADBanner.h
//  sdk_refactor_sample
//
//  Created by William Kuo on 2017/11/6.
//  Copyright © 2017年 William Kuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdbertADBannerDelegate.h"
@import GoogleMobileAds;

@interface AdbertADBanner : UIView

@property(nonatomic, strong) id<AdbertADBannerDelegate> delegate;
@property(nonatomic, copy) NSString *APPID;
@property(nonatomic, copy) NSString *APPKEY;
@property(nonatomic, assign) CGSize adSize;
@property(nonatomic, copy) UIView *parentView;
@property(nonatomic, assign) BOOL isHichannel;

- (instancetype)initWithAPPID: (NSString *)APPID AndAPPKEY: (NSString *)APPKEY;
- (void)requestAD;
- (void)showAD;
- (void)reportDuration;
- (void)reportClick;
//- (void)reportShareReturn;
@end


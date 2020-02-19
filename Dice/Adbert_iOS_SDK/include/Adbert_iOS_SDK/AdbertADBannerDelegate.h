//
//  AdbertADBannerDelegate.h
//  sdk_refactor_sample
//
//  Created by William Kuo on 2017/11/6.
//  Copyright © 2017年 William Kuo. All rights reserved.
//

@class AdbertADBanner;

@protocol AdbertADBannerDelegate <NSObject>
@optional
- (void)adbertADViewDidReceiveAd:(AdbertADBanner *)banner;
- (void)adbertADView:(AdbertADBanner *)banner didFailToReceiveAdWithError:(NSError *)error;
- (void)adbertADViewDidClicked:(AdbertADBanner *)banner;
- (void)adbertBannerRequestFrequencyOverLimit:(AdbertADBanner *)banner;

@end

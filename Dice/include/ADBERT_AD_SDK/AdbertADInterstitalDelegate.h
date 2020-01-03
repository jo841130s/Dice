//
//  AdbertADInterstitalDelegate.h
//  sdk_refactor_sample
//
//  Created by William Kuo on 2018/1/17.
//  Copyright © 2018年 William Kuo. All rights reserved.
//

@class AdbertADInterstitial;

@protocol AdbertADInterstitalDelegate <NSObject>
@optional
- (void)adbertADInterstitialDidReceiveAd: (AdbertADInterstitial *)interstital;
- (void)adbertADInterstitial: (AdbertADInterstitial *)interstitial didFailToReceiveAdWithError: (NSError *)error;
- (void)adbertInterstitialWillAppear:(AdbertADInterstitial *)interstitial;
- (void)adbertInterstitialDidAppear:(AdbertADInterstitial *)interstitial;
- (void)adbertInterstitialWillDisappear:(AdbertADInterstitial *)interstitial;
- (void)adbertInterstitialDidDisappear:(AdbertADInterstitial *)interstitial;
- (void)adbertInterstitialDidExpire:(AdbertADInterstitial *)interstitial;
- (void)adbertInterstitialDidReceiveTapEvent:(AdbertADInterstitial *)interstitial;

@end

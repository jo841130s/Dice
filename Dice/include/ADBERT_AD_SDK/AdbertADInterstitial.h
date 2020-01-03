//
//  AdbertADInterstitial.h
//  sdk_refactor_sample
//
//  Created by William Kuo on 2018/1/17.
//  Copyright © 2018年 William Kuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdbertADInterstitalDelegate.h"
@import GoogleMobileAds;

typedef NS_ENUM(NSUInteger, AdbertADInterstitialType) {
    NormalInterstitial, H5Interstitial, VideoInterstitial
};

@interface AdbertADInterstitial : UIView

@property(nonatomic, strong) id<AdbertADInterstitalDelegate> delegate;
@property(nonatomic, copy) NSString * APPID;
@property(nonatomic, copy) NSString * APPKEY;
@property(nonatomic, assign) BOOL autoShowContentWhenReady;
@property(nonatomic, assign) BOOL ready;
@property(nonatomic, weak) UIView *parentView;
@property(nonatomic, assign) BOOL isHichannel;
@property(nonatomic, weak) UIViewController *adPresentViewController;

-(instancetype)initWithAPPID: (NSString *)APPID AndAPPKEY: (NSString *)APPKEY;
-(void)requestAD;
-(void)showAD;
-(void)reportClick;
-(void)reportActionReturnClick;
-(void)reportH5ShareReturnClick:(NSString *)shareString;
@end

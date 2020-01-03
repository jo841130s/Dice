//
//  AdbertADNativeADDelegate.h
//  sdk_refactor_sample
//
//  Created by William Kuo on 2018/2/5.
//  Copyright © 2018年 William Kuo. All rights reserved.
//

@class AdbertADNative;

@protocol AdbertADNativeDelegate <NSObject>
@optional
    - (void)adbertADNativeDidReceiceAd: (AdbertADNative *)nativeAD;
    - (void)adbertADNative: (AdbertADNative *)nativeAD didFailToReceiveAdWithError: (NSError *) error;
@end

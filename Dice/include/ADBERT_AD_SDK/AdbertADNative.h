//
//  AdbertADNative.h
//  sdk_refactor_sample
//
//  Created by William Kuo on 2018/2/5.
//  Copyright © 2018年 William Kuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdbertADNativeDelegate.h"

@interface AdbertADNative : UIView

@property (nonatomic, assign) NSString *APPID;
@property (nonatomic, assign) NSString *APPKEY;
@property (nonatomic, weak) UIView *parentView;
@property __weak id<AdbertADNativeDelegate> delegate;

- (void)requestAD;
- (void)showAD;

- (instancetype)initWithAPPID: (NSString *)APPID AndAPPKEY: (NSString *)APPKEY;
- (NSDictionary *)getADData;
- (void)nativeADClickedHandler;

@end

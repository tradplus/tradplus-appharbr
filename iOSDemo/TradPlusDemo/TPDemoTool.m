//
//  TPDemoTool.m
//  TradPlusDemo
//
//  Created by xuejun on 2024/10/16.
//  Copyright © 2024 tradplus. All rights reserved.
//

#import "TPDemoTool.h"
#import <AppHarbrSDK/AppHarbrSDK-Swift.h>

@implementation TPDemoTool

+ (NSInteger)getAHSDKID:(NSInteger)tpID
{
    switch (tpID)
    {
        case 1:
            return AdSdkFacebook;
        case 2:
            return AdSdkAdMob;
        case 9:
            return AdSdkAppLovin;
        case 10:
            return AdSdkIronSource;
        case 16:
            return AdSdkTencent;
        case 17:
            return AdSdkCsj;
        case 18:
            return AdSdkMintegral;
        case 19:
            return AdSdkPangle;
        case 48:
            return AdSdkGam;
            
        default:
            return AdSdkNone;
    }
}
@end

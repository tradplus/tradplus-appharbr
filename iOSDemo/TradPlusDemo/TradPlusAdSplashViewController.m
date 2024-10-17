//
//  TradPlusAdSplashViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdSplashViewController.h"
#import <TradPlusAds/TradPlusAdSplash.h>
#import "TPNativeTemplate.h"

@interface TradPlusAdSplashViewController ()<TradPlusADSplashDelegate>
{
    
}

@property (nonatomic, strong) TradPlusAdSplash *splashAd;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@property (nonatomic,assign)BOOL didShow;
@end

@implementation TradPlusAdSplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.splashAd = [[TradPlusAdSplash alloc] init];
    self.splashAd.delegate = self;
    [self.splashAd setAdUnitID:@"E5BC6369FC7D96FD47612B279BC5AAE0"];
}

- (IBAction)loadAct:(id)sender
{
    self.logLabel.text = @"start load";
    [self.splashAd loadAdWithWindow:[UIApplication sharedApplication].keyWindow bottomView:nil];
}

- (IBAction)showAct:(id)sender
{
    self.logLabel.text = @"";
    [self.splashAd show];
}


#pragma mark - TradPlusADSplashDelegate

- (void)tpSplashAdLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"Ad Loaded";
}
- (void)tpSplashAdLoadFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"Load Fail ：%ld",(long)error.code];
}
- (void)tpSplashAdImpression:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpSplashAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo,error);
}

- (void)tpSplashAdClicked:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpSplashAdDismissed:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"";
}

- (void)tpSplashAdBidStart:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpSplashAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    NSLog(@"%s \n%@ error :%@", __FUNCTION__ ,adInfo,error);
}

- (void)tpSplashAdStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpSplashAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpSplashAdOneLayerLoaded:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpSplashAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo , error);
}

- (void)tpSplashAdAllLoaded:(BOOL)success
{
    NSLog(@"%s \n%@", __FUNCTION__ ,@(success));
}

- (void)tpSplashAdSkip:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpSplashAdZoomOutViewShow:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpSplashAdZoomOutViewClose:(NSDictionary *)adInfo
{
    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}
@end

//
//  TradPlusAdInterstitialViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdInterstitialViewController.h"
#import <TradPlusAds/TradPlusAdInterstitial.h>
#import <TradPlusAds/TradPlus.h>
#import <AppHarbrSDK/AppHarbrSDK-Swift.h>
#import "TPDemoTool.h"

@interface TradPlusAdInterstitialViewController ()<TradPlusADInterstitialDelegate,AppHarbrAdQualityDelegate>

@property (nonatomic,strong)TradPlusAdInterstitial *interstitial;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@property (nonatomic,strong)TradPlusAdInterstitialObject *interstitialObject;
@property (nonatomic,assign)BOOL didShow;
@end

@implementation TradPlusAdInterstitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.name;
    self.interstitial = [[TradPlusAdInterstitial alloc] init];
    self.interstitial.delegate = self;
    [self.interstitial setAdUnitID:self.pid];
}

- (IBAction)loadAct:(id)sender
{
    self.logLabel.text = @"start load";
    [self.interstitial loadAd];
}

- (IBAction)verifyAct:(id)sender
{
    self.logLabel.text = @"";
    self.interstitialObject = [self.interstitial getReadyInterstitialObject];
    if(self.interstitialObject != nil)
    {
        self.logLabel.text = @"verifying";
        id object = self.interstitialObject.interstitialAdObject;
        NSLog(@"object %@",object);
        if(object != nil)
        {
            self.didShow = NO;
            NSInteger sdkID = [TPDemoTool getAHSDKID:self.interstitialObject.channel_id];
            NSLog(@"%@",@(sdkID));
            [[AppHarbrAdQuality shared] verifyAdWithAdObject:object adFormat:AHAdFormatInterstitial adContent:nil adNetworkSdk:sdkID mediationUnitId:nil adNetworkUnitId:nil mediationCID:nil adNetworkCID:nil extraData:nil delegate:self];
        }
    }
    else
    {
        NSLog(@"NO AD to show");
    }
}

- (void)showAd
{
    if(!self.didShow)
    {
        self.didShow = YES;
        id object = self.interstitialObject.interstitialAdObject;
        if(object != nil)
        {
            NSLog(@"object %@",object);
            self.didShow = NO;
            NSInteger sdkID = [TPDemoTool getAHSDKID:self.interstitialObject.channel_id];
            [[AppHarbrAdQuality shared] willDisplayAdWithAdObject:object adFormat:AHAdFormatInterstitial adContent:nil adNetworkSdk:sdkID mediationUnitId:nil adNetworkUnitId:nil mediationCID:nil adNetworkCID:nil extraData:nil];
        }
        [self.interstitial showWithInterstitialObject:self.interstitialObject rootViewController:self sceneId:nil];
    }
}


#pragma mark - TradPlusADInterstitialDelegate


- (void)tpInterstitialAdLoaded:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"AD Loaded";
}

- (void)tpInterstitialAdLoadFailWithError:(NSError *)error
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"Load Fail：%ld",(long)error.code];
}

- (void)tpInterstitialAdImpression:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpInterstitialAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
//    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo,error);
}

- (void)tpInterstitialAdClicked:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    
    id object = self.interstitialObject.interstitialAdObject;
    if(object != nil)
    {
        [[AppHarbrAdQuality shared] didClickAdWithAdObject:object];
    }
}

- (void)tpInterstitialAdDismissed:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"";
    
    id object = self.interstitialObject.interstitialAdObject;
    if(object != nil)
    {
        [[AppHarbrAdQuality shared] removeAdWithAdObject:object];
    }
}

- (void)tpInterstitialAdBidStart:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpInterstitialAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
//    NSLog(@"%s \n%@ error :%@", __FUNCTION__ ,adInfo,error);
}


- (void)tpInterstitialAdStartLoad:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpInterstitialAdOneLayerStartLoad:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}


- (void)tpInterstitialAdOneLayerLoaded:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpInterstitialAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
//    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo , error);
}

- (void)tpInterstitialAdAllLoaded:(BOOL)success
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,@(success));
}

- (void)tpInterstitialAdPlayStart:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpInterstitialAdPlayEnd:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}


#pragma mark - AppHarbrAdQualityDelegate

- (void)didAdIncidentWithAd:(NSObject * _Nonnull)ad adFormat:(enum AHAdFormat)adFormat blockReasons:(NSArray<NSString *> * _Nonnull)blockReasons reportReasons:(NSArray<NSString *> * _Nonnull)reportReasons creativeId:(NSString * _Nonnull)creativeId adNetworkSdk:(enum AdSdk)adNetworkSdk unitId:(NSString * _Nonnull)unitId timestamp:(NSTimeInterval)timestamp
{
    NSLog(@"AH ---- %s", __FUNCTION__ );
}

- (void)didAdIncidentOnDisplayWithAd:(NSObject * _Nonnull)ad adFormat:(enum AHAdFormat)adFormat blockReasons:(NSArray<NSString *> * _Nonnull)blockReasons reportReasons:(NSArray<NSString *> * _Nonnull)reportReasons creativeId:(NSString * _Nonnull)creativeId adNetworkSdk:(enum AdSdk)adNetworkSdk unitId:(NSString * _Nonnull)unitId timestamp:(NSTimeInterval)timestamp
{
    NSLog(@"AH ---- %s", __FUNCTION__ );
}

- (void)didAdVerifiedWithAd:(NSObject * _Nonnull)ad adFormat:(enum AHAdFormat)adFormat adNetworkSdk:(enum AdSdk)adNetworkSdk timestamp:(NSTimeInterval)timestamp
{
    NSLog(@"AH ---- %s", __FUNCTION__ );
    [self showAd];
}


- (void)didAdNotVerifiedWithAd:(NSObject * _Nonnull)ad adFormat:(enum AHAdFormat)adFormat error:(NSError * _Nonnull)error adNetworkSdk:(enum AdSdk)adNetworkSdk timestamp:(NSTimeInterval)timestamp
{
    NSLog(@"%s", __FUNCTION__);
    if(error != nil)
    {
        NSLog(@"AH ---- %@ %@",@(error.code),error.localizedDescription);
        if(error.code == AdQualityErrorTimeout)
        {
            [self showAd];
        }
    }
}
@end

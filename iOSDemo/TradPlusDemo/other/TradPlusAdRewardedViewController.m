//
//  TradPlusAdRewardedViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdRewardedViewController.h"
#import <TradPlusAds/TradPlusAdRewarded.h>
#import <AppHarbrSDK/AppHarbrSDK-Swift.h>
#import "TPDemoTool.h"

@interface TradPlusAdRewardedViewController ()<TradPlusADRewardedDelegate,TradPlusADRewardedPlayAgainDelegate,AppHarbrAdQualityDelegate>

@property (nonatomic, strong) TradPlusAdRewarded *rewardedVideoAd;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@property (nonatomic,strong)TradPlusAdRewardedObject *rewardedObject;
@property (nonatomic,assign)BOOL didShow;
@end

@implementation TradPlusAdRewardedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rewardedVideoAd = [[TradPlusAdRewarded alloc] init];
    self.rewardedVideoAd.delegate = self;
    self.rewardedVideoAd.playAgainDelegate = self;
    [self.rewardedVideoAd setAdUnitID:@"BBFCEAE498A151F9B3BA314F79B571AC"];
}

- (IBAction)loadAct:(id)sender
{
    //加载
    self.logLabel.text = @"start load";
    [self.rewardedVideoAd loadAd];
}

- (IBAction)verifyAct:(id)sender
{
    self.logLabel.text = @"";
    self.rewardedObject = [self.rewardedVideoAd getReadyRewardedObject];
    if(self.rewardedObject != nil)
    {
        id object = self.rewardedObject.rewardedAdObject;
        NSLog(@"object %@",object);
        if(object != nil)
        {
            self.didShow = NO;
            NSInteger sdkID = [TPDemoTool getAHSDKID:self.rewardedObject.channel_id];
            [[AppHarbrAdQuality shared] verifyAdWithAdObject:object adFormat:AHAdFormatRewarded adContent:nil adNetworkSdk:sdkID mediationUnitId:nil adNetworkUnitId:nil mediationCID:nil adNetworkCID:nil extraData:nil delegate:self];
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
        id object = self.rewardedObject.rewardedAdObject;
        if(object != nil)
        {
            NSLog(@"object %@",object);
            self.didShow = NO;
            NSInteger sdkID = [TPDemoTool getAHSDKID:self.rewardedObject.channel_id];
            [[AppHarbrAdQuality shared] willDisplayAdWithAdObject:object adFormat:AHAdFormatRewarded adContent:nil adNetworkSdk:sdkID mediationUnitId:nil adNetworkUnitId:nil mediationCID:nil adNetworkCID:nil extraData:nil];
        }
        [self.rewardedVideoAd showWithRewardedObject:self.rewardedObject rootViewController:self sceneId:nil];
    }
}


#pragma mark - TradPlusADRewardedDelegate


- (void)tpRewardedAdLoaded:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"AD Loaded";
}

- (void)tpRewardedAdLoadFailWithError:(NSError *)error
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"Load Fail：%ld",(long)error.code];
}

- (void)tpRewardedAdImpression:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpRewardedAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
//    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo,error);
}

- (void)tpRewardedAdClicked:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    
    id object = self.rewardedObject.rewardedAdObject;
    if(object != nil)
    {
        [[AppHarbrAdQuality shared] didClickAdWithAdObject:object];
    }
}

- (void)tpRewardedAdDismissed:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"";
    
    id object = self.rewardedObject.rewardedAdObject;
    if(object != nil)
    {
        [[AppHarbrAdQuality shared] removeAdWithAdObject:object];
    }
}

- (void)tpRewardedAdReward:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpRewardedAdBidStart:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpRewardedAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
//    NSLog(@"%s \n%@ error :%@", __FUNCTION__ ,adInfo,error);
}

- (void)tpRewardedAdStartLoad:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpRewardedAdOneLayerStartLoad:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}


- (void)tpRewardedAdOneLayerLoaded:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpRewardedAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
//    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo , error);
}

- (void)tpRewardedAdAllLoaded:(BOOL)success
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,@(success));
}

- (void)tpRewardedAdPlayStart:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpRewardedAdPlayEnd:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}


#pragma mark - TradPlusADRewardedPlayAgainDelegate


- (void)tpRewardedAdPlayAgainImpression:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}


- (void)tpRewardedAdPlayAgainShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
//    NSLog(@"%s \n%@ error:%@", __FUNCTION__ ,adInfo,error);
}


- (void)tpRewardedAdPlayAgainClicked:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpRewardedAdPlayAgainReward:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpRewardedAdPlayAgainPlayStart:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpRewardedAdPlayAgainPlayEnd:(NSDictionary *)adInfo
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

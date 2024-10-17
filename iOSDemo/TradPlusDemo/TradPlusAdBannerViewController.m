//
//  TradPlusAdBannerViewController.m
//  TradPlusDemo
//
//  Created by xuejun on 2021/9/2.
//  Copyright © 2021 tradplus. All rights reserved.
//

#import "TradPlusAdBannerViewController.h"
#import <TradPlusAds/TradPlusAdBanner.h>
#import <AppHarbrSDK/AppHarbrSDK-Swift.h>
#import "TPDemoTool.h"

@interface TradPlusAdBannerViewController ()<TradPlusADBannerDelegate,AppHarbrAdQualityDelegate>
{
    BOOL isFirst;
}

@property (nonatomic,strong)TradPlusAdBanner *banner;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@property (nonatomic,assign)BOOL didShow;
@property (nonatomic,strong)id adObject;
@property (nonatomic,assign)NSInteger channelID;
@end

@implementation TradPlusAdBannerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    isFirst = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    if(isFirst)
    {
        isFirst = NO;
        self.banner = [[TradPlusAdBanner alloc] init];
        [self.banner setAdUnitID:@"9E56C2D02AAB859FF45CC9BDC6C91C21"];
        self.banner.frame = self.adView.bounds;
        self.banner.delegate = self;
        self.banner.autoShow = NO;
        [self.adView addSubview:self.banner];
    }
}

- (IBAction)loadAct:(id)sender
{
    self.logLabel.text = @"start load";
    [self.banner loadAdWithSceneId:nil];
}

- (IBAction)verifyAct:(id)sender
{
    self.logLabel.text = @"";
    self.adObject = [self.banner getBannerAd];
    NSLog(@"adObject %@",self.adObject);
    self.channelID = [[self.banner getReadyAdInfo][@"channel_id"] integerValue];
    if(self.adObject != nil)
    {
        self.didShow = NO;
        NSInteger sdkID = [TPDemoTool getAHSDKID:self.channelID];
        [[AppHarbrAdQuality shared] verifyAdWithAdObject:self.adObject adFormat:AHAdFormatBanner adContent:nil adNetworkSdk:sdkID mediationUnitId:nil adNetworkUnitId:nil mediationCID:nil adNetworkCID:nil extraData:nil delegate:self];
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
        if(self.adObject != nil)
        {
            NSLog(@"object %@",self.adObject);
            self.didShow = NO;
            NSInteger sdkID = [TPDemoTool getAHSDKID:self.channelID];
            [[AppHarbrAdQuality shared] willDisplayAdWithAdObject:self.adObject adFormat:AHAdFormatBanner adContent:nil adNetworkSdk:sdkID mediationUnitId:nil adNetworkUnitId:nil mediationCID:nil adNetworkCID:nil extraData:nil];
        }
        [self.banner showWithSceneId:nil];
    }
}


#pragma mark - TradPlusADBannerDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)tpBannerAdLoaded:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    self.logLabel.text = @"Ad Loaded";
}

- (void)tpBannerAdLoadFailWithError:(NSError *)error
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,error);
    self.logLabel.text = [NSString stringWithFormat:@"Load Fail：%ld",(long)error.code];
}

- (void)tpBannerAdImpression:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpBannerAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
//    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo,error);
    self.logLabel.text = [NSString stringWithFormat:@"Show Fail ：%ld",(long)error.code];
}

- (void)tpBannerAdClicked:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
    if(self.adObject != nil)
    {
        [[AppHarbrAdQuality shared] didClickAdWithAdObject:self.adObject];
    }
}

- (void)tpBannerAdBidStart:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpBannerAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
//    NSLog(@"%s \n%@ error :%@", __FUNCTION__ ,adInfo,error);
}


- (void)tpBannerAdStartLoad:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpBannerAdOneLayerStartLoad:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}


- (void)tpBannerAdOneLayerLoaded:(NSDictionary *)adInfo
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,adInfo);
}

- (void)tpBannerAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
//    NSLog(@"%s \n%@ %@", __FUNCTION__ ,adInfo , error);
}

- (void)tpBannerAdAllLoaded:(BOOL)success
{
//    NSLog(@"%s \n%@", __FUNCTION__ ,@(success));
}

- (void)tpBannerAdClose:(NSDictionary *)adInfo
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

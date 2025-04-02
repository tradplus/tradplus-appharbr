//
//  TradPlusAdNativeViewController.m
//  TradplusADDemo
//
//  Created by xuejun on 2021/8/11.
//

#import "TradPlusAdNativeViewController.h"
#import <TradPlusAds/TradPlusAdNative.h>
#import <TradPlusAds/MsCommon.h>
#import "TPNativeTemplate.h"
#import <AppHarbrSDK/AppHarbrSDK-Swift.h>
#import "TPDemoTool.h"

@interface TradPlusAdNativeViewController ()<TradPlusADNativeDelegate,AppHarbrAdQualityDelegate>

@property (nonatomic,strong)TradPlusAdNative *nativeAd;
@property (nonatomic,weak)IBOutlet UILabel *logLabel;
@property (nonatomic,weak)IBOutlet UIView *adView;
@property (nonatomic,strong)TradPlusAdNativeObject *nativeObject;
@property (nonatomic,assign)BOOL didShow;
@end

@implementation TradPlusAdNativeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nativeAd = [[TradPlusAdNative alloc] init];
    self.nativeAd.delegate = self;
    [self.nativeAd setAdUnitID:@"293161A28F7C5D6750F97BA97A11FEC8"];
}

- (IBAction)loadAct:(id)sender
{
    self.logLabel.text = @"start load";
    [self.nativeAd loadAd];
}

- (IBAction)verifyAct:(id)sender
{
    self.logLabel.text = @"";
    self.nativeObject = [self.nativeAd getReadyNativeObject];
    if(self.nativeObject != nil)
    {
        id object = self.nativeObject.customObject;
        if(object != nil)
        {
            NSLog(@"object %@",object);
            self.didShow = NO;
            NSInteger sdkID = [TPDemoTool getAHSDKID:self.nativeObject.channel_id];
            [[AppHarbrAdQuality shared] verifyAdWithAdObject:object adFormat:AHAdFormatNative adContent:nil adNetworkSdk:sdkID mediationUnitId:nil adNetworkUnitId:nil mediationCID:nil adNetworkCID:nil extraData:nil delegate:self];
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
        id object = self.nativeObject.customObject;
        if(object != nil)
        {
            NSLog(@"object %@",object);
            self.didShow = NO;
            NSInteger sdkID = [TPDemoTool getAHSDKID:self.nativeObject.channel_id];
            [[AppHarbrAdQuality shared] willDisplayAdWithAdObject:object adFormat:AHAdFormatNative adContent:nil adNetworkSdk:sdkID mediationUnitId:nil adNetworkUnitId:nil mediationCID:nil adNetworkCID:nil extraData:nil];
        }
        [self.nativeObject showADWithRenderingViewClass:[TPNativeTemplate class] subview:self.adView sceneId:nil];
    }
}

#pragma mark - TradPlusADNativeDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)tpNativeAdLoaded:(NSDictionary *)adInfo
{
//    NSLog(@"%s ", __FUNCTION__ );
    self.logLabel.text = @"AD Loaded";
}

- (void)tpNativeAdLoadFailWithError:(NSError *)error
{
//    NSLog(@"%s ", __FUNCTION__ );
    self.logLabel.text = [NSString stringWithFormat:@"Load Fail：%ld",(long)error.code];
}

- (void)tpNativeAdStartLoad:(NSDictionary *)adInfo
{
//    NSLog(@"%s ", __FUNCTION__ );
}

- (void)tpNativeAdOneLayerStartLoad:(NSDictionary *)adInfo
{
//    NSLog(@"%s ", __FUNCTION__ );
}

- (void)tpNativeAdOneLayerLoaded:(NSDictionary *)adInfo
{
//    NSLog(@"%s ", __FUNCTION__ );
}

- (void)tpNativeAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
//    NSLog(@"%s ", __FUNCTION__ );
}

- (void)tpNativeAdAllLoaded:(BOOL)success
{
//    NSLog(@"%s ", __FUNCTION__ );
}
- (void)tpNativeAdImpression:(NSDictionary *)adInfo
{
//    NSLog(@"%s ", __FUNCTION__ );
}

- (void)tpNativeAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
//    NSLog(@"%s ", __FUNCTION__ );
    
    self.logLabel.text = [NSString stringWithFormat:@"Show Fail：%ld",(long)error.code];
}

- (void)tpNativeAdClicked:(NSDictionary *)adInfo
{
//    NSLog(@"%s ", __FUNCTION__ );
    
    id object = self.nativeObject.customObject;
    if(object != nil)
    {
        [[AppHarbrAdQuality shared] didClickAdWithAdObject:object];
    }
}

- (void)tpNativeAdBidStart:(NSDictionary *)adInfo
{
//    NSLog(@"%s ", __FUNCTION__ );
}

- (void)tpNativeAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
//    NSLog(@"%s ", __FUNCTION__ );
}

- (void)tpNativeAdClose:(NSDictionary *)adInfo
{
//    NSLog(@"%s ", __FUNCTION__ );
    id object = self.nativeObject.customObject;
    if(object != nil)
    {
        [[AppHarbrAdQuality shared] removeAdWithAdObject:object];
    }
}

- (void)tpNativeAdVideoPlayStart:(NSDictionary *)adInfo
{
//    NSLog(@"%s ", __FUNCTION__ );
}

- (void)tpNativeAdVideoPlayEnd:(NSDictionary *)adInfo
{
//    NSLog(@"%s ", __FUNCTION__ );
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

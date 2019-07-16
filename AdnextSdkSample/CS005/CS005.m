//
//  CS005.m
//  ADLibSample
//
//  Created by Mocoplex on 12/12/2018.
//

#import "CS005.h"
#import <Adnext/AdnextSDK.h>

#import "SampleKey.h"

@interface CS005 () <AdnextNetworkAdDelegate>

@property (nonatomic) IBOutlet UIView *adContainerView;

//ALNetwrokAd -> AdnextNetworkAd
@property (nonatomic, strong) AdnextNetworkAd *banner;

@end

@implementation CS005

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}


- (void)dealloc
{
    [self cancelRequest];
    
    [_banner detachFromContainerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadRequest];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self cancelRequest];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //사이즈 재조정이 필요한경우 호출
    [_banner needLayoutSubviews:_adContainerView.bounds];
}

- (void)loadRequest
{
    //ALNetwrokAd -> AdnextNetworkAd
    AdnextNetworkAd *banner = [[AdnextNetworkAd alloc] initWithKey:kJA_IP_INTRO
                                                          delegate:self];
    
    self.banner = banner;
    self.banner.isTestMode  = NO;
    
    //클릭 인앱 처리 - block 등록하시면 사파리 랜딩이 발생하지 않습니다.
    //해당 블록 내부에서 내부 인앱 브라우저 처리하시면 됩니다.
    //추가로 블록 내부에서 self를 바로 사용할경우 메모리 릭이 발생함으로 weakSelf를 통해 접근합니다.
    //    __weak __typeof(self)weakSelf = self;
    //    [banner registerClickEventBlock:^(NSURL *landingUrl) {
    //
    //        NSLog(@"clkurl = %@", landingUrl);
    //
    //        [[UIApplication sharedApplication] openURL:landingUrl];
    //    }];
    
    [banner loadRequestInterstitial];
}

- (void)cancelRequest
{
    [_banner cancelAdRequest];
}

//- (void)alNetworkAdDidReceivedAd:(ALNetworkAd *)networkAd
//-> delegate 명칭 변경.
- (void)adnextNetworkAdDidReceivedAd:(AdnextNetworkAd *)networkAd
{
    NSLog(@"AdnextNetworkAd ReceivedAd");
    
    [networkAd attachToView:_adContainerView withFrame:_adContainerView.bounds];
}

//- (void)alNetworkAd:(ALNetworkAd *)networkAd didFailedAdWithState:(ALNetworkAdResCode)state
//-> delegate 명칭 변경.
- (void)adnextNetworkAd:(AdnextNetworkAd *)networkAd didFailedAdWithState:(AdnextNetworkAdResCode)state
{
    NSLog(@"error state : %@", [AdnextNetworkAd logForResultCode:state]);
}

#pragma mark -

- (IBAction)al_adImpressionAction:(id)sender
{
    if (_banner) {
        if (_banner.isLoaded) {
            [_banner stopLoadingContents];
        } else {
            [_banner loadContents];
        }
    }
}

@end

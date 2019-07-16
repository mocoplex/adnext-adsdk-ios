//
//  CS004.m
//  ADLibSample
//
//  Created by gskang on 2017. 4. 7..
//
//

#import "CS004.h"
#import "SampleKey.h"

#import <Adnext/AdnextSDK.h>
#import "SampleDynamicBannerController.h"


// 전면 광고에 사용할 앱 키
#define kInterSizePort CGSizeMake(320, 480)
#define kInterSizeLand CGSizeMake(480, 320)


@interface CS004 ()

//ALDynamicBannerView -> AdnextDynamicAdView
@property (nonatomic, strong) AdnextDynamicAdView *intersBannerView;
@property (nonatomic, weak) UIViewController *bannerModalViewController;

@end


@implementation CS004

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadAd:(id)sender
{
    [self destroyInterstitialBannerView];
    
    bool isPort = YES;
    
    //디바이회전 상태를 확인하여 상황에 맞는 메소드 호출하도록 변경하여 사용.
    
    if (isPort) {
        
        [self loadPortAd];
        
    } else {
        
        [self loadLandAd];
    }
}

- (void)destroyInterstitialBannerView
{
    if (_intersBannerView) {
        [_intersBannerView setRequestAdStateHandler:nil];
        [_intersBannerView stopAdRequest];
        self.intersBannerView = nil;
    }
}

- (void)loadPortAd
{
    //실제 세로 모드 전면광고에서 사용할 키값과 소재의 사이즈를 수정해서 사용하세요.
    //320, 480으로 지정시 시스템상에 등록된 이미지는 2배수 기준 640, 960 크기의 이미지를 내려받을 수 있습니다.
    
    CGRect bound = CGRectMake(0, 0, kInterSizePort.width, kInterSizePort.height);
    
    //ALDynamicBannerView -> AdnextDynamicAdView
    AdnextDynamicAdView *intersView = [[AdnextDynamicAdView alloc] initWithFrame:bound];
    self.intersBannerView = intersView;
    
    __weak __typeof(self)weakSelf = self;
    
    //ALDynamicBannerState -> AdnextDynamicAdState
    [_intersBannerView setRequestAdStateHandler:^(AdnextDynamicAdState state) {
        
        NSLog(@"_intersBannerView (Port) log state = %@", [AdnextDynamicAd logForBannerState:state]);
        
        switch (state) {
            case AdnextDynamicAdStateRequestStart:
                break;
                
            case AdnextDynamicAdStateReceivedAd:
                [weakSelf al_presentModalViewController];
                break;
                
            case AdnextDynamicAdStateResponseEmptyAd:
                break;
                
            default:
                //Error Case
                break;
        }
    }];
    
    //이미지 외의 영역의 백그라운드 색상 지정
    //해당 함수를 호출하지 않으면 해당 광고 집행시 설정된 색상값으로 채워진다.
    //[_intersBannerView setBannerBackgroundColor:[UIColor blackColor]];
    
    //[_intersBannerView startBannerRequestWithAdlibKey:ADNEXT_INTERSTITIAL_320x480_KEY
    //                                       bannerSize:kInterSize320x480];
    // -> 메소드 변경
    
    [_intersBannerView startBannerRequestWithAdnextKey:kJA_IP_INTRO
                                            bannerSize:kInterSizePort];
}

- (void)loadLandAd
{
    //실제 가로 모드 전면광고에서 사용할 키값과 소재의 사이즈를 수정해서 사용하세요.
    
    CGRect bound = CGRectMake(0, 0, kInterSizeLand.width, kInterSizeLand.height);
    
    //ALDynamicBannerView -> AdnextDynamicAdView
    AdnextDynamicAdView *intersView = [[AdnextDynamicAdView alloc] initWithFrame:bound];
    self.intersBannerView = intersView;
    
    __weak __typeof(self)weakSelf = self;
    
    //ALDynamicBannerState -> AdnextDynamicAdState
    [_intersBannerView setRequestAdStateHandler:^(AdnextDynamicAdState state) {
        
        NSLog(@"_intersBannerView (Port) log state = %@", [AdnextDynamicAd logForBannerState:state]);
        
        switch (state) {
            case AdnextDynamicAdStateRequestStart:
                break;
                
            case AdnextDynamicAdStateReceivedAd:
                [weakSelf al_presentModalViewController];
                break;
                
            case AdnextDynamicAdStateResponseEmptyAd:
                break;
                
            default:
                //Error Case
                break;
        }
    }];
    
    //이미지 외의 영역의 백그라운드 색상 지정
    //해당 함수를 호출하지 않으면 해당 광고에 설정된 색상값으로 채워진다.
    //[_intersBannerView setBannerBackgroundColor:[UIColor blackColor]];
    

    //    [_intersBannerView startBannerRequestWithAdlibKey:ADNEXT_INTERSTITIAL_384x502_KEY
    //                                           bannerSize:kInterSize384x502];
    // -> 연동 메소드 변경
    [_intersBannerView startBannerRequestWithAdnextKey:kJA_IP_INTRO
                                            bannerSize:kInterSizeLand];
}


// 전면광고 수신 후 모달뷰 컨트롤러 표시
- (void)al_presentModalViewController
{
    //내부의 구현은 수정해서 사용가능
    SampleDynamicBannerController *ctr = [[SampleDynamicBannerController alloc] initWithBannerView:self.intersBannerView];
    self.bannerModalViewController = ctr;
    
    [self presentViewController:ctr animated:YES completion:nil];
}

@end

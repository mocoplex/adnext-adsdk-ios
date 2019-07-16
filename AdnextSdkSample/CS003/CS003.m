//
//  CS003.m
//  ADLibSample
//
//  Created by gskang on 2017. 3. 31..
//
//

#import "CS003.h"
#import "SampleKey.h"

#import <Adnext/AdnextSDK.h>

#define kBannerSize CGSizeMake(320, 70)

@interface CS003 ()

//ALDynamicBannerView -> AdnextDynamicAdView
@property (nonatomic, strong) IBOutlet AdnextDynamicAdView *bannerView;

@end

@implementation CS003

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadBannerView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stopBannerView];
}

- (void)dealloc
{
    [self clearBannerView];
}

#pragma mark -  ALAdBannerView Code

- (void)loadBannerView
{
    //핸들러 블럭코드의 경우 별도로 처리할 내용이 없을경우 등록하지 않고 사용해도 상관없음.
    __weak __typeof(self)weakSelf = self;
    
    //ALDynamicBannerState -> AdnextDynamicAdState
    [_bannerView setRequestAdStateHandler:^(AdnextDynamicAdState state) {
        
        NSLog(@"_intersBannerView (Port) log state = %@", [AdnextDynamicAd logForBannerState:state]);
        switch (state) {
            case AdnextDynamicAdStateRequestStart:
                break;
                
            case AdnextDynamicAdStateReceivedAd:
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
    //[_bannerView setBannerBackgroundColor:[UIColor blackColor]];

    //ALDynamicBannerView 해당 클래스는 x초 이후 자동 갱신기능은 지원하지 않음.
    //광고교체가 필요한 시점에 아래 메소드를 다시 호출해주어야한다.
    //해당 클래스는 이미지광고만 지원합니다. 비디오광고 지원X
    //bannerSize에 원하는 광고 슬롯 소재 사이즈를 입력합니다. (320*50 / 320*70 / 320*100)
    //bannerSize로 세팅된 크기로 집행된 광고만 수신받을수 있습니다.
    
    
    //[_bannerView startBannerRequestWithAdlibKey:kTEST_KEY_ADNEXTHOUSE
    //                                 bannerSize:kBannerSize320x70];
    //-> 메소드 변경
    [_bannerView startBannerRequestWithAdnextKey:kJA_CS_BOTTOM
                                      bannerSize:kBannerSize];
}

- (void)stopBannerView
{
    [_bannerView stopAdRequest];
}

- (void)clearBannerView
{
    if (_bannerView) {
        [_bannerView setRequestAdStateHandler:nil];
        [_bannerView stopAdRequest];
        self.bannerView = nil;
    }
}


@end

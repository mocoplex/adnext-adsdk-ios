//
//  ALNetworkBanner.h
//  Adnext
//
//  Created by Mocoplex on 2018. 5. 16..
//  Copyright © 2018년 mocoplex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AdnextNetworkBannerResCode) {
    
    AdnextNetworkBannerCodeReceivedAd = 0,      //광고 응답 성공
    
    AdnextNetworkBannerCodeEmptyAd = 9000,      //광고 응답 실패 - 광고 없음
    AdnextNetworkBannerCodeInvalidKey,          //요청 매체키 에러
    AdnextNetworkBannerCodeSessionError,        //애드넥스트 세션연결 실패 에러
    AdnextNetworkBannerCodeNetworkError,        //요청 네트워크 에러
};

@class AdnextNetworkBanner;

@protocol AdnextNetworkBannerDelegate <NSObject>

- (void)adnextNetworkBannerDidReceivedAd:(AdnextNetworkBanner *)networkAd;
- (void)adnextNetworkBanner:(AdnextNetworkBanner *)networkAd didFailedAdWithState:(AdnextNetworkBannerResCode)state;

@end

// 구버전 클래스명 : ALNetworkBanner
@interface AdnextNetworkBanner : NSObject {
    
}

@property (nonatomic) BOOL isTestMode;  //default : NO

@property (nonatomic, readonly) BOOL isLoaded;

/**
 *  애드넥스트 키값으로 초기화합니다.
 *  애드넥스트 설정 세션 연결은 내부적으로 처리됩니다.
 */
- (id)initWithKey:(NSString *)key delegate:(id<AdnextNetworkBannerDelegate>)delegate;

// 전면 배너 요청
- (BOOL)loadRequestInterstitial;

// 광고 요청 취소
- (void)cancelAdRequest;

// 배너 뷰 화면에 노출 처리
- (BOOL)attachToView:(UIView *)adContainerView withFrame:(CGRect)frame;

// 배너 뷰 화면에서 제거 처리
- (void)detachFromContainerView;

// 배너 뷰의 프레임을 재조정할 필요가 있을 경우 호출
- (void)needLayoutSubviews:(CGRect)frame;


// 광고 컨텐츠 로딩 시작
- (BOOL)loadContents;

// 광고 컨텐츠 로딩 중지
- (void)stopLoadingContents;

// 인앱 브라우저를 사용할경우 클릭 이벤트 처리 등록 (옵션 - 등록하지 않은 경우 내부에서 사파리 랜딩 처리)
- (void)registerClickEventBlock:(void (^)(NSURL *landingUrl))block;

+ (NSString *)logForResultCode:(AdnextNetworkBannerResCode)state;

@end

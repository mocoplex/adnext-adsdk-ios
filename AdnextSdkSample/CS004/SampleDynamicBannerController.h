//
//  ALDynamicBannerController.h
//  Adlib
//
//  Created by gskang on 2015. 10. 28..
//  Copyright © 2015년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Adnext/AdnextSDK.h>

@interface SampleDynamicBannerController : UIViewController

//ALDynamicBannerView -> AdnextDynamicAdView
- (instancetype)initWithBannerView:(AdnextDynamicAdView *)bannerView;

@end

//
//  ALAdBackFillView.h
//  Adnext
//
//  Created by gskang on 2017. 1. 11..
//  Copyright © 2017년 mocoplex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdnextBackFillView;

@protocol AdnextBackFillViewDelegate <NSObject>

@optional
- (void)adnextBackFillView:(AdnextBackFillView *)view shouldLinkClicked:(NSURL *)link;

@end


@interface AdnextBackFillView : UIView {
    
}

@property (nonatomic, weak) id<AdnextBackFillViewDelegate> delegate;

- (void)setBackgroundImage:(UIImage *)image;
- (void)loadBackFillUrl:(NSURL *)url;

@end

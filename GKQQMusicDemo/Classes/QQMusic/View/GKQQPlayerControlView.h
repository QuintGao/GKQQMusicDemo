//
//  GKQQPlayerControlView.h
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GKQQPlayerControlViewDelegate <NSObject>

@optional

@end

@interface GKQQPlayerControlView : UIView

@property (nonatomic, weak) id<GKQQPlayerControlViewDelegate> delegate;

@property (nonatomic, assign) float value;
@property (nonatomic, copy) NSString *currentTime;
@property (nonatomic, copy) NSString *totalTime;

- (void)showLoadingAnim;
- (void)hideLoadingAnim;

- (void)setupPlayBtn;
- (void)setupPauseBtn;

@end

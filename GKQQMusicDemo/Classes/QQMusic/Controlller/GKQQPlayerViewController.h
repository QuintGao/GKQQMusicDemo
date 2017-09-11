//
//  GKQQPlayerViewController.h
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import <GKNavigationBarViewController/GKNavigationBarViewController.h>

#define QQPlayerVC [GKQQPlayerViewController sharedInstance]

@interface GKQQPlayerViewController : GKNavigationBarViewController

@property (nonatomic, copy) NSString *currentMusicId;

@property (nonatomic, assign) BOOL isPlaying;

+ (instancetype)sharedInstance;

- (void)playMusicWithIndex:(NSInteger)index musicList:(NSArray *)musicList;

- (void)playMusic;
- (void)pauseMusic;
- (void)stopMusic;

- (void)playPrevMusic;
- (void)playNextMusic;

@end

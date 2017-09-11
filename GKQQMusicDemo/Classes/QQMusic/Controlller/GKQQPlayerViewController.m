//
//  GKQQPlayerViewController.m
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import "GKQQPlayerViewController.h"
#import "GKQQPlayerControlView.h"
#import "GKQQLyricView.h"
#import "GKPlayer.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface GKQQPlayerViewController ()<GKPlayerDelegate, GKQQPlayerControlViewDelegate>

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) GKQQLyricView *lyricView;

@property (nonatomic, strong) GKQQPlayerControlView *controlView;

#pragma mark - Data
@property (nonatomic, strong) NSArray *musicList;
@property (nonatomic, strong) NSArray *lyricList;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval currentTime;

@property (nonatomic, assign) BOOL isAutoPlay;

@property (nonatomic, assign) BOOL isDraging;

@property (nonatomic, assign) BOOL isSeeking;
@property (nonatomic, strong) NSTimer *seekTimer;

@property (nonatomic, strong) GKQQMusicModel *model;

@property (nonatomic, strong) NSDictionary *songDic;

@end

@implementation GKQQPlayerViewController

+ (instancetype)sharedInstance {
    static GKQQPlayerViewController *playerVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerVC = [GKQQPlayerViewController new];
    });
    return playerVC;
}

- (instancetype)init {
    if (self = [super init]) {
        
        [self.view addSubview:self.bgImageView];
        
        [self.view addSubview:self.lyricView];
        
        [self.view addSubview:self.controlView];
        
        [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(180);
        }];
        
        [self.lyricView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(74);
            make.bottom.equalTo(self.controlView.mas_top);
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self addNotifications];
    
    kPlayer.delegate = self;
}

- (void)dealloc {
    [self removeNotifications];
}


#pragma mark - Private Methods 

- (void)setupUI {
    self.view.backgroundColor     = [UIColor whiteColor];
    self.gk_navBackgroundColor    = [UIColor clearColor];
    
    self.gk_navRightBarButtonItem = [UIBarButtonItem itemWithImageName:@"player_icon_more" target:self action:@selector(moreClick)];
}

- (void)getMusicInfo {
    self.gk_navigationItem.title = self.model.music_name;
    
    if (self.isPlaying) {
        self.isPlaying = NO;
        [kPlayer stop];
    }
    
    // 初始化数据
    self.lyricList = nil;
    self.lyricView.lyrics = nil;
    
    self.controlView.value = 0;
    self.controlView.currentTime = @"00:00";
    self.controlView.totalTime   = @"00:00";
    [self.controlView showLoadingAnim];
    
    // 获取歌曲信息
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"http://music.baidu.com/data/music/links?songIds=%@", self.model.music_id];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *songDic = [dic[@"data"][@"songList"] firstObject];
        self.songDic = songDic;
        // 背景图
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:songDic[@"songPicRadio"]]];
        // 设置播放地址并播放
        kPlayer.playUrlStr = songDic[@"songLink"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [kPlayer play];
        });
        
        // 解析歌词
        self.lyricList = [GKLyricParser lyricParserWithUrl:songDic[@"lrcLink"]];
        
        self.lyricView.lyrics = self.lyricList;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}

- (void)addNotifications {
    
}

- (void)removeNotifications {
    
}

- (void)moreClick {
    
}

#pragma mark - Notifications



#pragma mark - Public Methods

- (void)playMusicWithIndex:(NSInteger)index musicList:(NSArray *)musicList {
    self.musicList = musicList;
    
    GKQQMusicModel *model = musicList[index];
    if (![model.music_id isEqualToString:self.currentMusicId]) {
        self.currentMusicId = model.music_id;
        
        // 记录播放的id，以便下次进入时直接播放
        [[NSUserDefaults standardUserDefaults] setValue:model.music_id forKey:kPlayerLastPlayKey];
        
        self.model = model;
        
        [self getMusicInfo];
    }
}

- (void)playMusic {
    if (kPlayer.status != GKPlayerStatusPaused) {
        [kPlayer play];
    }else {
        [kPlayer resume];
    }
}

- (void)pauseMusic {
    [kPlayer pause];
}

- (void)stopMusic {
    [kPlayer stop];
}

- (void)playPrevMusic {
    
}

- (void)playNextMusic {
    
}

#pragma mark - 代理

#pragma mark - GKPlayerDelegate
- (void)gkPlayer:(GKPlayer *)player statusChanged:(GKPlayerStatus)status {
    switch (status) {
        case GKPlayerStatusBuffering:
        {
            [self.controlView setupPauseBtn];
            
            self.isPlaying = NO;
        }
            break;
        case GKPlayerStatusPlaying:
        {
            [self.controlView hideLoadingAnim];
            [self.controlView setupPlayBtn];
            self.isPlaying = YES;
        }
            break;
        case GKPlayerStatusPaused:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.controlView setupPauseBtn];
            });
            self.isPlaying = NO;
        }
            break;
        case GKPlayerStatusStopped:
        {
            NSLog(@"播放停止了");
            [self.controlView setupPauseBtn];
            self.isPlaying = NO;
        }
            break;
        case GKPlayerStatusEnded:
        {
            NSLog(@"播放结束了");
            if (self.isPlaying) {
                [self.controlView setupPauseBtn];
                self.isPlaying = NO;
                
                self.controlView.currentTime = self.controlView.totalTime;
                
                // 播放结束，自动播放下一首
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.isAutoPlay = YES;
                    
                    [self playNextMusic];
                });
            }else {
                [self.controlView setupPauseBtn];
                self.isPlaying = NO;
            }
        }
            break;
        case GKPlayerStatusError:
        {
            NSLog(@"播放出错了");
            [self.controlView setupPauseBtn];
            self.isPlaying = NO;
        }
            break;
            
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WYMusicPlayStateChanged" object:nil];
}

- (void)gkPlayer:(GKPlayer *)player duration:(NSTimeInterval)duration {
    self.controlView.totalTime = [GKTool timeStrWithMsTime:duration];
    
    self.duration = duration;
}

- (void)gkPlayer:(GKPlayer *)player currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime progress:(float)progress {
    if (self.isDraging) return;
    if (self.isSeeking) return;
    
    self.controlView.currentTime = [GKTool timeStrWithMsTime:currentTime];
    self.controlView.value = progress;
    
    // 更新锁屏界面
    
    // 滚动歌词
    if (!self.isPlaying) return;
    
    [self.lyricView scrollLyricWithCurrentTime:currentTime totalTime:totalTime];
}

#pragma mark - 懒加载
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectView.frame = _bgImageView.bounds;
        [_bgImageView addSubview:effectView];
    }
    return _bgImageView;
}

- (GKQQPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [GKQQPlayerControlView new];
    }
    return _controlView;
}

- (GKQQLyricView *)lyricView {
    if (!_lyricView) {
        _lyricView = [GKQQLyricView new];
    }
    return _lyricView;
}

@end

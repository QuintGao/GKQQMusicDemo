//
//  GKQQPlayerControlView.m
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import "GKQQPlayerControlView.h"

#import "GKSliderView.h"

@interface GKQQPlayerControlView()<GKSliderViewDelegate>

@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) UILabel *currentLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) GKSliderView *slider;

@property (nonatomic, strong) UIButton *loopBtn;
@property (nonatomic, strong) UIButton *prevBtn;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *listBtn;

@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *downloadBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *commentBtn;

@end

@implementation GKQQPlayerControlView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.sliderView];
        [self.sliderView addSubview:self.currentLabel];
        [self.sliderView addSubview:self.totalLabel];
        [self.sliderView addSubview:self.slider];
        
        [self addSubview:self.loopBtn];
        [self addSubview:self.prevBtn];
        [self addSubview:self.playBtn];
        [self addSubview:self.nextBtn];
        [self addSubview:self.listBtn];
        
        [self addSubview:self.loveBtn];
        [self addSubview:self.downloadBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.commentBtn];
        
        // 添加约束
        [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(10);
            make.height.mas_equalTo(30);
        }];
        
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sliderView).offset(50);
            make.right.equalTo(self.sliderView).offset(-50);
            make.top.bottom.equalTo(self.sliderView);
        }];
        
        [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.slider.mas_left).offset(-25);
            make.centerY.equalTo(self.sliderView);
        }];
        
        [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.slider.mas_right).offset(25);
            make.centerY.equalTo(self.sliderView);
        }];
        
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sliderView.mas_bottom).offset(0);
            make.centerX.equalTo(self);
        }];
        
        [self.prevBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.playBtn.mas_centerY);
            make.right.equalTo(self.playBtn.mas_left).offset(-20);
        }];
        
        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.playBtn.mas_centerY);
            make.left.equalTo(self.playBtn.mas_right).offset(20);
        }];
        
        [self.loopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self.playBtn.mas_centerY);
        }];
        
        [self.listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self.playBtn.mas_centerY);
        }];
        
        [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.playBtn.mas_bottom).offset(10);
            make.right.equalTo(self.mas_centerX).offset(-15);
        }];
        
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.downloadBtn.mas_centerY);
            make.left.equalTo(self.mas_centerX).offset(15);
        }];
        
        [self.loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.downloadBtn.mas_left).offset(-30);
            make.centerY.equalTo(self.downloadBtn.mas_centerY);
        }];
        
        [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shareBtn.mas_right).offset(30);
            make.centerY.equalTo(self.downloadBtn.mas_centerY);
        }];
    }
    return self;
}

- (void)setValue:(float)value {
    _value = value;
    
    self.slider.value = value;
}

- (void)setCurrentTime:(NSString *)currentTime {
    _currentTime = currentTime;
    
    self.currentLabel.text = currentTime;
}

- (void)setTotalTime:(NSString *)totalTime {
    _totalTime = totalTime;
    
    self.totalLabel.text = totalTime;
}

- (void)showLoadingAnim {
    [self.slider showLoading];
}

- (void)hideLoadingAnim {
    [self.slider hideLoading];
}

- (void)setupPlayBtn {
    [self.playBtn setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"player_btn_pause_highlight"] forState:UIControlStateHighlighted];
}

- (void)setupPauseBtn {
    [self.playBtn setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"player_btn_play_highlight"] forState:UIControlStateHighlighted];
}

#pragma mark - UserAction

#pragma mark - GKSliderViewDelegate
- (void)sliderTouchBegin:(float)value {
    
}

- (void)sliderTouchEnded:(float)value {
    
}

- (void)sliderTapped:(float)value {
    
}

- (void)sliderValueChanged:(float)value {
    
}

#pragma mark - Btn Action
- (void)loopBtnClick:(id)sender {
    
}


- (void)prevBtnClick:(id)sender {
    
}

- (void)playBtnClick:(id)sender {
    
}

- (void)nextBtnClick:(id)sender {
    
}

- (void)listBtnClick:(id)sender {
    
}

- (void)loveBtnClick:(id)sender {
    
}

- (void)downloadBtnClick:(id)sender {
    
}

- (void)shareBtnClick:(id)sender {
    
}

- (void)commentBtnClick:(id)sender {
    
}

#pragma mark - 懒加载
- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [UIView new];
        _sliderView.backgroundColor = [UIColor clearColor];
    }
    return _sliderView;
}

- (UILabel *)currentLabel {
    if (!_currentLabel) {
        _currentLabel = [UILabel new];
        _currentLabel.textColor = [UIColor whiteColor];
        _currentLabel.font = [UIFont systemFontOfSize:13.0];
        _currentLabel.text = @"00:00";
    }
    return _currentLabel;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [UILabel new];
        _totalLabel.textColor = [UIColor whiteColor];
        _totalLabel.font = [UIFont systemFontOfSize:13.0];
        _totalLabel.text = @"00:00";
    }
    return _totalLabel;
}

- (GKSliderView *)slider {
    if (!_slider) {
        _slider = [GKSliderView new];
        _slider.maximumTrackImage = [UIImage imageNamed:@"player_slider_playback_right"];
        _slider.minimumTrackImage = [UIImage imageNamed:@"player_slider_playback_left"];
        [_slider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
        [_slider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateSelected];
        [_slider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateHighlighted];
        _slider.sliderHeight = 2.0;
    }
    return _slider;
}

- (UIButton *)loopBtn {
    if (!_loopBtn) {
        _loopBtn = [UIButton new];
        [_loopBtn setImage:[UIImage imageNamed:@"player_btn_repeat_normal"] forState:UIControlStateNormal];
        [_loopBtn setImage:[UIImage imageNamed:@"player_btn_repeat_highlight"] forState:UIControlStateHighlighted];
        [_loopBtn addTarget:self action:@selector(loopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loopBtn;
}

- (UIButton *)prevBtn {
    if (!_prevBtn) {
        _prevBtn = [UIButton new];
        [_prevBtn setImage:[UIImage imageNamed:@"player_btn_pre_normal"] forState:UIControlStateNormal];
        [_prevBtn setImage:[UIImage imageNamed:@"player_btn_pre_highlight"] forState:UIControlStateHighlighted];
        [_prevBtn addTarget:self action:@selector(prevBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _prevBtn;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton new];
        [_playBtn setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"player_btn_play_highlight"] forState:UIControlStateHighlighted];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton new];
        [_nextBtn setImage:[UIImage imageNamed:@"player_btn_next_normal"] forState:UIControlStateNormal];
        [_nextBtn setImage:[UIImage imageNamed:@"player_btn_next_highlight"] forState:UIControlStateHighlighted];
        [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (UIButton *)listBtn {
    if (!_listBtn) {
        _listBtn = [UIButton new];
        [_listBtn setImage:[UIImage imageNamed:@"player_btn_playlist_normal"] forState:UIControlStateNormal];
        [_listBtn setImage:[UIImage imageNamed:@"player_btn_playlist_highlight"] forState:UIControlStateHighlighted];
        [_listBtn addTarget:self action:@selector(listBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _listBtn;
}

- (UIButton *)loveBtn {
    if (!_loveBtn) {
        _loveBtn = [UIButton new];
        [_loveBtn setImage:[UIImage imageNamed:@"player_btn_favorite_normal"] forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"player_btn_favorite_highlight"] forState:UIControlStateHighlighted];
        [_loveBtn addTarget:self action:@selector(loveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}

- (UIButton *)downloadBtn {
    if (!_downloadBtn) {
        _downloadBtn = [UIButton new];
        [_downloadBtn setImage:[UIImage imageNamed:@"player_btn_download_normal"] forState:UIControlStateNormal];
        [_downloadBtn setImage:[UIImage imageNamed:@"player_btn_download_highlight"] forState:UIControlStateHighlighted];
        [_downloadBtn addTarget:self action:@selector(downloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton new];
        [_shareBtn setImage:[UIImage imageNamed:@"player_btn_share_normal"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"player_btn_share_highlight"] forState:UIControlStateHighlighted];
        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [UIButton new];
        [_commentBtn setImage:[UIImage imageNamed:@"player_btn_comment_normal"] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"player_btn_comment_highlight"] forState:UIControlStateHighlighted];
        [_commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}



@end

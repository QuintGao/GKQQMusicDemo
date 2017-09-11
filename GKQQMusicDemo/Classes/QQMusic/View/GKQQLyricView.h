//
//  GKQQLyricView.h
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//  歌词列表

#import <UIKit/UIKit.h>
#import "GKLyricParser.h"

@interface GKQQLyricView : UIView

/** 歌词数据 */
@property (nonatomic, strong) NSArray *lyrics;
@property (nonatomic, assign) NSInteger lyricIndex;

/** 是否将要拖拽歌词 */
@property (nonatomic, assign) BOOL isWillDraging;
/** 是否正在滚动歌词 */
@property (nonatomic, assign) BOOL isScrolling;

- (void)scrollLyricWithCurrentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime;

@end

static NSString *GKQQLyricCellID = @"GKQQLyricCellID";

@interface GKQQLyricCell : UITableViewCell
/** 歌词文本 */
@property (nonatomic, copy) NSString *lyric;
/** 歌词进度 */
@property (nonatomic, assign) CGFloat progress;

@end

@interface GKQQLyricLabel : UILabel

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) UIColor *progressColor;

@end

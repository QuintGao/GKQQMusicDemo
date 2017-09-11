//
//  GKQQLyricView.m
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import "GKQQLyricView.h"
#import "GKTool.h"

@interface GKQQLyricView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *lyricTable;

@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation GKQQLyricView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.lyricTable];
        [self.lyricTable addSubview:self.tipsLabel];
        
        [self.lyricTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.lyricTable);
        }];
    }
    return self;
}

- (void)setLyrics:(NSArray *)lyrics {
    _lyrics = lyrics;
    
    if (lyrics) {
        if (lyrics.count == 0) {
            self.tipsLabel.hidden = NO;
            self.tipsLabel.text = @"纯音乐，无歌词";
            
            [self.lyricTable reloadData];
        }else {
            self.tipsLabel.hidden = YES;
            [self.lyricTable reloadData];
            
            [self.lyricTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }else {
        self.tipsLabel.hidden = NO;
        self.tipsLabel.text   = @"歌词加载中...";
        
        [self.lyricTable reloadData];
    }
}

- (void)scrollLyricWithCurrentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime{
    if (self.lyrics.count == 0) self.lyricIndex = 0;
    
    for (NSInteger i = 0; i < self.lyrics.count; i++) {
        GKLyricModel *currentLyric = self.lyrics[i];
        GKLyricModel *nextLyric = nil;
        
        if (i < self.lyrics.count - 1) {
            nextLyric = self.lyrics[i + 1];
        }
        
        if ((self.lyricIndex != i && currentTime >= currentLyric.msTime) && (!nextLyric || currentTime < nextLyric.msTime)) {
            
            // 获取当前歌词和上一句歌词的indexpath
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            NSIndexPath *prevIndexPath = [NSIndexPath indexPathForRow:self.lyricIndex inSection:0];
            
            
            self.lyricIndex = i;
            
            // 刷新
//            [self.lyricTable reloadRowsAtIndexPaths:@[indexPath, prevIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.lyricTable reloadData];
            
            // 不是由拖拽产生的滚动，自动滚动歌词
            if (!self.isScrolling) {
                [self.lyricTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:(self.lyricIndex + 5) inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            }
        }
        
        // 刷新歌词进度
        if (self.lyricIndex == i) {
            // 粗略计算  歌词进度 = (当前播放时间 - 当前歌词的开始时间) / (下一句歌词的开始时间 - 当前歌词的开始时间)
            // 这里如果最后一句不是空行，则计算的是总时间减去最后一句的时间，导致最后一句非常慢，不准确，估计QQ音乐有更精确的歌词格式，才会计算的那么准确
            NSTimeInterval lineTime = nextLyric ? (nextLyric.msTime - currentLyric.msTime) : (totalTime - currentLyric.msTime);
            
            CGFloat progress = (currentTime - currentLyric.msTime) / lineTime;
            
            // 获取对应的行
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.lyricIndex + 5 inSection:0];
            GKQQLyricCell *cell = [self.lyricTable cellForRowAtIndexPath:indexPath];
            // 设置进度
            cell.progress = progress;
        }
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lyrics.count + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GKQQLyricCell *cell = [tableView dequeueReusableCellWithIdentifier:GKQQLyricCellID forIndexPath:indexPath];
    
    cell.progress = 0;
    
    if (indexPath.row < 5 || indexPath.row > self.lyrics.count + 4) {
        cell.lyric = @"";
    }else {
        GKLyricModel *lyricModel = self.lyrics[indexPath.row - 5];
        cell.lyric = lyricModel.content;
        if (indexPath.row != self.lyricIndex + 5) {
            cell.progress = 0;
        }
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isWillDraging = YES;
    // 取消前面的延时操作
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    self.isScrolling = YES;
    // 设置时间
    self.timeLabel.hidden = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.isWillDraging = NO;
        
        [self performSelector:@selector(endedScroll) withObject:nil afterDelay:1.0];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    self.isScrolling = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.isWillDraging = NO;
    
    [self performSelector:@selector(endedScroll) withObject:nil afterDelay:1.0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isScrolling) return;  // 不是由拖拽产生的滚动
    // 获取滚动距离
    CGFloat offsetY = scrollView.contentOffset.y;
    // 根据滚动距离计算行数 （滚动距离 + tableview高度的一半）/ 行高 + 5 - 1
    NSInteger index = (offsetY + self.lyricTable.frame.size.height / 2) / 44 - 5 + 1;
    // 获取歌词模型
    GKLyricModel *model = nil;
    if (index < 0) {
        model = self.lyrics.firstObject;
    }else if (index > self.lyrics.count - 1) {
        model = nil;
    }else {
        model = self.lyrics[index];
    }
    
    // 设置时间
    if (model) {
        self.timeLabel.text   = [GKTool timeStrWithMsTime:model.msTime];
        self.timeLabel.hidden = NO;
    }else {
        self.timeLabel.hidden = YES;
    }
}

- (void)endedScroll {
    if (self.isWillDraging) return;
    
    self.timeLabel.hidden = YES;
    
    [self performSelector:@selector(endScrolling) withObject:nil afterDelay:4.0];
}

- (void)endScrolling {
    if (self.isWillDraging) return;
    self.isScrolling = NO;
}

#pragma mark - 懒加载
- (UITableView *)lyricTable {
    if (!_lyricTable) {
        _lyricTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _lyricTable.dataSource = self;
        _lyricTable.delegate   = self;
        _lyricTable.backgroundColor = [UIColor clearColor];
        _lyricTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_lyricTable registerClass:[GKQQLyricCell class] forCellReuseIdentifier:GKQQLyricCellID];
    }
    return _lyricTable;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel              = [UILabel new];
        _tipsLabel.textColor    = [UIColor whiteColor];
        _tipsLabel.font         = [UIFont systemFontOfSize:16.0];
        _tipsLabel.hidden       = YES;
    }
    return _tipsLabel;
}

@end

@interface GKQQLyricCell()

@property (nonatomic, strong) GKQQLyricLabel *lyricLabel;

@end

@implementation GKQQLyricCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.lyricLabel];
        [self.lyricLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setLyric:(NSString *)lyric {
    _lyric = lyric;
    
    self.lyricLabel.text = lyric;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    self.lyricLabel.progress = progress;
}

- (GKQQLyricLabel *)lyricLabel {
    if (!_lyricLabel) {
        _lyricLabel = [GKQQLyricLabel new];
        _lyricLabel.textColor = [UIColor whiteColor];
        _lyricLabel.progressColor = GKQQMainColor;
        _lyricLabel.font = [UIFont systemFontOfSize:16.0];
        _lyricLabel.numberOfLines = 0;
        _lyricLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _lyricLabel;
}

@end

@implementation GKQQLyricLabel

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.progressColor set];
    
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

@end

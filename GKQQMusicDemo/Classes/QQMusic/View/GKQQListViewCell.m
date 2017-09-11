//
//  GKQQListViewCell.m
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import "GKQQListViewCell.h"

@interface GKQQListViewCell()
@property (weak, nonatomic) IBOutlet UIView *playView;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;

@end

@implementation GKQQListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lineH.constant = 0.5;
    
    self.playView.hidden = YES;
}

- (void)setModel:(GKQQMusicModel *)model {
    _model = model;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%zd", self.row + 1];
    
    self.nameLabel.text = model.music_name;
    self.artistLabel.text = model.music_artist;
    
    if (model.isPlaying) {
        self.playView.hidden = NO;
        
        self.numberLabel.textColor = GKQQMainColor;
        self.nameLabel.textColor = GKQQMainColor;
        self.artistLabel.textColor = GKQQMainColor;
    }else {
        self.playView.hidden = YES;
        
        self.numberLabel.textColor = [UIColor lightGrayColor];
        self.artistLabel.textColor = [UIColor lightGrayColor];
        
        self.numberLabel.textColor = [UIColor blackColor];
    }
}


@end

//
//  GKQQListViewCell.h
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const GKQQListViewCellID = @"GKQQListViewCellID";

@interface GKQQListViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, strong) GKQQMusicModel *model;

@end

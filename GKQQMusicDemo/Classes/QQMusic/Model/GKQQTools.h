//
//  GKQQTools.h
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKQQTools : NSObject

+ (void)saveMusics:(NSArray *)musics;

+ (NSArray *)musics;

+ (NSInteger)indexFromMusicID:(NSString *)musicId;

@end

@interface GKQQMusicModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *music_id;

@property (nonatomic, copy) NSString *music_name;

@property (nonatomic, copy) NSString *music_artist;

@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, assign) BOOL isLike;

@end

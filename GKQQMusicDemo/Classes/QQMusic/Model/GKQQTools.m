//
//  GKQQTools.m
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/10.
//  Copyright © 2017年 高坤. All rights reserved.
//

#define kDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"audio.json"]

#import "GKQQTools.h"

@implementation GKQQTools

+ (void)saveMusics:(NSArray *)musics {
    [NSKeyedArchiver archiveRootObject:musics toFile:kDataPath];
}

+ (NSArray *)musics {
    NSArray *musics = [NSKeyedUnarchiver unarchiveObjectWithFile:kDataPath];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"json"];

    NSArray *localMusics = [NSArray yy_modelArrayWithClass:[GKQQMusicModel class] json:[NSData dataWithContentsOfFile:path]];
    
    if (musics.count != localMusics.count) {
        musics = localMusics;
    }
    
    return musics;
}

+ (NSInteger)indexFromMusicID:(NSString *)musicId {
    __block NSInteger index = 0;
    
    [[self musics] enumerateObjectsUsingBlock:^(GKQQMusicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.music_id isEqualToString:musicId]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

@end

@implementation GKQQMusicModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"music_id"       : @"id",
             @"music_name"     : @"name",
             @"music_artist"   : @"artist"};
}

- (BOOL)isPlaying {
    return [self.music_id isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:kPlayerLastPlayKey]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

@end

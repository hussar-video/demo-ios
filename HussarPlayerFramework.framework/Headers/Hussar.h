//
//  Hussar.h
//  IJKMediaPlayer
//
//  Created by HussarPlayer on 2016/12/22.
//  Copyright © 2016年 HussarPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hussar : NSObject

+ (instancetype)shareInstance;

+ (void)key:(NSString *)key UserName:(NSString *)username;

+ (BOOL)isAuthor;

@end

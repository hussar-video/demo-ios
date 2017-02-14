//
//  HussarPlayerViewController.h
//  IJKMediaPlayer
//
//  Created by HussarPlayer on 2016/12/18.
//  Copyright © 2016年 HussarPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 播放器按钮
 
 - HussarPlayerButtonPlay: 播放按钮
 - HussarPlayerButtonPause: 暂停按钮
 - HussarPlayerButtonStop: 停止按钮
 - HussarPlayerButtonSeek: seek操作
 - HussarPlayerButtonClose: 关闭按钮
 */
typedef NS_ENUM(NSUInteger, HussarPlayerButtonEvent) {
    HussarPlayerButtonPlay,
    HussarPlayerButtonPause,
    HussarPlayerButtonStop,
    HussarPlayerButtonSeek,
    HussarPlayerButtonClose,
};

/**
 播放器状态

 - HussarPlayerStateLoading: 加载中
 - HussarPlayerStatePlaying: 播放中
 - HussarPlayerStatePause: 暂停播放
 - HussarPlayerStateStop: 停止播放
 - HussarPlayerStateSeeking: seek中
 - HussarPlayerStateBuffering: 缓冲中
 */
typedef NS_ENUM(NSUInteger, HussarPlayerState) {
    HussarPlayerStateLoading,
    HussarPlayerStatePlaying,
    HussarPlayerStatePause,
    HussarPlayerStateStop,
    HussarPlayerStateSeeking,
    HussarPlayerStateBuffering,
};

/**
 缓冲类型

 - HussarBufferFirstLoad: 首次加载缓冲
 - HussarBufferNormal: 播放过程中卡顿
 - HussarBufferSeek: Seek卡顿
 */
typedef NS_ENUM(NSUInteger, HussarBufferType) {
    HussarBufferFirstLoad,
    HussarBufferNormal,
    HussarBufferSeek,
};


@protocol HussarPlayerViewControllerDelegate <NSObject>
@optional

/**
 已加载完毕事件
 */
- (void) onPrepared;

/**
 开始渲染第一帧事件
 */
- (void) onRenderStart;

/**
 开始播放事件
 */
- (void) onStart;

/**
 暂停播放事件
 */
- (void) onPause;

/**
 开始缓冲事件
 
 @param type HussarBufferType 卡顿类型
 */
- (void) onBufferingStart:(HussarBufferType)type;

/**
 缓冲中事件
 
 @param percent 缓冲百分比
 */
- (void) onBuffering:(int)percent;

/**
 缓冲结束事件
 */
- (void) onBufferingEnd;

/**
 seek结束事件
 
 @param position seek到最新的位置
 */
- (void) onSeekComplete:(int)position;

/**
 播放完成事件
 */
- (void) onCompletion;

/**
 播放器定时器
 */
- (void)updateHussarTime;
/**
 播放报错信息
 
 @param what 错误主类
 @param extra 错误详细类别
 @return 是否需要停止播放,仅对非严重错误有效
 */
- (BOOL) onError:(int)what Extra:(int)extra;

/**
 按钮事件回调
 
 @param buttonEvent 按钮类型
 @param info 按钮附带信息
 */

- (void)hussarPlayerButtonEvent:(HussarPlayerButtonEvent)buttonEvent Info:(NSDictionary *)info;

@end

@interface HussarPlayerViewController : NSObject

@property (nonatomic, weak) id<HussarPlayerViewControllerDelegate> delegate;

@property (nonatomic, readonly)UIView *view;

/**
 按钮控制层，默认存在，可自由定制
 */
@property (nonatomic, readonly) UIView *controlView;
/**
 播放器当前状态
 */
@property (nonatomic, readonly) HussarPlayerState playerState;

/**
 视频总时长(直播视频该值为 nan )
 */
@property (nonatomic, readonly) NSTimeInterval duration;

/**
 视频已播放时长
 */
@property (nonatomic, readonly) NSTimeInterval playbackTime;

/**
 视频已缓存时长
 */
@property (nonatomic, readonly) NSTimeInterval playableDuration;

/**
 初始化播放器(默认点播播放器)
 
 @param url 播放地址
 @return 播放器实例
 */
- (instancetype)initWithURL:(NSURL *)url;

/**
 初始化播放器
 
 @param url 播放地址
 @param isLiving : YES(直播)、NO(点播)
 @return 播放器实例
 */
- (instancetype)initWithURL:(NSURL *)url isLiving:(BOOL)isLiving;

/**
 播放
 */
- (void)play;

/**
 暂停
 */
- (void)pause;

/**
 终止播放
 */
- (void)stop;

/**
 seek

 @param time 秒
 */
- (void)seek:(NSTimeInterval)time;

/**
 播放器是否正在播放中
 
 @return YES(播放中) or NO
 */
- (BOOL)isPlaying;

@end

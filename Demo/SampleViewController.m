//
//  SampleViewController.m
//  Demo
//
//  Created by Lee on 2017/2/14.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import "SampleViewController.h"
#import <HussarPlayerFramework/HussarFramework.h>

@interface SampleViewController ()<HussarPlayerViewControllerDelegate>{

}
@property (nonatomic, strong) HussarPlayerViewController *player;
@property (weak, nonatomic) IBOutlet UIView *playerview;
@property (nonatomic, strong) NSURL* streamURL;
@end

@implementation SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)playURL:(NSURL *)url{
    if (self.player) {
        [self.player stop];
        [self.player.view removeFromSuperview];
    }
    [HussarPlayerViewController setMaxBufferSize:5 * 1024 * 1024];//设置5MB缓冲大小
    
    self.player = [[HussarPlayerViewController alloc]initWithURL:url];
    self.player.delegate = self;
    self.player.view.frame = self.playerview.bounds;
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    [self.playerview addSubview:self.player.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.player stop];
}

#pragma mark - ButtonEvent

- (IBAction)clickNextButton:(id)sender {
    [self playURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"]];
}
#pragma mark - HussarPlayerViewControllerDelegate
/**
 已加载完毕事件
 */
- (void) onPrepared{
    NSLog(@"onPrepared");
}

/**
 开始渲染第一帧事件
 */
- (void) onRenderStart{
    NSLog(@"onRenderStart");
}

/**
 开始播放事件
 */
- (void) onStart{
    NSLog(@"onStart");
}

/**
 暂停播放事件
 */
- (void) onPause{
    NSLog(@"onPause");
}

/**
 开始缓冲事件
 
 @param type HussarBufferType 卡顿类型
 */
- (void) onBufferingStart:(HussarBufferType)type{
    NSLog(@"onBufferingStart");
}

/**
 缓冲中事件
 
 @param percent 缓冲百分比
 */
- (void) onBuffering:(int)percent{
    NSLog(@"onBuffering");
}

/**
 缓冲结束事件
 */
- (void) onBufferingEnd{
    NSLog(@"onBufferingEnd");
}

/**
 seek结束事件
 
 @param position seek到最新的位置
 */
- (void) onSeekComplete:(int)position{
    NSLog(@"onSeekComplete");
}

/**
 播放完成事件
 */
- (void) onCompletion{
    NSLog(@"onCompletion");
}

- (void)updateHussarTime{
    NSLog(@"updateHussarTime:%f,%f",self.player.playbackTime,self.player.duration);
}

/**
 播放报错信息
 
 @param what 错误主类
 @param extra 错误详细类别
 @return 是否需要停止播放,仅对非严重错误有效
 */
- (BOOL) onError:(int)what Extra:(int)extra{
    NSLog(@"onError");
    return NO;
}

/**
 按钮事件回调
 
 @param buttonEvent 按钮类型
 @param info 按钮附带信息
 */

- (void)hussarPlayerButtonEvent:(HussarPlayerButtonEvent)buttonEvent Info:(NSDictionary *)info{
    NSLog(@"");
    if (buttonEvent == HussarPlayerButtonClose) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end

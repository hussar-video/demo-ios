//
//  Sample2ViewController.m
//  Demo
//
//  Created by Lee on 2017/2/14.
//  Copyright © 2017年 Lee. All rights reserved.
//

#import "Sample2ViewController.h"
#import <HussarPlayerFramework/HussarFramework.h>
#import "HussarVideoCell.h"

@interface Sample2ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,HussarPlayerViewControllerDelegate>

@property (nonatomic, strong) HussarPlayerViewController *player;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataSource;

@property(nonatomic, assign)CGFloat contentOffsetY;
@property(nonatomic, weak)HussarVideoCell *playingVideoCell;
//@property (nonatomic, )
@end

@implementation Sample2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.dataSource =[[NSMutableArray alloc]initWithObjects:
                      @[@{@"pic":@"1.jpg"},@{@"playurl":@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"}],
                      @[@{@"pic":@"2.jpg"},@{@"playurl":@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"}],
                      @[@{@"pic":@"3.jpg"},@{@"playurl":@"http://120.25.226.186:32812/resources/videos/minion_03.mp4"}],
                      @[@{@"pic":@"4.jpg"},@{@"playurl":@"http://120.25.226.186:32812/resources/videos/minion_04.mp4"}],
                      @[@{@"pic":@"5.jpg"},@{@"playurl":@"http://120.25.226.186:32812/resources/videos/minion_05.mp4"}],
                      @[@{@"pic":@"6.jpg"},@{@"playurl":@"http://120.25.226.186:32812/resources/videos/minion_06.mp4"}],
                      @[@{@"pic":@"7.jpg"},@{@"playurl":@"http://120.25.226.186:32812/resources/videos/minion_07.mp4"}],
                      nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self playVideoInVisiableCells:YES];
}

- (void)playURL{
    if (self.player) {
        [self.player stop];
        [self.player.view removeFromSuperview];
    }
    self.player = [[HussarPlayerViewController alloc]initWithURL:self.playingVideoCell.playURL];
    self.player.delegate = self;
    self.player.view.frame = self.playingVideoCell.playerview.bounds;
    self.player.controlView.hidden = YES;
    [self.playingVideoCell.playerview addSubview:self.player.view];
}

- (void)dealloc{
    [self.player stop];
}

#pragma mark - TableviewDelegate
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 311;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HussarVideoCell";
    HussarVideoCell *cell = (HussarVideoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    NSArray *data = [self.dataSource objectAtIndex:indexPath.row];
    cell.videoImageView.image = [UIImage imageNamed:[[data firstObject] objectForKey:@"pic"]];
    cell.playURL = [NSURL URLWithString:[[data objectAtIndex:1] objectForKey:@"playurl"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

/**
 * Called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
 * 松手时已经静止, 只会调用scrollViewDidEndDragging
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging:%f,%f",scrollView.contentOffset.y,scrollView.contentSize.height);
    if (decelerate == NO) {
        // scrollView已经完全静止
        NSLog(@"scrollViewDidEndDragging decelerate");
        [self playVideoInVisiableCells:NO];
    }
}

/**
 * Called on tableView is static after finger up if the user dragged and tableView is scrolling.
 * 松手时还在运动, 先调用scrollViewDidEndDragging, 再调用scrollViewDidEndDecelerating
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating:%f",scrollView.contentOffset.y);
    // scrollView已经完全静止
    [self playVideoInVisiableCells:NO];
}
-(void)playVideoInVisiableCells:(BOOL)isFirst{
    NSArray *visiableCells = [self.tableview visibleCells];
    HussarVideoCell *videocell = nil;
    if (visiableCells.count == 3) {
        videocell = [visiableCells objectAtIndex:1];
    }else if (visiableCells.count == 2){
        videocell = [visiableCells lastObject];
    }else{
        NSLog(@"visiable error");
    }
    
    if (isFirst) {
        videocell = [visiableCells firstObject];
    }
    
    if (self.playingVideoCell == videocell) {
        
    }else{
        
        self.playingVideoCell.playerview.backgroundColor = [UIColor clearColor];
        self.playingVideoCell = videocell;
        self.playingVideoCell.playerview.backgroundColor = [UIColor blackColor];
        [self playURL];
    }
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    self.contentOffsetY = scrollView.contentOffset.y;
//    NSLog(@"contentOffsetY:%f",self.contentOffsetY);
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
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
#pragma mark -
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end

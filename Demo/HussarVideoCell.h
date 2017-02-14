//
//  HussarVideoCell.h
//  HussarDemo
//
//  Created by Lee on 2017/1/19.
//  Copyright © 2017年 Hussar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HussarVideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIView *playerview;
@property (strong, nonatomic)NSURL *playURL;
@end

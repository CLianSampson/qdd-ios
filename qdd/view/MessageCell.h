//
//  MessageCell.h
//  qdd
//
//  Created by Apple on 17/2/19.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property(nonatomic,strong)UILabel *mainTitle;
@property(nonatomic,strong)UILabel *subTitle;
@property(nonatomic,strong)UILabel *time;

@property(nonatomic,strong)UIImageView *icon;

@end

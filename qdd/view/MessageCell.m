//
//  MessageCell.m
//  qdd
//
//  Created by Apple on 17/2/19.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "MessageCell.h"
#import "Macro.h"

@implementation MessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 92*HEIGHT_SCALE-25, 50, 50)];
        icon.image=[UIImage imageNamed:@"消息图标"];
        [self.contentView addSubview:icon];
        
        
        UILabel *qddLabel = [[UILabel alloc]initWithFrame:CGRectMake((30+32)*WIDTH_SCALE+50, 48*HEIGHT_SCALE, 150, 32*HEIGHT_SCALE)];
        qddLabel.text = @"签多多电子章上线了";
        qddLabel.textAlignment=NSTextAlignmentLeft;
        qddLabel.font=[UIFont systemFontOfSize:24];
        qddLabel.textColor=RGBColor(0, 0, 0);
        [self.contentView addSubview:qddLabel];
        
        
        UILabel *signLabel = [[UILabel alloc]initWithFrame:CGRectMake((30+32)*WIDTH_SCALE+50, (48+32+26)*HEIGHT_SCALE, 150, 28*HEIGHT_SCALE)];
        signLabel.text = @"一键签约，多功能同步，提升功...";
        signLabel.textAlignment=NSTextAlignmentLeft;
        signLabel.font=[UIFont systemFontOfSize:22];
        signLabel.textColor=RGBColor(136 , 136, 136);
        [self.contentView addSubview:signLabel];
        
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-32*WIDTH_SCALE-150, 48*HEIGHT_SCALE, 150, 28*HEIGHT_SCALE)];
        timeLabel.text = @"今天10点";
        timeLabel.textAlignment=NSTextAlignmentRight;
        timeLabel.font=[UIFont systemFontOfSize:15];
        timeLabel.textColor=RGBColor(180 , 180, 180);
        [self.contentView addSubview:timeLabel];
        

    }
    
    return self;
}


- (void)drawRect:(CGRect)rect{
   
}

@end

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
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 92*HEIGHT_SCALE-25, 50, 50)];
        _icon.image=[UIImage imageNamed:@"消息图标"];
        [self.contentView addSubview:_icon];
        
        
        _mainTitle = [[UILabel alloc]initWithFrame:CGRectMake((30+32)*WIDTH_SCALE+50, 48*HEIGHT_SCALE, 150, 32*HEIGHT_SCALE)];
        _mainTitle.text = @"签多多电子章上线了";
        _mainTitle.textAlignment=NSTextAlignmentLeft;
        _mainTitle.font=[UIFont systemFontOfSize:16];
        _mainTitle.textColor=RGBColor(0, 0, 0);
        [self.contentView addSubview:_mainTitle];
        
        
        _subTitle = [[UILabel alloc]initWithFrame:CGRectMake((30+32)*WIDTH_SCALE+50, (48+32+26)*HEIGHT_SCALE, 150, 28*HEIGHT_SCALE)];
        _subTitle.text = @"一键签约，多功能同步，提升工作效率，降低人工成本，保障合同安全 ";
        _subTitle.textAlignment=NSTextAlignmentLeft;
        _subTitle.font=[UIFont systemFontOfSize:14];
        _subTitle.textColor=RGBColor(136 , 136, 136);
        [self.contentView addSubview:_subTitle];
        
        
        _time = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-32*WIDTH_SCALE-150, 48*HEIGHT_SCALE, 150, 28*HEIGHT_SCALE)];
        _time.text = @"今天10点";
        _time.textAlignment=NSTextAlignmentRight;
        _time.font=[UIFont systemFontOfSize:10];
        _time.textColor=RGBColor(180 , 180, 180);
        [self.contentView addSubview:_time];
        

    }
    
    return self;
}


- (void)drawRect:(CGRect)rect{
   
}

@end

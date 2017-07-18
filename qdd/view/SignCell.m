//
//  SignCell.m
//  qdd
//
//  Created by Apple on 17/3/7.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignCell.h"
#import "Macro.h"

@implementation SignCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSLog(@"self.frame.size.width is : %f" ,self.frame.size.width);
        
        _signName = [[UILabel alloc]initWithFrame:CGRectMake(34*WIDTH_SCALE, 44*HEIGHT_SCALE, 200, 13)];
        _signName.text=@"合同名称: 仲裁委";
        _signName.font=[UIFont boldSystemFontOfSize:13];
        _signName.textColor=RGBColor(0, 0, 0);
        [self addSubview:_signName];
        
        
        _state = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-34*2*WIDTH_SCALE-200, 44*HEIGHT_SCALE, 200, 13)];
        _state.textColor=RGBColor(255, 0, 23);
        _state.text=@"待我签署";
        _state.textAlignment=NSTextAlignmentRight;
        _state.font=[UIFont systemFontOfSize:13];
        [self addSubview:_state];
        
        UILabel *sepreate =[[UILabel alloc]initWithFrame:CGRectMake(34*WIDTH_SCALE, _signName.frame.origin.y+_signName.frame.size.height+28*HEIGHT_SCALE, SCREEN_WIDTH-2*34*WIDTH_SCALE, 1)];
        sepreate.backgroundColor=RGBColor(209, 209, 209);
        [self addSubview:sepreate];
        
        _sendPerson  =[[UILabel alloc]initWithFrame:CGRectMake(34*WIDTH_SCALE, sepreate.frame.origin.y+46*HEIGHT_SCALE, self.frame.size.width, 11)];
        _sendPerson.text=@"发送人: 136-6666-6666";
        _sendPerson.font=[UIFont systemFontOfSize:13];
        [self addSubview:_sendPerson];
        
        _sendTime = [[UILabel alloc]initWithFrame:CGRectMake(34*WIDTH_SCALE, _sendPerson.frame.origin.y+_sendPerson.frame.size.height+20*HEIGHT_SCALE, 200, 11)];
        _sendTime.text=@"发送时间: 2017-03-18 10:12:23";
        _sendTime.font=[UIFont systemFontOfSize:12];
        [self addSubview:_sendTime];
        
        _duration = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-34*2*WIDTH_SCALE-200, _sendPerson.frame.origin.y+_sendPerson.frame.size.height+20*HEIGHT_SCALE, 200, 11)];
        _duration.text=@"签约有限期: 15天";
        _duration.font=[UIFont systemFontOfSize:12];
        _duration.textAlignment=NSTextAlignmentRight;
        [self addSubview:_duration];

       
        
    }
    
    return self;
}

//该方法比 initWithStyle 先执行
- (void)setFrame:(CGRect)frame {

    
    NSLog(@"kkkkkkkkk");
    
    frame.origin.x += 20*WIDTH_SCALE;
    
    frame.size.width -= 2 * 20*WIDTH_SCALE;
    
    [super setFrame:frame];
}

@end

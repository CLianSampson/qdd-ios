//
//  SignContentCell.m
//  qdd
//
//  Created by Apple on 17/4/2.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SignContentCell.h"
#import "Macro.h"

@implementation SignContentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSLog(@"self.frame.size.width is : %f" ,self.frame.size.width);
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(47*WIDTH_SCALE, 23*HEIGHT_SCALE, 18, 18)];
        [self addSubview:_icon];
        
        
        _send = [[UILabel alloc]initWithFrame:CGRectMake(_icon.frame.origin.x+_icon.frame.size.width + 20, 26*HEIGHT_SCALE, 300, 14)];
        _send.font=[UIFont systemFontOfSize:14];
        [self addSubview:_send];
       
        _mail = [[UILabel alloc]initWithFrame:CGRectMake(_icon.frame.origin.x+_icon.frame.size.width + 20, _send.frame.origin.y+_send.frame.size.height + 18*HEIGHT_SCALE, 300, 14)];
         _mail.font=[UIFont systemFontOfSize:14];
        [self addSubview:_mail];

        
        
    }
    
    return self;
}

////该方法比 initWithStyle 先执行
//- (void)setFrame:(CGRect)frame {
//    
//    
//    NSLog(@"kkkkkkkkk");
//    
//    frame.origin.x += 20*WIDTH_SCALE;
//    
//    frame.size.width -= 2 * 20*WIDTH_SCALE;
//    
//    [super setFrame:frame];
//}


@end

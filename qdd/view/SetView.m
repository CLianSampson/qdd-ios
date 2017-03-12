//
//  SetView.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "SetView.h"
#import "Macro.h"

@interface SetView()<UIGestureRecognizerDelegate>{
}

@end

@implementation SetView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        _times = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 60)];
        
        _times.text=@"100元/10次";
        _times.textAlignment=NSTextAlignmentCenter;
        _times.textColor=RGBColor(0, 51, 102);
        _times.layer.borderColor=[UIColor blackColor].CGColor;
        _times.layer.borderWidth=1;
        _times.layer.cornerRadius=5;
        
        _times.font=[UIFont systemFontOfSize:12];
        [self addSubview:_times];
        
        
        _type = [[UILabel alloc]initWithFrame:CGRectMake(0, 60+20*HEIGHT_SCALE, frame.size.width, 12)];
        _type.font=[UIFont systemFontOfSize:12];
        _type.text=@"个人套餐A";
        _type.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_type];
        
        
        _content = [[UILabel alloc]initWithFrame:CGRectMake(10, _type.frame.origin.y+12+18*HEIGHT_SCALE, frame.size.width-20, 28)];
        _content.text=@"购买标准化电子合同服务...";
        _content.font=[UIFont systemFontOfSize:9];
        _content.textColor=RGBColor(65, 65, 65);
        _content.numberOfLines=0;
        [self addSubview:_content];
        
        
        
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleTap];
        
        
    }
    
    return self;
}



-(void)handleSingleTap:(UITapGestureRecognizer *)sender

{
    
    [self.delegate jumpDetail:_setId];
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    
    return YES;
    
}

@end

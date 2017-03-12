//
//  MessageDetailView.m
//  qdd
//
//  Created by Apple on 17/3/12.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "MessageDetailView.h"
#import "Macro.h"

@implementation MessageDetailView

-(instancetype)init{
    if (self=[super init]) {
        _mainTitle = [[UILabel alloc]init];
        _subTitle =[[UILabel alloc]init];
        _sepreate =[[UILabel alloc]init];
        
        
        _mainTitle.font=[UIFont boldSystemFontOfSize:16];
        
        
        _subTitle.font=[UIFont systemFontOfSize:14];
        _subTitle.textColor=GrayRGBColor;
        
        
       

        
        self.layer.cornerRadius = 6;
    }
    
    return  self;
}

@end

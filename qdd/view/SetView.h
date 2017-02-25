//
//  SetView.h
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetDelegate <NSObject>

-(void)jumpDetail:(int )setId;

@end

@interface SetView : UIView

@property(nonatomic,strong) UILabel *times;
@property(nonatomic,strong) UILabel *type;
@property(nonatomic,strong) UILabel *content;

@property(nonatomic,assign) id<SetDelegate> delegate;


@property(nonatomic,assign) int setId;

@end

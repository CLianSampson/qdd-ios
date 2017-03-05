//
//  AddContactView.h
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol addContactProtocol <NSObject>

-(void)addContact;

@end

@interface AddContactView : UIView


@property(nonatomic,strong) UIButton *icon;

@property(nonatomic,strong) UILabel *account;

@property(nonatomic,strong) UILabel *name;



@end

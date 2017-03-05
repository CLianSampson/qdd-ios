//
//  AddContactVC.m
//  qdd
//
//  Created by Apple on 17/3/5.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "AddContactVC.h"
#import "Macro.h"
#import "AddContactView.h"


@interface AddContactVC()<UISearchBarDelegate>

@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)UILabel *noContactLabel;

@property(nonatomic,strong)AddContactView *addContactView;

@property(nonatomic,strong)UIButton *addContactbutton;

@end

@implementation AddContactVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"添加";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];

    
    [self createView];

    
}


-(void)createView{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    backgroundView.backgroundColor=RGBColor(241, 241, 241);
    [self.view addSubview:backgroundView];
    
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 85*HEIGHT_SCALE)];
    self.searchBar.delegate=self;
    self.searchBar.placeholder=@"请输入个人手机号/企业邮箱帐号";
    [self.view addSubview:self.searchBar];
    
    
    UIView *background = [[UIView alloc]initWithFrame:CGRectMake(0, 64+85*HEIGHT_SCALE, SCREEN_WIDTH, SCREEN_HEIGHT-64-85*HEIGHT_SCALE)];
    background.backgroundColor=RGBColor(247, 247, 247);
    [self.view addSubview:background];
    
    
    _noContactLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+85*HEIGHT_SCALE+40, SCREEN_WIDTH, 15)];
    _noContactLabel.text=@"该用户不存在";
    _noContactLabel.textAlignment=NSTextAlignmentCenter;
    _noContactLabel.font=[UIFont systemFontOfSize:29];
    _noContactLabel.textColor=RGBColor(174, 174, 174);
    
    
    _addContactView = [[AddContactView alloc]initWithFrame:CGRectMake(20*WIDTH_SCALE, 64+30*HEIGHT_SCALE, SCREEN_WIDTH-20*2*WIDTH_SCALE, 83*HEIGHT_SCALE+68)];
    _addContactView.layer.borderWidth=1;
    _addContactView.layer.borderColor=RGBColor(201, 201, 201 ).CGColor;
    _addContactView.layer.cornerRadius=3;
    
    
    _addContactbutton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-300/2, _addContactView.frame.origin.y+_addContactView.frame.size.height+160*HEIGHT_SCALE, 300, 41)];
    [_addContactbutton setBackgroundImage:[UIImage imageNamed:@"添加联系人按钮"] forState:UIControlStateNormal];
    [_addContactbutton setTitle:@"添加联系人" forState:UIControlStateNormal];
   

}

-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma -mark searchbar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if ([searchBar.text isEqualToString:@"123"]) {
        [self.view addSubview:_noContactLabel];
    }
    
    
    if ([searchBar.text isEqualToString:@"234"]) {
        
        [searchBar removeFromSuperview];
        
        [self.view addSubview:_addContactView];
        [self.view addSubview:_addContactbutton];
    }
    
    [searchBar resignFirstResponder]; //searchBar失去焦点
//    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
//    cancelBtn.enabled = YES; //把enabled设置为yes
    
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    [_noContactLabel removeFromSuperview];
    
    
    [_addContactView removeFromSuperview];
    [_addContactbutton removeFromSuperview];
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    [_noContactLabel removeFromSuperview];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [_noContactLabel removeFromSuperview];

}


@end




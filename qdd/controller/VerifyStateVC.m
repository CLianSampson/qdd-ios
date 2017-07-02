//
//  VerifyStateVC.m
//  qdd
//
//  Created by Apple on 17/4/20.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "VerifyStateVC.h"

@implementation VerifyStateVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    [super createNavition];
    self.mytitle.text=@"实名认证";
    
    [super createBackgroungView];
    
    
    [self creteView];
    
}



-(void)creteView{
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-35, 65+110*HEIGHT_SCALE, 70, 70)];
    icon.image = [UIImage imageNamed:@"实名认证图标"];
    [self.view addSubview:icon];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, icon.frame.origin.y+icon.frame.size.height + 56*HEIGHT_SCALE, SCREEN_WIDTH, 18)];
    
    if (self.verifyState == HAVE_VERIFY) {
        label.text = @"您已经过实名认证";
    }else{
        label.text = @"您正在实名认证中";
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:label];
}





-(void)showLeft{
    [self.sideMenuViewController setContentViewController:self.VC];
    //    [self.sideMenuViewController hideMenuViewController];
    [self.sideMenuViewController presentLeftMenuViewController];
    
}





@end

//
//  ShoppingDetailVC.m
//  qdd
//
//  Created by Apple on 17/2/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "ShoppingDetailVC.h"
#import "Macro.h"
#import "PayVC.h"


@interface ShoppingDetailVC()
{
    
    
}

@property(nonatomic,strong)UILabel *type;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *total;
@property(nonatomic,strong)UILabel *introduction;
@property(nonatomic,strong)UILabel *number;


@end

@implementation ShoppingDetailVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
   
}

-(void)viewDidLoad{
    //解决卡顿问题
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [self.view addSubview:leftButton];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"套餐详情";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:17];
    [self.view addSubview:label];
    
    [self creatView];
    
    [self netRequest];
}


-(void)creatView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,  259*HEIGHT_SCALE)];
    imageView.backgroundColor=RGBColor(235, 239, 242);
    [self.view addSubview:imageView];
    
    
    UILabel *backGroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height, SCREEN_WIDTH, 34*HEIGHT_SCALE)];
    backGroundLabel.backgroundColor=RGBColor(247, 247, 247);
    [self.view addSubview:backGroundLabel];
    
    
    _type = [[UILabel alloc]initWithFrame:CGRectMake(52*WIDTH_SCALE, backGroundLabel.frame.origin.y+backGroundLabel.frame.size.height, 300, 13*SCALE)];
    _type.text=@"套餐类型:  个人套餐A";
    _type.textColor=RGBColor(51, 51, 51);
    _type.font=[UIFont boldSystemFontOfSize:13];
    [self.view addSubview:_type];
    
    
    
    _time = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-52*WIDTH_SCALE-300, backGroundLabel.frame.origin.y+backGroundLabel.frame.size.height, 300, 13*SCALE)];
    _time.text=@"有效期:  10天";
    _time.textColor=RGBColor(255, 0, 0);
    _time.font=[UIFont systemFontOfSize:11];
    _time.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:_time];
    
    
    _total = [[UILabel alloc]initWithFrame:CGRectMake(52*WIDTH_SCALE,_time.frame.origin.y+_time.frame.size.height+57*HEIGHT_SCALE , 300, 12*SCALE)];
    _total.text=@"总次数:  10次";
    _total.font=[UIFont systemFontOfSize:12];
    _total.textColor=RGBColor(0, 0, 0);
    [self.view addSubview:_total];
    
    
    _introduction = [[UILabel alloc]initWithFrame:CGRectMake(52*WIDTH_SCALE, _total.frame.origin.y+_total.frame.size.height+22*HEIGHT_SCALE, SCREEN_WIDTH-2*52*WIDTH_SCALE, 24+15*HEIGHT_SCALE)];
    _introduction.text=@"购买标准化电子合同服务，该套餐可以签发合同一次，有效期为永久";
    _introduction.numberOfLines = 0; ///相当于不限制行数
    _introduction.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:_introduction];
    

    
    
    UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-98*HEIGHT_SCALE, SCREEN_WIDTH, 98*HEIGHT_SCALE)];
    footLabel.backgroundColor=RGBColor(247, 247, 247);
    [self.view addSubview:footLabel];
    
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-98*HEIGHT_SCALE, 60, 98*HEIGHT_SCALE)];
    money.text=@"￥";
    money.font=[UIFont systemFontOfSize:15];
    money.textColor=RGBColor(255, 0, 0);
    money.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:money];
    
    _number = [[UILabel alloc]initWithFrame:CGRectMake(money.frame.size.width, SCREEN_HEIGHT-98*HEIGHT_SCALE, 60, 98*HEIGHT_SCALE)];
    _number.text=@"100";
    _number.font=[UIFont systemFontOfSize:14];
    _number.textColor=RGBColor(255, 0, 0);
    _number.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:_number];
    
    
    UIButton *pay = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-98*HEIGHT_SCALE+(98*HEIGHT_SCALE-28)/2, 80, 28)];
    [pay setTitle:@"立即购买" forState:UIControlStateNormal];
    [pay setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
    pay.titleLabel.font=[UIFont systemFontOfSize:13];
    [pay setBackgroundImage:[UIImage imageNamed:@"立即购买按钮"] forState:UIControlStateNormal];
    [self.view addSubview:pay];
    
    [pay addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)showLeft{
        [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)pay{
    PayVC *VC = [[PayVC alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


-(void)netRequest{
    //https://www.qiandd.com/mobile/goods/goods/token/4add3a80c92238fef58691fddd450c26/id/11/p/1
    _setId=1;
    
    NSLog(@"token is :%@",self.token);
    
    NSString *idstring = [NSString stringWithFormat:@"%d",_setId];
    NSMutableString  *urlstring=[NSMutableString stringWithString:URL_GOODS_DETAIL];
    [urlstring appendString:self.token];
    [urlstring appendString:@"id/"];
    [urlstring appendString:idstring];
    [urlstring appendString:@"/p/1"];
    
    __weak typeof(self) weakSelf=self;
    
    AFNetRequest *request = [[AFNetRequest alloc]init];
    
    request.netSucessBlock=^(id result){
        
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf doSucess:result];
            
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf.indicator removeFromSuperview];
            
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
        
        
    };
    
    request.netFailedBlock=^(id result){
        [weakSelf.indicator removeFromSuperview];
        
        [weakSelf createAlertView];
        weakSelf.alertView.title=@"网络有点问题哦，无法加载";
        [weakSelf.alertView show];
    };
    
    [request netRequestGetWithUrl:urlstring Data:nil];
    
}

-(void)doSucess:(id )result{
    NSDictionary *data = [result objectForKey:@"data"];
    if (data==nil || [data isEqual:[NSNull null]]) {
        return ;
    }
    
    NSArray *arry = [data objectForKey:@"goods"];
    if (arry==nil ||  [arry isEqual:[NSNull null]] || arry.count==0 ) {
        
        [self createAlertView];
        self.alertView.title=@"没有套餐信息";
        [self.alertView show];
    }else{
        
        for (NSDictionary *data in arry) {
            NSString *name = [data objectForKey:@"name"];
            if ([StringUtil isNullOrBlank:name]) {
                name = @" ";
            }
            NSString *type = [data objectForKey:@"name"];
            if ([type isEqual:@"0"]) {
                type = @"个人套餐";
            }else{
                type = @"企业套餐";
            }
            NSMutableString *mutableString = [[NSMutableString alloc]initWithString:type];
            [mutableString appendString:@"  "];
            [mutableString appendString:name];
            _type.text = mutableString;
            
            NSString *contents = [data objectForKey:@"contents"];
            if ([StringUtil isNullOrBlank:contents]) {
                contents = @" ";
            }
            _introduction.text = contents;
            
            NSString *price = [data objectForKey:@"price"];
            if ([StringUtil isNullOrBlank:price]) {
                price = @" ";
            }
            
            
            NSString *num = [data objectForKey:@"num"];
            if ([StringUtil isNullOrBlank:num]) {
                num = @" ";
            }
            NSMutableString *mutableNum = [[NSMutableString alloc]initWithString:num];
            [mutableNum appendString:@"次"];
            _total.text = mutableNum;
            
            
            NSString *dtime = [data objectForKey:@"dtime"];
            if ([StringUtil isNullOrBlank:dtime]) {
                dtime = @" ";
            }
            NSMutableString *mutabledtime = [[NSMutableString alloc]initWithString:dtime];
            [mutabledtime appendString:@"天"];
            _time.text = mutabledtime;
        }
    }
    
}






@end

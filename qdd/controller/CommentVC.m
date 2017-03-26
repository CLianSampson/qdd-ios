//
//  CommentVC.m
//  qdd
//
//  Created by Apple on 17/3/11.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "CommentVC.h"
#import "Macro.h"
#import "UILabel+Adjust.h"


@interface CommentVC()

@property(nonatomic,strong)UIButton *defaultButton;

@property(nonatomic,strong)UIButton *signProblem;

@property(nonatomic,strong)UIButton *payProblem;
@property(nonatomic,strong)UIButton *setProblem;


@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,assign)int type;

@end

@implementation CommentVC


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _type=0;
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 31, 22, 22)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左面返回箭头"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    
    UIButton  *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40-30*WIDTH_SCALE, 31, 40, 22)];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [rightButton setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 31,100,22)];
    label.text=@"意见反馈";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:label];
    
   
    
    [self creatView];
    
}



-(void)creatView{
    [super createBackgroungView];
    
    UILabel *choose =[[UILabel alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, 65+15*HEIGHT_SCALE, SCREEN_WIDTH, 17)];
    choose.text=@"请选择问题类型";
    choose.font=[UIFont systemFontOfSize:14];
    choose.textColor=GrayRGBColor;
    [self.view addSubview:choose];
    
    
    float width = (SCREEN_WIDTH-2*49*WIDTH_SCALE-38*3*WIDTH_SCALE)/4;
    
    
    _defaultButton = [[UIButton alloc]initWithFrame:CGRectMake(49*WIDTH_SCALE, choose.frame.origin.y+choose.frame.size.height+20*HEIGHT_SCALE, width, 28)];
    [_defaultButton setTitle:@"默认" forState:UIControlStateNormal];
    [_defaultButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形选中"] forState:UIControlStateNormal];
    _defaultButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    _defaultButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [_defaultButton addTarget:self action:@selector(defaultClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_defaultButton];
    
    
    _signProblem = [[UIButton alloc]initWithFrame:CGRectMake(38*WIDTH_SCALE+_defaultButton.frame.origin.x+_defaultButton.frame.size.width, choose.frame.origin.y+choose.frame.size.height+20*HEIGHT_SCALE, width, 28)];
    [_signProblem setTitle:@"合同问题" forState:UIControlStateNormal];
    [_signProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    _signProblem.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    if (iPhone4||iPhone5) {
        _signProblem.titleLabel.font=[UIFont systemFontOfSize:13];
    }else{
        _signProblem.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    [_signProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];
     [_signProblem addTarget:self action:@selector(signClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_signProblem];
    
    
    
    _payProblem = [[UIButton alloc]initWithFrame:CGRectMake(38*WIDTH_SCALE+_signProblem.frame.origin.x+_signProblem.frame.size.width, choose.frame.origin.y+choose.frame.size.height+20*HEIGHT_SCALE, width, 28)];
    [_payProblem setTitle:@"支付问题" forState:UIControlStateNormal];
    [_payProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    _payProblem.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    if (iPhone4||iPhone5) {
        _payProblem.titleLabel.font=[UIFont systemFontOfSize:13];
    }else{
        _payProblem.titleLabel.font=[UIFont systemFontOfSize:14];
    }

    [_payProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];
     [_payProblem addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payProblem];
    
    

    _setProblem = [[UIButton alloc]initWithFrame:CGRectMake(38*WIDTH_SCALE+_payProblem.frame.origin.x+_payProblem.frame.size.width, choose.frame.origin.y+choose.frame.size.height+20*HEIGHT_SCALE, width, 28)];
    [_setProblem setTitle:@"套餐问题" forState:UIControlStateNormal];
    [_setProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    _setProblem.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    if (iPhone4||iPhone5) {
        _setProblem.titleLabel.font=[UIFont systemFontOfSize:13];
    }else{
        _setProblem.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    [_setProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    [_setProblem addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_setProblem];
    
    UILabel *upperSepreate =[[UILabel alloc]initWithFrame:CGRectMake(0, _setProblem.frame.origin.y+_setProblem.frame.size.height+20*HEIGHT_SCALE, SCREEN_WIDTH, 1)];
    upperSepreate.backgroundColor=SepreateRGBColor;
    [self.view addSubview:upperSepreate];
    

    _textView =[[UITextView alloc]initWithFrame:CGRectMake(0, upperSepreate.frame.origin.y+upperSepreate.frame.size.height+1, SCREEN_WIDTH, 150)];
    _textView.backgroundColor=[UIColor whiteColor];
    _textView.textColor=GrayRGBColor;
    _textView.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_textView];
    
    
    UILabel *underSepreate =[[UILabel alloc]initWithFrame:CGRectMake(0, _textView.frame.origin.y+_textView.frame.size.height+1, SCREEN_WIDTH, 1)];
    underSepreate.backgroundColor=SepreateRGBColor;
    [self.view addSubview:underSepreate];
    
    
    
    UILabel *remind =[[UILabel alloc]initWithFrame:CGRectMake(30*WIDTH_SCALE, underSepreate.frame.origin.y+underSepreate.frame.size.height+10, SCREEN_WIDTH-30*WIDTH_SCALE, 100)];
    remind.numberOfLines=0;
    remind.font=[UIFont systemFontOfSize:14];
    remind.textColor=BlueRGBColor;
    remind.text=@"注: 问题的回复的工作时间为: 周一至周五，9:00-18:00, 请耐心等待工作人员回复。";
    float height = [UILabel getHeightByWidth:remind.frame.size.width title:remind.text font:remind.font];
    remind.frame=CGRectMake(30*WIDTH_SCALE, underSepreate.frame.origin.y+underSepreate.frame.size.height+10, SCREEN_WIDTH-30*WIDTH_SCALE, height);
    [self.view addSubview:remind];
}


-(void)showLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}


-(void)defaultClick{
    _type=0;
     [_defaultButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形选中"] forState:UIControlStateNormal];
    [_defaultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [_signProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_signProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    
    [_payProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_payProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];

    [_setProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_setProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];

    
}

-(void)signClick{
    _type=1;
    [_signProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形选中"] forState:UIControlStateNormal];
    [_signProblem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [_defaultButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_defaultButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    
    [_payProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_payProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    
    [_setProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_setProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];

}

-(void)payClick{
    _type=2;
    [_payProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形选中"] forState:UIControlStateNormal];
    [_payProblem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [_signProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_signProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    
    [_defaultButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_defaultButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    
    [_setProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_setProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];
}

-(void)setClick{
    _type=3;
    [_setProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形选中"] forState:UIControlStateNormal];
    [_setProblem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [_signProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_signProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    
    [_defaultButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_defaultButton setTitleColor:BlueRGBColor forState:UIControlStateNormal];
    
    [_payProblem setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [_payProblem setTitleColor:BlueRGBColor forState:UIControlStateNormal];

}


-(void)commitClick{
    [super createAlertView];
    
    if ([_textView.text isEqualToString:@""]) {
        self.alertView.title=@"评论内容不能为空";
        [self.alertView show];
        
        return;
    }
    
    [self netRequest];
    

    
}



-(void)netRequest{
    
    NSString *mutableUrl =[NSMutableString stringWithString:URL_COMMENT];
    NSString *url = [mutableUrl stringByAppendingString:self.token];
    
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
   
    
    NSString *type = [NSString stringWithFormat:@"%d",_type];
    [dic setObject:type forKey:@"type"];
    [dic setObject:_textView.text forKey:@"question"];
   
    
    NSLog(@"json data is : %@" ,dic);
    
    
    __weak typeof(self) weakSelf=self;
    
    self.netSucessBlock=^(id result){
        NSString *state = [result objectForKey:@"state"];
        NSString *info = [result objectForKey:@"info"];
        
        NSLog(@"%@",info);
        
        if ([state isEqualToString:@"success"]) {
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
        }else if ([state isEqualToString:@"fail"]){
            [weakSelf createAlertView];
            weakSelf.alertView.title=info;
            [weakSelf.alertView show];
            
        }
        
    };
    
    [self netRequestWithUrl:url Data:dic];
}





@end

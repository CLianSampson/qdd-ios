//
//  SaveToMemory.m
//  JobTinder
//
//  Created by  chenlian on 15/5/5.
//  Copyright (c) 2015年 Sourcing Asia. All rights reserved.
//

#import "SaveToMemory.h"

@implementation SaveToMemory


-(NSString *)filePath:(NSString *)fileName{
    //获取应用程序下沙盒内Documents目录路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //在Documents路径后追加属性列表文件名，将最终路径返回
    NSString *documentsDirectory=[paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}


-(BOOL)SaveData:(NSData *)data ToMemory:(NSString *)filePath{
    if ([data writeToFile:filePath atomically:YES]) {
        return YES;
    }
    else return NO;
}

-(BOOL)SaveDictionary:(NSDictionary *)object ToMemory:(NSString *)filepath{
    if ([object writeToFile:filepath atomically:YES]) {
        return YES;
    }
    else return NO;
}

-(NSDictionary *)GetDictionary:(NSString *)filepath{
    NSDictionary *dictionary=[NSDictionary dictionaryWithContentsOfFile:filepath];
    
    return dictionary;
}


-(BOOL)SaveArry:(NSMutableArray *)arry ToMemory:(NSString *)filepath{
   
    return [arry writeToFile:filepath atomically:YES];
    
}


-(BOOL)SaveArry:(NSMutableArray *)arry ToMemory:(NSString *)filepath WithDictionary:(NSDictionary *)dictionary{
   
    BOOL filter=NO; //如果所有值都相同则不存储
    NSString *save_address=[dictionary objectForKey:@"address"];
    NSString *save_subAddress=[dictionary objectForKey:@"subAddress"];
    NSString *save_isSave=[dictionary objectForKey:@"isSaveToServer"];
    
    NSMutableArray *tempArry=[NSMutableArray arrayWithArray:arry];
    
    for (NSDictionary *dic in tempArry) {
        NSString *address=[dic objectForKey:@"address"];
        NSString *subAddress=[dic objectForKey:@"subAddress"];
        NSString *isSave=[dic objectForKey:@"isSaveToServer"];
        if (([save_address isEqualToString:address])&&([save_subAddress isEqualToString:subAddress]))
        {
            //如果收藏则不显示历史纪录
            if ([save_isSave isEqualToString:isSave]) {
               
                filter=YES;

            }else{
                //如果收藏则删除之前的历史纪录
                [arry removeObject:dic];
            }
        }else{
            
        }
    }
    
    //20为限定的历史记录的数目
    if (filter==NO) {
        if(arry.count<20){
            [arry insertObject:dictionary atIndex:0];
        }else{
            [arry removeObjectAtIndex:19];
            [arry insertObject:dictionary atIndex:0];
        }
        if ([arry writeToFile:filepath atomically:YES]) {
            return YES;
        }
    }
    return NO;
}

-(NSMutableArray *)GetArryData:(NSString *)filepath{
    NSMutableArray  *arry=[NSMutableArray arrayWithContentsOfFile:filepath];
    return arry;
}

-(NSData *)GetData:(NSString *)filepath{
    NSData *data=[NSData dataWithContentsOfFile:filepath];
    return data;
}



@end

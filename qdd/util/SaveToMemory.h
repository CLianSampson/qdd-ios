//
//  SaveToMemory.h
//  JobTinder
//
//  Created by  chenlian on 15/5/5.
//  Copyright (c) 2015年 Sourcing Asia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveToMemory : NSObject



-(NSString *)filePath:(NSString *)fileName;


//存储二进制数据
-(BOOL)SaveData:(NSData *)data ToMemory:(NSString *)filePath;

//字典序列化存储
-(BOOL)SaveDictionary:(NSDictionary *)object ToMemory:(NSString *)filepath;


-(NSData *)GetData:(NSString *)filepath;


//字典反序列化
-(NSDictionary *)GetDictionary:(NSString *)filepath;


//数组序列化
-(BOOL)SaveArry:(NSMutableArray *)object ToMemory:(NSString *)filepath;

//数组反序列化
-(NSMutableArray *)GetArryData:(NSString *)filepath;


-(BOOL)SaveArry:(NSMutableArray *)arry ToMemory:(NSString *)filepath WithDictionary:(NSDictionary *)dictionary;



@end

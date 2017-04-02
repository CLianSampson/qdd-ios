//
//  StringUtil.m
//  qdd
//
//  Created by Apple on 17/3/25.
//  Copyright © 2017年 Samposn Chen. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil


+(BOOL)isNullOrBlank:(NSString *)string{
    
    
    
    if ((NSNull*)string==[NSNull null]) {
        return true;
    }
    
    if (string==nil) {
        return true;
    }
    
    if ([string isEqual:@""]) {
        return true;
    }
    
//    if ([string isEqualToString:@""]) {
//        return true;
//    }
    
    
    
    return false;
    
}


+(BOOL)isPhoneNum:(NSString *)mobileNum{
    NSString *Fristnumber;
    if (mobileNum.length!=0) {
        Fristnumber   = [mobileNum substringWithRange:NSMakeRange(0, 1)];
        
    }
    
    if (mobileNum.length ==11 && [Fristnumber isEqualToString:@"1"]) {
        return YES;
    }
    
    if ([mobileNum containsString:@"@"]) {
        return NO;
    }
    
    return NO;
}

@end

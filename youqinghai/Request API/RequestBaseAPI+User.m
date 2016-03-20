//
//  RequestBaseAPI+User.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/20.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+User.h"
#import "GTMBase64+Des.h"

NSString *const userRegister = @"app/user/userRegister";

@implementation RequestBaseAPI (User)

-(RACSignal *)userRegisterWithPhone:(NSString *)phone withPassword:(NSString *)password withCode:(NSString *)code withType:(UserRegisterType)type{
    
    NSString *param = [NSString stringWithFormat:@"server=%@&phone=%@&password=%@&code=%@&type=%@",userRegister,phone,password,code,@(type)];
    param = [GTMBase64 desEncrypt:param];
    
    return [self requestWithType:RequestAPITypePost params:param];
}

@end

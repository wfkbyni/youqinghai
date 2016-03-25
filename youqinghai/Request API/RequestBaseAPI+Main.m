//
//  RequestBaseAPI+Main.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+Main.h"

NSString *const getHomePageData = @"app/homepage/getHomePageData";
NSString *const getTouristroutesList = @"app/touristroutes/getTouristroutesList";
NSString *const getTourisDetails = @"app/touristroutes/getTourisDetails";
NSString *const getTourisEvaluate = @"app/touristroutes/getTourisEvaluate";

@implementation RequestBaseAPI (Main)

/**
 *  @brief 给请求参数加密
 *
 *  @param value 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
- (NSString *)getDesEncryptWithString:(NSString *)value{
    return [GTMBase64 desEncrypt:value];
}

-(RACSignal *)getHomePageDataWithMark:(NSInteger)mark
                        withPageIndex:(NSInteger)pageIndex
                         withPageSize:(NSInteger)pageSize{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&pageIndex=%ld&pageSize=%ld",getHomePageData,pageIndex,pageSize];
    
    return [self requestWithType:RequestAPITypePost
                          params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)getTouristroutesListWithTypeId:(NSInteger)typeId
                               wihtPageIndex:(NSInteger)pageIndex
                                withPageSize:(NSInteger)pageSize{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&typeId=%ld&pageIndex=%ld&pageSize=%ld",getTouristroutesList,typeId,pageIndex,pageSize];
    
    params = [GTMBase64 desEncrypt:params];
    
    return [self requestWithType:RequestAPITypePost
                          params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)getTourisDetailsWithTourisId:(NSInteger)tourisId
                                withUserId:(NSInteger)userId{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&tourisId=%ld&userId=%ld",getTourisDetails,tourisId,userId];
    
    return [self requestWithType:RequestAPITypePost
                          params:[self getDesEncryptWithString:params]];
}

-(RACSignal *)getTourisEvaluateWithTourisId:(NSInteger)tourisId
                              withPageIndex:(NSInteger)pageIndex
                               withPageSize:(NSInteger)pageSize{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&tourisId=%ld&pageIndex=%ld&pageSize=%ld",getTourisEvaluate,tourisId,pageIndex,pageSize];
    
    return [self requestWithType:RequestAPITypePost
                          params:[self getDesEncryptWithString:params]];
}
@end


//
//  RequestBaseAPI+Car.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RequestBaseAPI+Car.h"

NSString const *carList = @"app/driverCarInfo/getCarList";

@implementation RequestBaseAPI (Car)

-(RACSignal *)getCarListWithCartypeId:(NSInteger)cartypeId
                           wihtEavnum:(NSInteger)eavnum
                       withPriceState:(NSInteger)priceState
                           withTourId:(NSInteger)tourId
                       withTravelTime:(long)travelTime
                        withPageIndex:(NSInteger)pageIndex
                         withPageSize:(NSInteger)pageSize{
    
    NSString *params = [NSString stringWithFormat:@"server=%@&tourId=%ld&pageIndex=%ld&pageSize=%ld",carList,tourId,pageIndex,pageSize];//[NSString stringWithFormat:@"server=%@&cartypeId=%ld&eavnum=%ld&priceState=%ld&tourId=%ld&travelTime=%ld&pageIndex=%ld&pageSize=%ld",carList,cartypeId,eavnum,priceState,tourId,travelTime,pageIndex,pageSize];
    
    return [self requestWithType:RequestAPITypePost params:[self getDesEncryptWithString:params]];
}

@end

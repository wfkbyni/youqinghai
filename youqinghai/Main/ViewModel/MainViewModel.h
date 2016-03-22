//
//  MainViewModel.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainViewModel : NSObject

@property (nonatomic, assign) NSInteger mark; // mark 传入  分页时候传入 1

/**
 *  @brief 获取首页数据
 *
 */
-(RACSignal *)getHomePageData;

@end
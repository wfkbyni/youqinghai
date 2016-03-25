//
//  MainViewModel.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/22.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface MainViewModel : NSObject

@property (nonatomic, assign) NSInteger mark;       // mark 传入  分页时候传入 1
@property (nonatomic, assign) NSInteger typeId;     // 线路类型Id

// 主页的数据
@property (nonatomic, strong) HomePageData *homePageData;

// 推荐线路
@property (nonatomic, strong) NSArray *recommends;

/**
 *  @brief 获取首页数据
 *
 */
- (RACSignal *)getHomePageData;

/**
 *  @brief 获取该类型的旅游线路
 *
 */
- (RACSignal *)getTouristroutesList;
@end

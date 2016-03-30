//
//  CarViewModel.h
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarViewModel : NSObject

@property (nonatomic, assign) NSInteger cartypeId;     // 车辆类型Id
@property (nonatomic, assign) NSInteger eavnum;        // 评论排序 0：升序 1：降序
@property (nonatomic, assign) NSInteger priceState;    // 价格排序  0:从低到高   1：从高到低
@property (nonatomic, assign) NSInteger tourId;        // 出游路线Id
@property (nonatomic, assign) NSInteger travelTime;    // 出发时间  （时间戳）

// 车辆列表
@property (nonatomic, strong) NSArray *cars;

/**
 *  @brief 获取包车的车辆信息（1.0）
 *
 */
- (RACSignal *)getCarList;

@end

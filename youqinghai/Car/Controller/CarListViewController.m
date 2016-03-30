//
//  CarListViewController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/30.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CarListViewController.h"

#import "CarListCell.h"
#import "CustomMoveItemView.h"

#import "CarViewModel.h"

@interface CarListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) CarViewModel *carViewModel;

@end

#define identifier @"cell"

@implementation CarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我要包车";
    
    CustomMoveItemView *customMoveItemView = [[CustomMoveItemView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, 40) withItems:@[@"默认",@"评价",@"价格",@"车辆类型"]];
    [customMoveItemView setCustoMoveItemBlock:^(TourismDetailType type) {
        
    }];
    [self.view addSubview:customMoveItemView];
    
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CarListCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.myTableView.tableFooterView = [[UIView alloc] init];
    
    [self loadData];
}

- (void)loadData{
    self.carViewModel = [[CarViewModel alloc] init];
    self.carViewModel.tourId = self.recommend.Id;
    
    [RACObserve(self.carViewModel, cars) subscribeNext:^(id x) {
        [self.myTableView reloadData];
    }];
    
    [[self.carViewModel getCarList] subscribeError:^(NSError *error) {
        NSLog(@"error:%@",error);
    } completed:^{
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carViewModel.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.car = self.carViewModel.cars[indexPath.row];
    return cell;
}

@end

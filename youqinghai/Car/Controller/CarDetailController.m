//
//  CarDetailController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/31.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "CarDetailController.h"
#import "CarViewModel.h"

@interface CarDetailController ()

@property (nonatomic, strong) CarViewModel *carViewModel;

@end

@implementation CarDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _carViewModel = [[CarViewModel alloc] init];
    _carViewModel.driverId = self.car.Id;
    
    [[_carViewModel getDriverCarDetails] subscribeNext:^(id x) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

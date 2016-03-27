//
//  TourismDetailController.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/25.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourismDetailController.h"

#import "CustomMoveItemView.h"
#import "TourismDetailView.h"

#import "MainViewModel.h"

@interface TourismDetailController ()

@property (nonatomic, strong) MainViewModel *mainViewModel;

@property (nonatomic, strong) TourismDetailView *tourismDetailView;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation TourismDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (UIView *)tableViewHeaderView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.width * 0.5)];
    
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.width * 0.5) delegate:nil placeholderImage:nil];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:[self.mainViewModel.traveltrip.banner count]];
    [self.mainViewModel.traveltrip.banner enumerateObjectsUsingBlock:^(Banner *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imageArray addObject:obj.imgUrl];
    }];
    
    scrollView.imageURLStringsGroup = imageArray;
    
    [view addSubview:scrollView];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CustomMoveItemView *customMoveItemView = [[CustomMoveItemView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 40) withItems:@[@"线路详情",@"线路评价",@"服务介绍"]];
    [customMoveItemView setCustoMoveItemBlock:^(NSInteger index) {
        
    }];
    return customMoveItemView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (void)loadData{
    self.mainViewModel = [[MainViewModel alloc] init];
    self.mainViewModel.typeId = self.recommend.Id;
    
    [[self.mainViewModel getTourisDetails] subscribeError:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    [RACObserve(self.mainViewModel, traveltrip) subscribeNext:^(id x) {
        
        if (x != nil) {
            self.myTableView.tableHeaderView = [self tableViewHeaderView];
            
            self.myTableView.tableFooterView = [self tourismDetailView];
        }
    }];
}

- (TourismDetailView *)tourismDetailView{
    if (!_tourismDetailView) {
        _tourismDetailView = [[TourismDetailView alloc] init];
        _tourismDetailView.viewlist = self.mainViewModel.traveltrip.traveltriplist;
    }
    
    return _tourismDetailView;
}

@end

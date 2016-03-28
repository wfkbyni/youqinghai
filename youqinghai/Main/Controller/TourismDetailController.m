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
#import "TourisEvaluateView.h"

#import "MainViewModel.h"

@interface TourismDetailController (){
    NSInteger clickCount;
}

@property (nonatomic, strong) MainViewModel *mainViewModel;

@property (nonatomic, strong) UIView *tableViewHeaderView;

@property (nonatomic, strong) TourismDetailView *tourismDetailView;
@property (nonatomic, strong) TourisEvaluateView *tourisEvaluateView;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *collectionNumLab;

@end

@implementation TourismDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainViewModel = [[MainViewModel alloc] init];
    
    [self loadDataWithDataType:TourismDetailTypeWithIntroduction];
    
}

- (UIView *)tableViewHeaderView{
    
    if (!_tableViewHeaderView) {
        float height = kScreenSize.width * 0.5;
        _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, height)];
        
        SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenSize.width, height) delegate:nil placeholderImage:nil];
        
        NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:[self.mainViewModel.traveltrip.banner count]];
        [self.mainViewModel.traveltrip.banner enumerateObjectsUsingBlock:^(Banner *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [imageArray addObject:obj.imgUrl];
        }];
        
        scrollView.imageURLStringsGroup = imageArray;
        
        [_tableViewHeaderView addSubview:scrollView];
        [scrollView setBackgroundColor:[UIColor orangeColor]];
    }
    
    return _tableViewHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CustomMoveItemView *customMoveItemView = [[CustomMoveItemView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 40) withItems:@[@"线路详情",@"线路评价",@"服务介绍"]];
    [customMoveItemView setCustoMoveItemBlock:^(TourismDetailType type) {
        clickCount ++;
        switch (type) {
            case TourismDetailTypeWithIntroduction: {
                [self loadTourisDetailsData];
                break;
            }
            case TourismDetailTypeWithEvaluate: {
                [self loadTourisEvaluate];
                break;
            }
            case TourismDetailTypeWithService: {

                break;
            }
        }
    }];
    return customMoveItemView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (void)loadDataWithDataType:(TourismDetailType)type{
    
    switch (type) {
        case TourismDetailTypeWithIntroduction: {
            [self loadTourisDetailsData];
            break;
        }
        case TourismDetailTypeWithEvaluate: {
            [self loadTourisEvaluate];
            break;
        }
        case TourismDetailTypeWithService: {
            [self loadTourisDetailsData];
            break;
        }
    }
    
}

// 加载路程介绍
- (void)loadTourisDetailsData{
    self.mainViewModel.typeId = self.recommend.Id;
    
    [[self.mainViewModel getTourisDetails] subscribeError:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    [RACObserve(self.mainViewModel, traveltrip) subscribeNext:^(id x) {
        
        if (x) {
            
            if (clickCount == 0) {
                self.myTableView.tableHeaderView = self.tableViewHeaderView;
            }
            
            self.collectionNumLab.text = [@(self.mainViewModel.traveltrip.collectionNum) stringValue];
            // 线路详情
            self.myTableView.tableFooterView = [self tourismDetailView];
            
        }
    }];
}

// 加载线路评价
- (void)loadTourisEvaluate{
    
    self.mainViewModel.tourisId = self.recommend.Id;
    
    [[self.mainViewModel getTourisEvaluate] subscribeError:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    [RACObserve(self.mainViewModel, tourisEvaluate) subscribeNext:^(id x) {
        if (x) {
            
            self.tourisEvaluateView.tourisEvaluate = self.mainViewModel.tourisEvaluate;
            
            // 线路评价
            self.myTableView.tableFooterView = [self tourisEvaluateView];
        }
    }];
}

// 加载线路服务

- (TourisEvaluateView *)tourisEvaluateView{
 
    if (!_tourisEvaluateView) {
        _tourisEvaluateView = [[TourisEvaluateView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - kScreenSize.width * 0.5 - 40)];
    }
    
    return _tourisEvaluateView;
}

- (TourismDetailView *)tourismDetailView{
    if (!_tourismDetailView) {
        _tourismDetailView = [[TourismDetailView alloc] init];
    }
    
    _tourismDetailView.viewlist = self.mainViewModel.traveltrip.traveltriplist;
    
    return _tourismDetailView;
}

@end

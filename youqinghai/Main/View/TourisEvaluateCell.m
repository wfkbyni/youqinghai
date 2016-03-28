//
//  TourisEvaluateCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/28.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "TourisEvaluateCell.h"

#import "TourismTypeItemCell.h"

@interface TourisEvaluateCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *evatTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic, strong) NSArray *listImages;

@end

#define identifier @"collectionViewCell"

@implementation TourisEvaluateCell

- (void)awakeFromNib {
    // Initialization code
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TourismTypeItemCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    
    self.myCollectionView.dataSource = self;
    self.myCollectionView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTourisEvaluate:(TourisEvaluate *)tourisEvaluate{
    [self.userImgView viewWithCornerRadius:CGRectGetWidth(self.userImgView.frame) / 2];
    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:tourisEvaluate.userImgUrl]];
    [self.userNameLab setText:tourisEvaluate.userName];
    [self.contentLab setText:tourisEvaluate.content];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[tourisEvaluate.evatTime longLongValue] / 1000];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *time = [df stringFromDate:date];
    
    [self.evatTimeLab setText:time];
    
    _listImages = tourisEvaluate.listImage;
    [self.myCollectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TourismTypeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.tourismType = self.listImages[indexPath.row];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    
    cell.layer.borderColor = [UIColor colorWithRed:arc4random_uniform(255.0f) / 255.0f green:arc4random_uniform(255.0f) / 255.0f blue:arc4random_uniform(255.0f) / 255.0f alpha:1].CGColor;
    cell.layer.masksToBounds = YES;
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}

@end

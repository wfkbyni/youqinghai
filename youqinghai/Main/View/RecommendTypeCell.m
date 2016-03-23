//
//  RecommendTypeCell.m
//  youqinghai
//
//  Created by 舒永超 on 16/3/23.
//  Copyright © 2016年 舒永超. All rights reserved.
//

#import "RecommendTypeCell.h"

@interface RecommendTypeCell()

@property (weak, nonatomic) IBOutlet UIButton *imgUrlBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *introduceLab;
@end

@implementation RecommendTypeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HBCollectionViewCell.m
//  collectionView
//
//  Created by 何白 on 15/12/29.
//  Copyright © 2015年 hebai. All rights reserved.
//

#import "HBCollectionViewCell.h"

@implementation HBCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 5;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.clipsToBounds = YES;
    
    
}

- (void)setImageNage:(NSString *)imageNage{
    
    _imageNage = [imageNage copy];
    
    //重写set方法 赋值的时候用
    self.imageView.image  = [UIImage imageNamed:imageNage];
    
}
@end

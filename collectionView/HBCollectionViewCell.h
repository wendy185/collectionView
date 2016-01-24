//
//  HBCollectionViewCell.h
//  collectionView
//
//  Created by 何白 on 15/12/29.
//  Copyright © 2015年 hebai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,copy)NSString *imageNage;
@end

//
//  HBCircularLayout.m
//  collectionView
//
//  Created by 何白 on 16/1/17.
//  Copyright © 2016年 hebai. All rights reserved.
//

#import "HBCircularLayout.h"

@implementation HBCircularLayout

//每一次布局都重新计算位置
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
    
}

//计算每一个item的位置
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSArray *angles = @[@1,@(-0.2),@(0.5),@(-0.8),@(0.8)];
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];



    
//    if (indexPath.item >=5) {
//        attributes.hidden = YES;
//    }else{
//        attributes.size = CGSizeMake(100, 100);
//            attributes.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
//        attributes.center = self.collectionView.center;
        
//        attributes.transform = CGAffineTransformMakeRotation([angles[indexPath.item] floatValue]);//旋转

    
        //zIndex 大的在上面
//        attributes.zIndex =  - indexPath.item;
        
   
//    }
    
    return attributes;
    
    

}

//- (CGSize)collectionViewContentSize{
//    return CGSizeMake(500, 500);
//}

//返回所有的attri
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    NSArray *angles = @[@0,@(-0.2),@(0.3),@(-0.5),@(0.8)];
    
    for (int i = 0; i < count ; i++) {
        
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        attrs.size = CGSizeMake(100, 100);
        attrs.center = CGPointMake(self.collectionView.frame.size.width*0.5, self.collectionView.frame.size.height*0.5);
        if (i >=5) {
            attrs.hidden = YES;
        }else{
       
            attrs.transform = CGAffineTransformMakeRotation([angles[i] floatValue]);
            attrs.zIndex = count - i;
            [array addObject:attrs];
        }
        
    }
    return array;
}




@end

 //
//  HBLineLayout.m
//  collectionView
//
//  Created by 何白 on 16/1/2.
//  Copyright © 2016年 hebai. All rights reserved.
//

#import "HBLineLayout.h"
static const CGFloat HBItmesize = 100;


@implementation HBLineLayout


- (instancetype)init{
    // 加载类的时候调用一次
    //先初始化父类
    if (self = [super init]) {

        
    }
    return self;
}

/**
 *  停止的位置
 *
 *  @param proposedContentOffset 停止的真实位置
 *  @param velocity              滚动的速度
 *
 *  @return 返回一个位置
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    CGRect zuihoufanwei;
    zuihoufanwei.origin= proposedContentOffset;
    zuihoufanwei.size = self.collectionView.frame.size;
    
    NSArray *KJitmes =  [super layoutAttributesForElementsInRect:zuihoufanwei];
    
    CGFloat asjustoffsetX = MAXFLOAT; //定义一个很大的值 比他小就让值等于小的
    for (UICollectionViewLayoutAttributes * KJitme in KJitmes) {
        
        //可见中间的x 停留的x + 加上半个控件
        CGFloat testx = proposedContentOffset.x + self.collectionView.frame.size.width*0.5;
        // 间距小 比大小 都用绝对值 设置位置分左右 不要绝对值
        if (ABS(testx - KJitme.center.x) < ABS(asjustoffsetX)) {
            
            asjustoffsetX = KJitme.center.x - testx ;
        }
        
//        proposedContentOffset从那个位置开始显示 加一段 往左移动  减去一段 往右边移动
        //调整的距离 itme比中线的距离 如果是正数 在右边 要往左边移动 让停留的距离加上距离
//        如果在左边  附属 剪一段距离

        
    }
            return CGPointMake(proposedContentOffset.x + asjustoffsetX, proposedContentOffset.y);
    
}



//准备布局的时候
- (void)prepareLayout{
    [super prepareLayout];//先让父类准备好布局
    self.itemSize = CGSizeMake(HBItmesize, HBItmesize);
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置剪切 去掉两边的 让显示在中间
    CGFloat inset = (self.collectionView.frame.size.width - HBItmesize) *0.5;
    //布局的上左下右  左右设置一个距离 第一张从距离器 最后一张 有距离
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    //        UICollectionViewLayoutAttributes 每一个cell的布局
    
    self.minimumLineSpacing = 100;
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
    //每次改变的时候  刷新 重新计算所有尺寸
}

//拿到范围的属性 传入父类的拿到所有属性 传入一个范围(尺寸,位置) 拿到这个范围里面的所有属性数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
//    NSLog(@"计算cell");
    
//计算所有的cell 需要的时候才计算
    //取出所有的布局属性 操作
    NSArray *attributes =[super layoutAttributesForElementsInRect:rect];

    //便利属性数组的每一个布局属性
    for ( UICollectionViewLayoutAttributes *attribute in attributes) {

        //提高性能,只计算可见区域的itme 的布局
        
        //实际可以看得见的collectionView范围
        
        CGRect see ;
        see.size.width = self.collectionView.frame.size.width + 2*attribute.size.width;
        see.size.height = self.collectionView.frame.size.height;
        
        see.origin.x = self.collectionView.contentOffset.x - attribute.size.width;
        see.origin.y = self.collectionView.contentOffset.y;
        
        

        
        if (!CGRectIntersectsRect(see, attribute.frame) ) {
            

            continue; //结束本次循环
            
        }//过掉看见的地方 itme的frame 没有交集的
        //中间位置的浮动值contentOffset移动了多少   contentSize显示区域


        
        CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width*0.5;
//        centerX 和attde x 比较 当前item离中间距离
        CGFloat chazhi = attribute.center.x - centerX; //左右两边距离中间的距离
        
        
//        ABS(chazhi);// 左右两边 距离中间距离的绝对值

        //放大倍数 在1-2之间 近的大
        CGFloat enlarge = 1 + (1- 1.5*(ABS(chazhi) / self.collectionView.frame.size.width*0.5));
        
   
        attribute.transform3D = CATransform3DMakeScale(enlarge, enlarge, 1);
        
    }
    
//    return [super layoutAttributesForElementsInRect:rect];
    return attributes;
    
    
    
}















@end

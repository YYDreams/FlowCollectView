//
//  PhotoFlowLayout.m
//  FlowCollectView
//
//  Created by 花花 on 16/9/27.
//  Copyright © 2016年 花花. All rights reserved.
//

#import "PhotoFlowLayout.h"

@implementation PhotoFlowLayout
/**
 *  自定义布局：5个重要的方法
 
 - (void)prepareLayout;
 - (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
 
 - (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
 
 - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity;
 - (CGSize)collectionViewContentSize;

 */



//collctionView第一次布局，collectionView刷新的时候也会调用
//作用：计算cell的布局，条件:cell的位置是固定不变的

//-(void)prepareLayout{
//
//    [super prepareLayout];
//}

/**
 *  UICollectionViewLayoutAttributes:确定cell的尺寸
 *
 *  一个UICollectionViewLayoutAttributes对象就对应一个cell
 *
 *  拿到UICollectionViewLayoutAttributes相当于拿到cell
 */

/*
 设置cell尺寸 ->UICollectionViewLayoutAttributes
 越靠近中心点，距离越小，缩放越大
 求cell与中心点距离
 */
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    
    //1.获取当前cell的布局 即拿到所有的cell尺寸
    NSArray *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    for(UICollectionViewLayoutAttributes *attr in attrs){
    
        //2.计算中心点距离
        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x)- self.collectionView.bounds.size.width*0.5);
        
        NSLog(@"%f",delta);
        //3.计算比例
        CGFloat scale = 1- delta/(self.collectionView.bounds.size.width *0.5)*0.25;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
        
        
    }


    return  attrs;

}

/**
 *  用户一松开就会调用
 *
 *  作用:确定最终偏移量
 *
 *  定位:距离中心点越近，这个cell最终展示到中心点
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    
    CGFloat collection_width = self.collectionView.bounds.size.width;
    
    //最终偏移量   拖动比较快的时候  最终偏移量 不等于 手指离开时偏移量
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    //1.获取最终显示的区域
    CGRect targetRect = CGRectMake(targetP.x, 0, collection_width, MAXFLOAT);
    
    NSLog(@"%@%@",NSStringFromCGPoint(targetP),NSStringFromCGPoint(self.collectionView.contentOffset));
    
    //2.获取最终显示的cell
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    
    //3.获取最小间距
    CGFloat minDelta = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        //获取距中心点距离: 注意：应该用最终的x
        CGFloat delta = (attr.center.x -targetP.x)- self.collectionView.bounds.size.width * 0.5;
        
        if (fabs(delta)<fabs(minDelta)) {
            
            minDelta = delta;
        }
        
    }
    
//    移动间距
    targetP.x +=minDelta;
    
    if (targetP.x<0) {
        targetP.x = 0;
        
    }
    
    
    return targetP;
    


}

//Invalidate:刷新
//在滚动的时候是否允许刷新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
    
}
//计算collectionView滚动范围
//-(CGSize)collectionViewContentSize{
//
//    return [super collectionViewContentSize];
//}
@end

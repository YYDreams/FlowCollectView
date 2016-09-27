//
//  ViewController.m
//  FlowCollectView
//
//  Created by 花花 on 16/9/27.
//  Copyright © 2016年 花花. All rights reserved.
//

#import "ViewController.h"
#import "PhotoFlowLayout.h"
#import "PhotoCell.h"
#define screen_width [UIScreen mainScreen].bounds.size.width
#define item_WH 160
@interface ViewController ()<UICollectionViewDataSource>

@end
static NSString *const PhotoCellID = @"PhotoCellID";
@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupCollectionView];

}

#pragma mark - setupCollectionViewMethod
/**
 *  UICollectionView的使用:
 
 1.创建UICollectionView必须要有布局参数，否则会报错
 2.cell必须通过注册
 3.cell必须自定义，系统cell没有任何子控件，跟TableViewCell是有点区别的
 */

// 函数式编程思想(高聚合):把很多功能放在一个函数块(block块)去处理
// 编程思想:低耦合,高聚合(代码聚合,方便去管理)

/**
 *  UICollectionView *collectionView = ({
      
     //初始化
    ...
 
     collectionView;
 });
 */
-(void)setupCollectionView{
    
    //如何让cell尺寸不一样 则需要自定义流水布局
    
    PhotoFlowLayout *layout = [[PhotoFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize =CGSizeMake(item_WH, item_WH);
    
    CGFloat margin = (screen_width - item_WH)* 0.5;
    
    
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
//    设置最小行间距
    layout.minimumLineSpacing = 50;

    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    collectionView.backgroundColor = [UIColor redColor];
    collectionView.center= self.view.center;
    collectionView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoCell class]) bundle:nil] forCellWithReuseIdentifier:PhotoCellID];
    
    [self.view addSubview:collectionView];
    
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 10;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellID forIndexPath:indexPath];
    
    NSString *imageNames = [NSString stringWithFormat:@"%zd",indexPath.item +1];
    cell.image = [UIImage imageNamed:imageNames];
    
    
    return cell;
    

}

@end

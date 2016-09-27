//
//  PhotoCell.h
//  FlowCollectView
//
//  Created by 花花 on 16/9/27.
//  Copyright © 2016年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property(nonatomic, strong) UIImage *image;

@end

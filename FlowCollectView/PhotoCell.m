//
//  PhotoCell.m
//  FlowCollectView
//
//  Created by 花花 on 16/9/27.
//  Copyright © 2016年 花花. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setImage:(UIImage *)image{

    _image = image;
    
    _ImageView.image = image;

}

@end

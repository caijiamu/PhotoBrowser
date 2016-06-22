//
//  ZBPhotoBrowserViewController.h
//  MakeComponents
//
//  Created by idiot.lin on 16/6/14.
//  Copyright © 2016年 apple.lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYImage/YYImage.h>

typedef NS_ENUM(NSInteger,ZBPhotoBrowserSourceType){
    ZBPhotoBrowserDefault = 0, //URL模式
    ZBPhotoBrowserImage,//image模式
};

@interface ZBPhotoBrowserViewController : UIViewController
/**
 *  初始化
 *  @param sourceArr  图片源
 *  @param type       模式类型
 *  @param imageIndex 图片下标
 */
-(instancetype)initWithDataSourceArr:(NSArray *)sourceArr sourceType:(ZBPhotoBrowserSourceType)type  imageIndex:(NSInteger)imageIndex;
@end


@interface ZBPhotoBrowserCell : UICollectionViewCell
/**
 * 图片
 */
@property (nonatomic, strong) YYAnimatedImageView *imageView;
@property (nonatomic, strong) UIScrollView *containScrollView;

@end
//
//  UIImageView+MSSDWebImage.m
//  MisaBaseDemo
//
//  Created by stone on 2018/11/7.
//  Copyright © 2018年 Misa. All rights reserved.
//

#import "UIImageView+MSSDWebImage.h"

@implementation UIImageView (MSSDWebImage)

- (void)downloadImage:(NSString *)url
                place:(UIImage *)place
{
    if ([NSString isEmpty:url]) {
        return;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}


- (void)downloadImage:(NSString *)url
                place:(UIImage *)place
              success:(DownloadSuccessBlock)success
              failure:(DownloadFailureBlock)failure
             received:(DownloadProgressBlock)progress
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageRetryFailed | SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progress) {
            progress((float)receivedSize/expectedSize);
        }
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            if (failure) {
                failure(error);
            }
        }else{
            // image是下载好的图片
            self.image = image;
            if (success) {
                success(cacheType, image);
            }
        }
    }];
}

@end

//
//  UIImage+FiltersImage.h
//  Filters
//
//  Created by Rishabh Tayal on 4/1/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FiltersImage)

+ (UIImage *)scaleAndRotateImage:(UIImage *)image scale:(CGSize)size;

@end

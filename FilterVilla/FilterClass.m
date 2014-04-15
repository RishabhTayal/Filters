//
//  FilterClassToName.m
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import "FilterClass.h"

@implementation FilterClass

+(id)filterWithClassName:(NSString *)className filterName:(NSString *)filterName filterParameter:(NSString *)parameter
{
    FilterClass* filter = [[FilterClass alloc] init];
    if (filter) {
        filter.className = className;
        filter.filterName = filterName;
        filter.filterParameter = parameter;
    }
    return filter;
}
//+(NSString *)filterNameFromClass:(NSString *)className
//{
//    if ([className isEqualToString:@"CILinearToSRGBToneCurve"]) {
//        return @"Tone";
//    }
//    if ([className isEqualToString:@"CIPhotoEffectChrome"]) {
//        return @"Chrome";
//    }
//    if ([className isEqualToString:@"CIPhotoEffectFade"]) {
//        return @"Fade";
//    }
//    if ([className isEqualToString:@"CIPhotoEffectInstant"]) {
//        return @"Instant";
//    }
//    if ([className isEqualToString:@"CIPhotoEffectMono"]) {
//        return @"Mono";
//    }
//    if ([className isEqualToString:@"CIPhotoEffectNoir"]) {
//        return @"Noir";
//    }
//    if ([className isEqualToString:@"CIPhotoEffectProcess"]) {
//        return @"Process";
//    }
//    if ([className isEqualToString:@"CIPhotoEffectTonal"]) {
//        return @"Tonal";
//    }
//    if ([className isEqualToString:@"CIPhotoEffectTransfer"]) {
//        return @"Transfer";
//    }
//    if ([className isEqualToString:@"CISRGBToneCurveToLinear"]) {
//        return @"Linear";
//    }
//    if ([className isEqualToString:@"CIVignetteEffect"]) {
//        return @"Vignette";
//    }
//    if ([className isEqualToString:@"CIBloom"]) {
//        return @"Bloom";
//    }
//    if ([className isEqualToString:@"CIGaussianBlur"]) {
//        return @"Blur";
//    }
//    if ([className isEqualToString:@"CIColorPosterize"]) {
//        return @"Poster";
//    }
//    return @"Original";
//}

@end

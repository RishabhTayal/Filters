//
//  FilterClassToName.m
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import "FilterClass.h"

@implementation FilterClass

+(NSArray *)filterInitialize
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    //                 @"",
    //                 @"CIPhotoEffectFade",
    //                 @"CIPhotoEffectInstant",
    //                 @"CIPhotoEffectMono",
    //                 @"CIPhotoEffectNoir",
    //                 @"CIPhotoEffectProcess",
    //                 @"CIPhotoEffectTonal",
    //                 @"CIPhotoEffectTransfer",
    //                 @"CISRGBToneCurveToLinear",
    //                 @"CIVignetteEffect",
    //                 @"CIBloom",
    //                 @"CIGaussianBlur",
    //                 ];
    //    FilterClass* filter = [FilterClass filterWithClassName:@"" filterName:@"Original" filterParameter:@""];
    //    [array addObject:filter];
    //    filter = [FilterClass filterWithClassName:@"CIColorPosterize" filterName:@"Poster" filterParameter:@"inputLevels"];
    //    [array addObject:filter];
    //    filter = [FilterClass filterWithClassName:@"CILinearToSRGBToneCurve" filterName:@"Tone Curve" filterParameter:@""];
    //    [array addObject:filter];
    //    filter = [FilterClass filterWithClassName:@"CIPhotoEffectChrome" filterName:@"Chrome" filterParameter:@""];
    //    [array addObject:filter];
    //    filter = [FilterClass filterWithClassName:@"CIVignetteEffect" filterName:@"Vignette" filterParameter:@"inputRadius"];
    //    [array addObject:filter];
    return array;
}

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

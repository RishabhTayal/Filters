//
//  FilterInitializer.m
//  FilterVilla
//
//  Created by Rishabh Tayal on 4/15/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import "FilterInitializer.h"
#import "FilterClass.h"

@implementation FilterInitializer

+(NSArray*)filtersInitialize
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
    FilterClass* filter = [FilterClass filterWithClassName:@"" filterName:@"Original" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIColorPosterize" filterName:@"Poster" filterParameter:@"inputLevels"];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CILinearToSRGBToneCurve" filterName:@"Tone Curve" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIPhotoEffectChrome" filterName:@"Chrome" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIVignetteEffect" filterName:@"Vignette" filterParameter:@"inputRadius"];
    [array addObject:filter];
    return array;
}

@end

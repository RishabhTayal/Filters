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
    filter = [FilterClass filterWithClassName:@"CIPhotoEffectFade" filterName:@"Fade" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIPhotoEffectInstant" filterName:@"Instant" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIPhotoEffectMono" filterName:@"Mono" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIPhotoEffectNoir" filterName:@"Noir" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIPhotoEffectProcess" filterName:@"Process" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIPhotoEffectTonal" filterName:@"Tonal" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIPhotoEffectTransfer" filterName:@"Transfer" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CISRGBToneCurveToLinear" filterName:@"Linear" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIBloom" filterName:@"Bloom" filterParameter:@""];
    [array addObject:filter];
    filter = [FilterClass filterWithClassName:@"CIGaussianBlur" filterName:@"Gaussian Blur" filterParameter:@""];
    [array addObject:filter];
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

@end

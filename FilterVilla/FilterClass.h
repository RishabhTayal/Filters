//
//  FilterClassToName.h
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterClass : NSObject

@property (strong) NSString* className;
@property (strong) NSString* filterName;
@property (strong) NSString* filterParameter;

+(NSArray*)filterInitialize;

//+(id)filterWithClassName:(NSString*)className filterName:(NSString*)filterName filterParameter:(NSString*)parameter;

@end

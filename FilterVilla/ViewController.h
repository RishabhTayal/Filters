//
//  ViewController.h
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "GAITrackedViewController.h"
@interface ViewController : GAITrackedViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SwipeViewDataSource, SwipeViewDelegate>

@property (nonatomic, strong) UIImage* orgImage;

@end

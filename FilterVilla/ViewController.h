//
//  ViewController.h
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@interface ViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SwipeViewDataSource, SwipeViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView* mainImageView;
@property (nonatomic, strong) IBOutlet SwipeView* filtersCollectionView;

@property (nonatomic, strong) UIImage* orgImage;

//-(IBAction)loadPhotosClicked:(id)sender;


@end

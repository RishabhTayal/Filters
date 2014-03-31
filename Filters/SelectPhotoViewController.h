//
//  SelectPhotoViewController.h
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPhotoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(IBAction)loadPhotosClicked:(id)sender;

@end

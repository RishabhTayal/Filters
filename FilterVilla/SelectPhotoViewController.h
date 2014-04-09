//
//  SelectPhotoViewController.h
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropboxBrowserViewController.h"

@interface SelectPhotoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, DropboxBrowserDelegate>

-(IBAction)loadPhotosClicked:(id)sender;
-(IBAction)loadDropboxPhotos:(id)sender;

@end

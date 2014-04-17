//
//  SelectPhotoViewController.h
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropboxBrowserViewController.h"
#import "RTFacebookAlbumViewController.h"
#import <iAd/iAd.h>
#import "GAITrackedViewController.h"

@interface SelectPhotoViewController : GAITrackedViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, DropboxBrowserDelegate, ADBannerViewDelegate, RTFacebookViewDelegate>

-(IBAction)loadPhotosClicked:(id)sender;
-(IBAction)showFacebook:(id)sender;

@end

//
//  SelectPhotoViewController.h
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropboxBrowserViewController.h"
#import "FacebookAlbumViewController.h"
#import <iAd/iAd.h>
#import "GAITrackedViewController.h"

@interface SelectPhotoViewController : GAITrackedViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, DropboxBrowserDelegate, ADBannerViewDelegate, FacebookViewDelegate>

-(IBAction)loadPhotosClicked:(id)sender;

@end

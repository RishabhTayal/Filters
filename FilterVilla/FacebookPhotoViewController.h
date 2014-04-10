//
//  FacebookPhotoViewController.h
//  FilterVilla
//
//  Created by Rishabh Tayal on 4/10/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookAlbumViewController.h"

@interface FacebookPhotoViewController : UICollectionViewController

@property (strong) NSString* albumId;
@property (weak) id<FacebookViewDelegate> delegate;

@end

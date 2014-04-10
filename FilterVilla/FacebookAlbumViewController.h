//
//  ViewController.h
//  FacebookAlbum
//
//  Created by Rishabh Tayal on 4/10/14.
//
//

#import <UIKit/UIKit.h>

@protocol FacebookViewDelegate;

@interface FacebookAlbumViewController : UITableViewController<UIAlertViewDelegate>

@property (weak) id<FacebookViewDelegate> delegate;

@end

@protocol FacebookViewDelegate <NSObject>

-(void)faceBookViewController:(id)controller didSelectPhoto:(UIImage*)image;

@end
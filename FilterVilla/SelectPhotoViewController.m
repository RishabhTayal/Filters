//
//  SelectPhotoViewController.m
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import "ViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "AppDelegate.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAI.h"

@interface SelectPhotoViewController ()

@property (strong) UIImage* image;

@end

@implementation SelectPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.canDisplayBannerAds = YES;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.screenName = @"Photo Select Screen";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loadPhotosClicked:(id)sender
{
    UIButton* button = (UIButton*)sender;
    
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    if (button.tag == 1) {
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action" action:@"ui_button" label:@"Photo Library" value:nil] build]];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    if (button.tag == 2) {
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action" action:@"ui_button" label:@"Camera" value:nil] build]];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    if (button.tag == 3) {
        
    }
}

-(void)showFacebook:(id)sender
{
    [RTFacebookAlbumViewController showWithDelegate:self];
}

#pragma mark - UIImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"ViewControllerSegue" sender:self];
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    if ([segue.identifier isEqualToString:@"ViewControllerSegue"]) {
        ViewController* vc = segue.destinationViewController;
        vc.orgImage = _image;
    }
    if ([[segue identifier] isEqualToString:@"showDropboxBrowser"]) {
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action" action:@"ui_button" label:@"Dropbox" value:nil] build]];
        // Get reference to the destination view controller
        UINavigationController *navigationController = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        DropboxBrowserViewController *dropboxBrowser = (DropboxBrowserViewController *)navigationController.topViewController;
        
        dropboxBrowser.shouldShowLogoutButton = YES;
        // dropboxBrowser.allowedFileTypes = @[@"doc", @"pdf"]; // Uncomment to filter file types. Create an array of allowed types. To allow all file types simply don't set the property
        // dropboxBrowser.tableCellID = @"DropboxBrowserCell"; // Uncomment to use a custom UITableViewCell ID. This property is not required
        
        // When a file is downloaded (either successfully or unsuccessfully) you can have DBBrowser notify the user with Notification Center. Default property is NO.
        dropboxBrowser.deliverDownloadNotifications = YES;
        
        // Dropbox Browser can display a UISearchBar to allow the user to search their Dropbox for a file or folder. Default property is NO.
        dropboxBrowser.shouldDisplaySearchBar = YES;
        
        // Set the delegate property to recieve delegate method calls
        dropboxBrowser.rootViewDelegate = self;
    }
}

#pragma mark - Facebook Browser Delegate

-(void)faceBookViewController:(id)controller didSelectPhoto:(UIImage *)image
{
    _image = image;
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"ViewControllerSegue" sender:self];
    }];
}

#pragma mark - Dropbox Browser Delegate

- (void)dropboxBrowser:(DropboxBrowserViewController *)browser didDownloadFile:(NSString *)fileName didOverwriteFile:(BOOL)isLocalFileOverwritten
{
    if (isLocalFileOverwritten == YES) {
        NSLog(@"Downloaded %@ by overwriting local file", fileName);
    } else {
        NSLog(@"Downloaded %@ without overwriting", fileName);
    }
    
    NSData* imageData = [NSData dataWithContentsOfFile:[[AppDelegate applicationDocumentsDirectory] stringByAppendingPathComponent:fileName]];
    UIImage* image = [UIImage imageWithData:imageData];
    _image = image;
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"ViewControllerSegue" sender:self];
    }];
}

- (void)dropboxBrowser:(DropboxBrowserViewController *)browser didFailToDownloadFile:(NSString *)fileName
{
    NSLog(@"Failed to download %@", fileName);
}

- (void)dropboxBrowser:(DropboxBrowserViewController *)browser fileConflictWithLocalFile:(NSURL *)localFileURL withDropboxFile:(DBMetadata *)dropboxFile withError:(NSError *)error
{
    NSData* imageData = [NSData dataWithContentsOfURL:localFileURL];
    UIImage* img = [UIImage imageWithData:imageData];
    _image = img;
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"ViewControllerSegue" sender:self];
    }];
    NSLog(@"File conflict between %@ and %@\n%@ last modified on %@\nError: %@", localFileURL.lastPathComponent, dropboxFile.filename, dropboxFile.filename, dropboxFile.lastModifiedDate, error);
}

- (void)dropboxBrowserDismissed:(DropboxBrowserViewController *)browser
{
    // This method is called after Dropbox Browser is dismissed. Do NOT dismiss DropboxBrowser from this method
    // Perform any UI updates here to display any new data from Dropbox Browser
    // ex. Update a UITableView that shows downloaded files or get the name of the most recently selected file:
    //     NSString *fileName = [DropboxBrowserViewController fileName];
}

- (void)dropboxBrowser:(DropboxBrowserViewController *)browser deliveredFileDownloadNotification:(UILocalNotification *)notification
{
    
}

@end

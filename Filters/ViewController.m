//
//  ViewController.m
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import "ViewController.h"
#import "FilterClassToName.h"
#import "SwipeView.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray* filters;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _filters = @[@"Original",
                 @"CILinearToSRGBToneCurve",
                 @"CIPhotoEffectChrome",
                 @"CIPhotoEffectFade",
                 @"CIPhotoEffectInstant",
                 @"CIPhotoEffectMono",
                 @"CIPhotoEffectNoir",
                 @"CIPhotoEffectProcess",
                 @"CIPhotoEffectTonal",
                 @"CIPhotoEffectTransfer",
                 @"CISRGBToneCurveToLinear",
                 @"CIVignetteEffect",
                 ];
    
    _mainImageView.image = _orgImage;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveImage:)];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveImage:(id)sender
{
    NSLog(@"Save Image To Device");
    UIImageWriteToSavedPhotosAlbum(_mainImageView.image, self, @selector(photoSaved:didFinishSavingWithError:contextInfo:), nil);
}

-(void)photoSaved:(id)sender didFinishSavingWithError:(NSError*)error contextInfo:(void*)context
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Image has been saved" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - Swipe View Delegates

-(NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return _filters.count;
}

-(UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel* label = nil;
    
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, swipeView.bounds.size.height, swipeView.bounds.size.height)];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        UIImageView* iv = [[UIImageView alloc] initWithFrame:view.frame];
        [view addSubview:iv];
        
        label = [[UILabel alloc] initWithFrame:view.frame];
//        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        label = (UILabel*)[view viewWithTag:1];
    }
    
    label.text = [FilterClassToName filterNameFromClass:[_filters objectAtIndex:index]];
    return view;
}

-(void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    if (index == 0) {
        
        _mainImageView.image = _orgImage;
        
        return;
    }
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:self.orgImage];
    CIFilter *filter = [CIFilter filterWithName:_filters[index]
                                  keysAndValues:kCIInputImageKey, ciImage, nil];
    [filter setDefaults];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    self.mainImageView.image = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
}

#pragma mark -

//-(IBAction)loadPhotosClicked:(id)sender
//{
//    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Import Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Library", @"Camera", @"Facebook", nil];
//    [actionSheet showInView:self.view];
//}
//
//#pragma mark - UIActionSheet Delegate
//
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"%d", buttonIndex);
//    if (buttonIndex == 0) {
//        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
//        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        imagePicker.delegate = self;
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }
//    if (buttonIndex == 1) {
//        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
//        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
//        imagePicker.delegate = self;
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }
//}
//
//#pragma mark - UIImagePickerController Delegate
//
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveImage:)];
//    
//    _mainImageView.image = info[UIImagePickerControllerOriginalImage];
//    _orgImage = _mainImageView.image;
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end

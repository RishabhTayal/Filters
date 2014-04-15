//
//  ViewController.m
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import "ViewController.h"
//#import "FilterClassToName.h"
#import "SwipeView.h"
#import "UIImage+FiltersImage.h"
#import "FilterClass.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "BDKNotifyHUD.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray* filters;
@property (strong) NSMutableArray* thumbnailArray;

@property (nonatomic, strong) IBOutlet UIImageView* mainImageView;
@property (nonatomic, strong) IBOutlet SwipeView* filtersCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _filters = [FilterClass filterInitialize];
    _thumbnailArray = [NSMutableArray new];
    _mainImageView.image = _orgImage;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveImage:)];
    
    _filtersCollectionView.pagingEnabled = NO;
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.screenName = @"Filter Screen";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveImage:(id)sender
{
    NSLog(@"Save Image To Device");
    NSString* albumName = @"FilterVilla";
    
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    
    [library saveImage:_mainImageView.image toAlbum:albumName withCompletionBlock:^(NSError *error) {

        // Create the HUD object; view can be a UIImageView, an icon... you name it
        BDKNotifyHUD* hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"Checkmark.png"] text:@"Saved"];
        hud.center = CGPointMake(self.view.center.x, self.view.center.y - 20);
        
        // Animate it, then get rid of it. These settings last 1 second, takes a half-second fade.
        [self.view addSubview:hud];
        [hud presentWithDuration:1.0f speed:0.5f inView:self.view completion:^{
            [hud removeFromSuperview];
        }];
    }];
}

#pragma mark - Swipe View Delegates

-(NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return _filters.count;
}

-(UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel* label = nil;
    UIImageView* iv = nil;
    
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, swipeView.bounds.size.height, swipeView.bounds.size.height)];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        CGRect frame = view.frame;
        int offset = 5;
        iv = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x + offset, frame.origin.y + offset, frame.size.height - offset - offset, frame.size.height - offset - offset)];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = YES;
        iv.tag = 1;
        [view addSubview:iv];
        
        UIImageView* borderIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, swipeView.bounds.size.height, swipeView.bounds.size.height)];
        borderIV.contentMode = UIViewContentModeScaleAspectFill;
        borderIV.clipsToBounds = YES;
        borderIV.image = [UIImage imageNamed:@"border.png"];
        [view addSubview:borderIV];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 40, view.frame.size.width, 40)];
        //        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        label.tag = 2;
        [view addSubview:label];
    }
    else
    {
        iv = (UIImageView*)[view viewWithTag:1];
        label = (UILabel*)[view viewWithTag:2];
    }
    
    if (_thumbnailArray.count > index) {
        iv.image = _thumbnailArray[index];
    } else{
        UIImage* img = [UIImage scaleAndRotateImage:_orgImage scale:iv.frame.size];
        if (index == 0) {
            iv.image = img;
        }else {
            iv.image = [self applyFilter:_filters[index] toImage:img];
        }
        [_thumbnailArray addObject:iv.image];
    }
    
    label.text = ((FilterClass*)_filters[index]).filterName;
    
    return view;
}

-(void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    if (index == 0) {
        
        _mainImageView.image = _orgImage;
        
        return;
    }
    
    UIImage* img = [UIImage scaleAndRotateImage:_orgImage scale:CGSizeZero];
    
    self.mainImageView.image = [self applyFilter:_filters[index] toImage:img];
}

#pragma mark -

-(UIImage*)applyFilter:(FilterClass*)filterObj toImage:(UIImage*)image
{
    NSString* filterName = filterObj.className;
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:filterName];
    
    [filter setDefaults];
    
    [filter setValue:ciImage forKey:kCIInputImageKey];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    UIImage* returnImage = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return returnImage;
}

@end

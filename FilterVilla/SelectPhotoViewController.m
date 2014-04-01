//
//  SelectPhotoViewController.m
//  Filters
//
//  Created by Rishabh Tayal on 3/31/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import "ViewController.h"

@interface SelectPhotoViewController ()

@property (nonatomic, strong) UIImage* image;

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)loadPhotosClicked:(id)sender
{
    //    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Import Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Library", @"Camera", @"Facebook", nil];
    //    [actionSheet showInView:self.view];
    
    UIButton* button = (UIButton*)sender;
    
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if (button.tag == 1) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    if (button.tag == 2) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    if (button.tag == 3) {
        
    }
}

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
    if ([segue.identifier isEqualToString:@"ViewControllerSegue"]) {
        ViewController* vc = segue.destinationViewController;
        vc.orgImage = _image;
    }
}

@end

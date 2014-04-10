//
//  FacebookPhotoViewController.m
//  FilterVilla
//
//  Created by Rishabh Tayal on 4/10/14.
//  Copyright (c) 2014 Appikon. All rights reserved.
//

#import "FacebookPhotoViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "UIImageView+AFNetworking.h"

@interface FacebookPhotoViewController ()

@property (strong) NSMutableArray* datasource;

@end

@implementation FacebookPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _datasource = [[NSMutableArray alloc] init];
    
    //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self sendRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendRequest {
    NSString* graphPath = [NSString stringWithFormat:@"/%@?fields=photos", _albumId];
    
    [FBRequestConnection startWithGraphPath:graphPath parameters:nil HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSDictionary* resultDict = (NSDictionary*)result;
        
        NSDictionary* dict  = [resultDict objectForKey:@"photos"];
        NSArray* array = [dict objectForKey:@"data"];
        for (NSDictionary* innerDict in array) {
            NSString* source = [innerDict objectForKey:@"source"];
            [_datasource addObject:source];
        }
        [self.collectionView reloadData];
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datasource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cell";
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIImageView* imageView = (UIImageView*)[cell viewWithTag:100];
    [imageView setImageWithURL:[NSURL URLWithString:[_datasource objectAtIndex:indexPath.row]]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate) {
        UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
        UIImageView* imageView = (UIImageView*)[cell viewWithTag:100];
        [_delegate faceBookViewController:self didSelectPhoto:imageView.image];
    }
}

@end

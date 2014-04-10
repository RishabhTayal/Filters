//
//  ViewController.m
//  FacebookAlbum
//
//  Created by Rishabh Tayal on 4/10/14.
//
//

#import "FacebookAlbumViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FacebookPhotoViewController.h"

@interface FacebookAlbumViewController ()

@property (strong) NSMutableArray* datasource;

@end

@implementation FacebookAlbumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneSelected:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutFacebook:)];
    
    if (FBSession.activeSession.isOpen) {
        // login is integrated with the send button -- so if open, we send
        [self sendRequests];
    } else {
        NSArray* permissions = [NSArray arrayWithObjects:@"basic_info", @"user_photos", nil];
        [FBSession openActiveSessionWithReadPermissions:permissions
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState status,
                                                          NSError *error) {
                                          // if login fails for any reason, we alert
                                          if (error) {
                                              NSLog(@"%@", error.localizedDescription);
                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not connect to Facebook."
                                                                                              message:@"Please try again."
                                                                                             delegate:self
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil];
                                              [alert show];
                                              // if otherwise we check to see if the session is open, an alternative to
                                              // to the FB_ISSESSIONOPENWITHSTATE helper-macro would be to check the isOpen
                                              // property of the session object; the macros are useful, however, for more
                                              // detailed state checking for FBSession objects
                                          } else if (FB_ISSESSIONOPENWITHSTATE(status)) {
                                              // send our requests if we successfully logged in
                                              [self sendRequests];
                                          }
                                      }];
    }
    
    
    
    _datasource = [[NSMutableArray alloc] init];
}

- (void)sendRequests {
    // create the connection object
    NSString* graphPath = @"/me/albums";
    [FBRequestConnection startWithGraphPath:graphPath parameters:nil HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSDictionary* resultDict = (NSDictionary*)result;
        _datasource = [NSMutableArray arrayWithArray:[resultDict objectForKey:@"data"]];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doneSelected:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)logoutFacebook:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure you want to logout of Facebook and revoke Facebook acces for FilterVilla?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [FBRequestConnection startWithGraphPath:@"/me/permissions" parameters:nil HTTPMethod:@"DELETE" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            NSLog(@"%@", result);
        }];
        [[FBSession activeSession] closeAndClearTokenInformation];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [[_datasource objectAtIndex:indexPath.row] objectForKey:@"name"];
    
//    NSString* graphPath = [NSString stringWithFormat:@"/%@/picture", [[_datasource objectAtIndex:indexPath.row] objectForKey:@"id"]];
//    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:@"thumbnail", @"type", nil];
//    [FBRequestConnection startWithGraphPath:graphPath parameters:params HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//        NSLog(@"%@", result);
//    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FacebookPhotoViewController*vc = [sb instantiateViewControllerWithIdentifier:@"FacebookPhotoViewController"];
    vc.albumId = [[_datasource objectAtIndex:indexPath.row] objectForKey:@"id"];
    vc.delegate = _delegate;
    vc.title = [[_datasource objectAtIndex:indexPath.row] objectForKey:@"name"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

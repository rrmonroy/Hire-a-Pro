//
//  ShowResultsViewController.m
//  HireAPro
//
//  Created by Ruben Ramos on 9/10/15.
//  Copyright (c) 2015 Ruben Ramos. All rights reserved.
//

#import "ShowResultsViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "Person.h"
#import "LoginViewController.h"
#import "WALLViewController.h"


@interface ShowResultsViewController ()
@property (nonatomic, retain) NSArray *resutlArray;
@property (nonatomic, retain) NSArray *resutlArraySec;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) FBLoginView* loginView;

//-(void)loadWallViews;
-(void)showErrorView:errorString;

@end



@implementation ShowResultsViewController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize fetchedResultsController = __fetchedResultsController;

@synthesize searchResults;
@synthesize activityIndicator = _loadingSpinner;
@synthesize userSelected;

@synthesize resutlArray = _resutlArray;
-(void)showErrorView:(NSString *)errorMsg{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    userSelected=@"";
    
    searchResults = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:SKILL_OBJECT  ];
    [query orderByDescending:KEY_CREATION_DATE];

    [query whereKey:@"Occupation" equalTo:self.occupation];
    
    NSLog(@"1");
    
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            self.resutlArray = nil;
            self.resutlArray = [[NSArray alloc] initWithArray:objects];
            
//            NSLog(@"%lo objects :: %@", (long)self.resutlArray.count,objects);
            
            for (PFObject *resutlObject in self.resutlArray){
                PFQuery *query3 = [PFUser query];
                
                if ([resutlObject objectForKey:@"UserId"]) {
                    [query3 whereKey:@"objectId" equalTo:[resutlObject objectForKey:@"UserId"]];

                    NSArray *users = [query3 findObjects];
                    for (PFUser *resutlUsers in users){

                        NSLog(@"First name %@",[resutlUsers objectForKey:@"FirstName"]);

                        Person *person = [Person new];
                        person.userid = [resutlUsers objectForKey:@"FirstName"];
                        
                        person.name = [resutlUsers objectForKey:@"FirstName"];
                        person.lastname = [resutlUsers objectForKey:@"LastName"];
                        person.email = [resutlUsers objectForKey:@"email"];
                        person.username = [resutlUsers objectForKey:@"username"];
                        
                         person.profPicture = (PFFile *)[resutlUsers objectForKey:@"ProfPicture"];
                        
                        [searchResults addObject:person];
                    }
                }
                NSLog(@"2.4");
            }
            
            
            
            
            [self.tableView reloadData];
            
            //Remove the activity indicator
            [self.activityIndicator stopAnimating];
            [self.activityIndicator removeFromSuperview];
            
            
        } else {
            
            NSLog(@"2.2");
            //Remove the activity indicator
            [self.activityIndicator stopAnimating];
            [self.activityIndicator removeFromSuperview];
            
            //Show the error
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            [self showErrorView:errorString];
        }
    }];
    
    NSLog(@"3");
    NSLog(@"%@",self.resutlArray);
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload{
    searchResults = nil;
    
}

#pragma mark - Fetching
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"myRow";
    
    NSLog(@" cellForRowAtIndexPath %@",indexPath);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Person *person = [searchResults objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = person.userid ;
    
    UILabel *lbl_101 = (UILabel *)[cell viewWithTag:101];
    lbl_101.text = [NSString stringWithFormat:@"%@ %@", person.name,person.lastname] ;
    
    UILabel *lbl_102 = (UILabel *)[cell viewWithTag:102];
    lbl_102.text = person.email ;
    
    
    
    //Add the image
//    PFFile *image = (PFFile *)[wallObject objectForKey:KEY_IMAGE];
    
//    NSLog(@"image width %f  height %f  pantalla width %f",[UIImage imageWithData:image.getData].size.width,[UIImage imageWithData:image.getData].size.height,wallImageView.frame.size.width  );
    
    
    
    UIImageView *userImage = (UIImageView *)[cell viewWithTag:201];;

    userImage.image = [UIImage imageWithData:person.profPicture.getData];
    //[[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
    /*
    if ([UIImage imageWithData:person.profPicture.getData].size.width>[UIImage imageWithData:person.profPicture.getData].size.height) {
        //            userImage.frame = CGRectMake(0, 0, wallImageView.frame.size.width, 200);
        
        int yy=0;
        int xx = [UIImage imageWithData:person.profPicture.getData].size.width/300;
        
        yy=[UIImage imageWithData:person.profPicture.getData].size.height/xx;
        if (yy>200) {
            
            yy=0;
            xx = [UIImage imageWithData:person.profPicture.getData].size.height/200;
            
            yy=[UIImage imageWithData:person.profPicture.getData].size.width/xx;
            
            
            userImage.frame = CGRectMake((300-yy)/2, 0, yy, 200);
            
        }else{
            userImage.frame = CGRectMake(0, 0, 300, yy);
        }
    }else{
        int yy=0;
        int xx = [UIImage imageWithData:person.profPicture.getData].size.height/200;
        
        yy=[UIImage imageWithData:person.profPicture.getData].size.width/xx;
        
        userImage.frame = CGRectMake((300-yy)/2, 0, yy, 200);
    }
    */
    
    userImage.userInteractionEnabled = YES;
    userImage.contentMode = UIViewContentModeScaleAspectFit;
    
    userImage.layer.cornerRadius = (userImage.frame.size.width / 2);
    userImage.layer.borderWidth = 2.0f;
    userImage.layer.borderColor = [UIColor grayColor].CGColor;
    userImage.clipsToBounds = YES;
    
    
    
//    [wallImageView addSubview:userImage];
    
    
    
    
    
    //   cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    
    return cell;
}
/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 static NSString *CellIdentifier = @"myRow";
 
 
 NSLog(@" cellForRowAtIndexPath %@",indexPath);
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 //cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
 cell.textLabel.text =@"hoo";
 
 
 // Configure the cell...
 
 return cell;
 }
 
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@" numberOfRowsInSection ");
    
    //    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
    NSLog(@"%lu",(unsigned long)[searchResults count]);
    return [searchResults count];
    
    
}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    // test to see if we can use the share dialog built into the Facebook application
    /*
     FBLinkShareParams *p = [[FBLinkShareParams alloc] init];
     p.link = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
     BOOL canShareFB = [FBDialogs canPresentShareDialogWithParams:p];
     BOOL canShareiOS6 = [FBDialogs canPresentOSIntegratedShareDialogWithSession:nil];
     BOOL canShareFBPhoto = [FBDialogs canPresentShareDialogWithPhotos];
     */
    
    
    NSLog(@"loginViewShowingLoggedOutUser");
    
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"main"
                                                         bundle:nil];
    LoginViewController *add = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self presentViewController:add
                       animated:YES
                     completion:nil];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"showPortfolio"])
    {
        
        WALLViewController *destViewController = (WALLViewController*)segue.destinationViewController;
        
//        destViewController.user = userSelected;
        destViewController.viewType=@"Search";
        destViewController.userProfile=userSelected;
        
        NSLog(@"prepareForSegue :: user Selected %@",userSelected);
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    Person *person = [searchResults objectAtIndex:indexPath.row];
    userSelected=person.username;
    
    NSLog(@"user Selected %@",userSelected);
    
    [self performSegueWithIdentifier:@"showPortfolio" sender:self];
}




@end

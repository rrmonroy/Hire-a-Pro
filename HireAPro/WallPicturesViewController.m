//
//  WallPicturesViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "WallPicturesViewController.h"
#import "UploadImageViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "likeButton.h"


@interface WallPicturesViewController () {
    PFFile * profPic;
    
}

@property (nonatomic, retain) NSArray *wallObjectsArray;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;


-(void)getWallImages;
-(void)loadWallViews;
-(void)showErrorView:errorString;

@end

@implementation WallPicturesViewController

@synthesize wallObjectsArray = _wallObjectsArray;
@synthesize wallScroll = _wallScroll;
@synthesize activityIndicator = _loadingSpinner;

@synthesize user;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)didReceiveMemoryWarning{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
 
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    NSLog(@"viewDidLoad - wallPics - pass %@",    app.currentUser);
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];

    user = app.currentUser;
    
    PFQuery *query3 = [PFUser query];
    [query3 whereKey:@"username" equalTo:user]; // find all the women
    NSArray *users = [query3 findObjects];
    
//    Person *person = [Person new];
    
    
    
   // PFFile *image ; //= (PFFile *)[wallObject objectForKey:KEY_IMAGE];
    
    for (PFUser *resutlUsers in users){
        /*
        NSLog(@"First name %@",[resutlUsers objectForKey:@"FirstName"]);
        
        person.userid = [resutlUsers objectForKey:@"ObjectId"];
        
        person.username = [resutlUsers objectForKey:@"username"];
        person.firstname = [resutlUsers objectForKey:@"FirstName"];
        person.email = [resutlUsers objectForKey:@"email"];
        person.lastname = [resutlUsers objectForKey:@"LastName"];
        person.address = [resutlUsers objectForKey:@"Address"];
        person.city = [resutlUsers objectForKey:@"City"];
        person.state = [resutlUsers objectForKey:@"State"];
        person.zip = [resutlUsers objectForKey:@"Zip"];
        person.country = [resutlUsers objectForKey:@"Country"];
        person.phone = [resutlUsers objectForKey:@"Phone"];
        person.website = [resutlUsers objectForKey:@"Website"];
        person.facebookid = [resutlUsers objectForKey:@"FacebookId"];
        person.profileid = [resutlUsers objectForKey:@"ProfileId"];
        person.profilestatus = [resutlUsers objectForKey:@"ProfileStatus"];
        person.status = [resutlUsers objectForKey:@"Status"];
        person.comments = [resutlUsers objectForKey:@"Comments"];
        //ProfPicture
        */
        profPic = (PFFile *)[resutlUsers objectForKey:@"ProfPicture"];
    }
    
    
    
    
}
- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.wallScroll = nil;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    NSLog(@"viewWillAppear - wallPics");
    
    //Clean the scroll view
    for (id viewToRemove in [self.wallScroll subviews]){
        if ([viewToRemove isMemberOfClass:[UIView class]])
            [viewToRemove removeFromSuperview];
    }

    //Reload the wall
    [self getWallImages];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Wall Load
//Load the images on the wall
//Load the images on the wall
-(void)loadWallViews{
    //Clean the scroll view
    for (id viewToRemove in [self.wallScroll subviews]){
        
        if ([viewToRemove isMemberOfClass:[UIView class]])
            [viewToRemove removeFromSuperview];
    }
    
    
    //For every wall element, put a view in the scroll
    int originY = 10;
    
    likeButton *btn_like;
//    = [likeButton buttonWithType:UIButtonTypeRoundedRect];
  //  [btn_like addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
   // [btn_like setTitle:@"Like" forState:UIControlStateNormal];
    
    for (PFObject *wallObject in self.wallObjectsArray){
        //Get Likes
        //PFQuery *query3 = [PFUser query];
        
        btn_like = [likeButton buttonWithType:UIButtonTypeRoundedRect];
        [btn_like addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

        
        PFQuery *query5 = [PFQuery queryWithClassName:@"Likes"];
        [query5 whereKey:@"WallId" equalTo:wallObject.objectId];
        [query5 whereKey:@"UserId" equalTo:user];
        NSArray* scoreArray = [query5 findObjects];
        if (scoreArray.count>0)
            [btn_like setTitle:@"Liked" forState:UIControlStateNormal];
        else
            [btn_like setTitle:@"Like" forState:UIControlStateNormal];

        // Machine row will be an object inside the retrieved product row.
  //          PFObject *machine = wallObject[@"machine"];
        
        NSLog(@"Likes: %@", scoreArray);

        
        
        
/*
        PFQuery *query3 = [PFQuery queryWithClassName:@"Likes"  ];
        

            [query3 whereKey:@"WallId" equalTo:wallObject.objectId];
            [query3 whereKey:@"UserId" equalTo:user];
        
//            NSArray *likes = [query3 findObjects];

        NSLog(@"1----");
        [query3 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if (!error) {
                //Everything was correct, put the new objects and load the wall
                //self.wallObjectsArray = nil;
                //self.wallObjectsArray = [[NSArray alloc] initWithArray:objects];
                
                //[self loadWallViews];
                NSLog(@"2---- %lu",(unsigned long)objects.count);
                
                    [btn_like setTitle:[NSString stringWithFormat:@"Likes2 %lu",(unsigned long)objects.count] forState:UIControlStateNormal];
                
            } else {
                //Remove the activity indicator
//                [self.activityIndicator stopAnimating];
  //              [self.activityIndicator removeFromSuperview];
                
                //Show the error
                //NSString *errorString = [[error userInfo] objectForKey:@"error"];
                //[self showErrorView:errorString];
                NSLog(@"2----2");
            }
        }];
        NSLog(@"3----");
        
        */
        
        //Wall Image Height
        //Add the image
        PFFile *image = (PFFile *)profPic;
        
        image = (PFFile *)[wallObject objectForKey:KEY_IMAGE];
        
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
        float yy=0;
        float xx = [UIImage imageWithData:image.getData].size.width/(self.view.frame.size.width-30);
        yy=[UIImage imageWithData:image.getData].size.height/xx;
        userImage.frame = CGRectMake(15, 40, self.view.frame.size.width-30, yy);
        
        //Build the view with the image and the comments
        UIView *wallImageView = [[UIView alloc] initWithFrame:CGRectMake(0, originY, self.view.frame.size.width , yy+80)];
        [wallImageView setBackgroundColor:[UIColor whiteColor]];
        
        
        [wallImageView addSubview:userImage];
        
        image = (PFFile *)profPic;
        UIImageView *profPic1 = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
        profPic1.frame = CGRectMake(15, 0, 35, 35);
        
        
        
        
        NSLog(@"image width %f  height %f  pantalla width %f",[UIImage imageWithData:image.getData].size.width,[UIImage imageWithData:image.getData].size.height,wallImageView.frame.size.width  );
        
        
        [wallImageView addSubview:profPic1];
        
        //DATE UPDATE
        NSDate *creationDate = wallObject.createdAt;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm dd/MM yyyy"];
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200,20)];
        infoLabel.text = [NSString stringWithFormat:@"%@ ",user];
        infoLabel.font = [UIFont fontWithName:@"Arial-ItalicMT" size:12];
        infoLabel.textColor = [UIColor blackColor];
        infoLabel.backgroundColor = [UIColor clearColor];
//        [infoLabel setBackgroundColor:[UIColor greenColor]];

        infoLabel.textAlignment = NSTextAlignmentNatural;
        
        [wallImageView addSubview:infoLabel];

        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 17, 200,20)];
        infoLabel.text = [NSString stringWithFormat:@"%@", [df stringFromDate:creationDate]];
        infoLabel.font = [UIFont fontWithName:@"Arial-ItalicMT" size:10];
        infoLabel.textColor = [UIColor blackColor];
        infoLabel.backgroundColor = [UIColor clearColor];
        
        
        infoLabel.textAlignment = NSTextAlignmentNatural;
        
        [wallImageView addSubview:infoLabel];
        
        
        
        
        

        
        /*
        if ([UIImage imageWithData:image.getData].size.width>[UIImage imageWithData:image.getData].size.height) {
            //            userImage.frame = CGRectMake(0, 0, wallImageView.frame.size.width, 200);

            float xx = [UIImage imageWithData:image.getData].size.width/self.view.frame.size.width;
            
            yy=[UIImage imageWithData:image.getData].size.height/xx;
            if (yy>200) {
                
                yy=0;
                xx = [UIImage imageWithData:image.getData].size.height/200;
                
                yy=[UIImage imageWithData:image.getData].size.width/xx;
                
                
                userImage.frame = CGRectMake((self.view.frame.size.width-yy)/2, 40, yy, 200);
                NSLog(@"xx  %f yy %f",xx,yy);
                
            }else{
                userImage.frame = CGRectMake(0, 40, self.view.frame.size.width, yy);
            }
        }else{
            int yy=0;
            int xx = [UIImage imageWithData:image.getData].size.height/200;
            
            yy=[UIImage imageWithData:image.getData].size.width/xx;
            
            userImage.frame = CGRectMake((self.view.frame.size.width-yy)/2, 40, yy, 200);
        }
        */
        
        //Build the view with the image and the comments
//        UIView *wallImageView = [[UIView alloc] initWithFrame:CGRectMake(0, originY, self.view.frame.size.width , 270)];
//        [wallImageView setBackgroundColor:[UIColor lightGrayColor]];
        
        
//        NSLog(@"image width %f  height %f  pantalla width %f",[UIImage imageWithData:image.getData].size.width,[UIImage imageWithData:image.getData].size.height,wallImageView.frame.size.width  );
        
        
  
        
        //Add the info label (User and creation date)
        
        
        

        btn_like.frame = CGRectMake(15.0, yy+50, 50.0, 20.0);
        
        [btn_like setUserData:[NSString stringWithFormat:@"%@",wallObject.objectId]];
        
        NSLog(@"%@",wallObject.objectId);
        
        
        [wallImageView addSubview:btn_like];
        

        
        
        
        //Add the comment
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, yy+50, wallImageView.frame.size.width-85, 15)];
        commentLabel.text = [wallObject objectForKey:KEY_COMMENT];
        commentLabel.font = [UIFont fontWithName:@"ArialMT" size:13];
        commentLabel.textColor = [UIColor blackColor];
        commentLabel.backgroundColor = [UIColor clearColor];
        [wallImageView addSubview:commentLabel];
        
        [self.wallScroll addSubview:wallImageView];
        
        
        originY = originY + wallImageView.frame.size.height+10 ;
        
    }
    
    //Set the bounds of the scroll
    self.wallScroll.contentSize = CGSizeMake(self.wallScroll.frame.size.width, originY);
    
    //Remove the activity indicator
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
}
-(void) buttonClicked:(likeButton*)sender
{
    NSLog(@"userData %@", sender.userData);
    
    PFObject *saveObject = [PFObject objectWithClassName:@"Likes"];
    
    [saveObject setObject:sender.userData forKey:@"WallId"];
    [saveObject setObject:user forKey:@"UserId"];
    
    [saveObject save];
    /**/
}


#pragma mark Receive Wall Objects

//Get the list of images
-(void)getWallImages
{
    
    NSLog(@"getWallImages - wallPics %@",user);
    
    //Prepare the query to get all the images in descending order
    PFQuery *query = [PFQuery queryWithClassName:WALL_OBJECT  ];
//    [query includeKey:@"WallId"];
    [query whereKey:@"user" equalTo:user];
    
    [query orderByDescending:KEY_CREATION_DATE];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            //Everything was correct, put the new objects and load the wall
            self.wallObjectsArray = nil;
            self.wallObjectsArray = [[NSArray alloc] initWithArray:objects];
            

            
            [self loadWallViews];
            
        } else {
            //Remove the activity indicator
            [self.activityIndicator stopAnimating];
            [self.activityIndicator removeFromSuperview];
            
            //Show the error
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            [self showErrorView:errorString];
        }
    }];

}


#pragma mark IB Actions
-(IBAction)logoutPressed:(id)sender{
    //TODO
    //If logout succesful:
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Error Alert
-(void)showErrorView:(NSString *)errorMsg{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}


@end

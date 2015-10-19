//
//  WALLViewController.m
//  HireAPro
//
//  Created by Ruben Ramos on 10/7/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//

#import "WALLViewController.h"
#import "likeButton.h"


@interface WALLViewController ()

@end

@implementation WALLViewController{
    PFFile * profPic;
    
}
    @synthesize user;
    @synthesize viewType;
    @synthesize userProfile;

- (id) initWithCoder:(NSCoder *)aCoder{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"WallImageObject";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"user";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
    }
    return self;
}
- (void) viewDidLoad {
    
    // Do any additional setup after loading the view.

    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    // NSLog(@"viewDidLoad - wallPics - pass %@",    app.currentUser);
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    user = app.currentUser;

    
    if (![viewType isEqualToString:@"Search"]) {
        userProfile = app.currentUser;
    }

    
    NSLog(@"current user: %@",userProfile);
    
    
    PFQuery *query3 = [PFUser query];
    [query3 whereKey:@"username" equalTo:userProfile];
    NSArray *users = [query3 findObjects];
    
    for (PFUser *resutlUsers in users){
        profPic = (PFFile *)[resutlUsers objectForKey:@"ProfPicture"];
    }
    
    //self.navigationController.navigationBar.hidden = YES;
    
    [super viewDidLoad];
    
}
- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (PFQuery *) queryForTable{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"user" equalTo:userProfile];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    /*    if ([self.objects count] == 0) {
     query.cachePolicy = kPFCachePolicyCacheThenNetwork;
     }*/
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
//    NSLog(@"1");
    //PFFile *thumbnail = [object objectForKey:@"image"];
  //  NSLog(@"2");

    int originY = 10;

    
    
    
    PFFile *image = (PFFile *)[object objectForKey:@"image"];
    
    UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
    float yy=0;
    float xx = [UIImage imageWithData:image.getData].size.width/(cell.frame.size.width-30);
    yy=[UIImage imageWithData:image.getData].size.height/xx;
    
    if (isnan(yy))
        yy=0;
    
    userImage.frame = CGRectMake(15, 40, cell.frame.size.width-30, yy);
    


    PFImageView *mainPicture = (PFImageView*)[cell viewWithTag:103];
    
  //  mainPicture.frame = CGRectMake(15, 40, self.view.frame.size.width-30, yy);
    
    mainPicture.image = [UIImage imageNamed:@"placeholder.jpg"];
    mainPicture.file = (PFFile *)[object objectForKey:@"image"];
    [mainPicture loadInBackground];
    
    
    //Build the view with the image and the comments
//    UIView *wallImageView = [[UIView alloc] initWithFrame:CGRectMake(0, originY, self.view.frame.size.width , yy+80)];
//    [wallImageView setBackgroundColor:[UIColor whiteColor]];
    
    
  //  [wallImageView addSubview:userImage];
   //   [cell addSubview:userImage];
    

    
    
    PFImageView *profPicture = (PFImageView*)[cell viewWithTag:100];
    profPicture.image = [UIImage imageNamed:@"placeholder.jpg"];
    profPicture.file = ((PFFile *)profPic);
    [profPicture loadInBackground];
    
    //image = ((PFFile *)profPic).getData;
    //UIImageView *profPic1 = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
    //profPic1.frame = CGRectMake(15, 0, 35, 35);
    
    //[cell addSubview:profPic1];
    
    
 //   NSLog(@"image width %f  height %f  pantalla width %f",[UIImage imageWithData:image.getData].size.width,[UIImage imageWithData:image.getData].size.height,wallImageView.frame.size.width  );
    
    
    
    
    
    
    //thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    //thumbnailImageView.file = thumbnail;
    //[thumbnailImageView loadInBackground];
    
    
    
    
    
    
    
    //NSLog(@"---> %@",[object objectForKey:@"user"]);
    
    UILabel *infoLabel = (UILabel*) [cell viewWithTag:101];
    infoLabel.text = [NSString stringWithFormat:@"%@ ",userProfile];
    
    
    NSDate *creationDate = [object createdAt];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm dd/MM yyyy"];
    
    //NSLog(@">>>>> %@ ", [NSString stringWithFormat:@"%@ ",creationDate]);
    
    //nameLabel.text = [object objectForKey:@"user"];
    
    UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:102];
    //NSDate *creationDate = [object objectForKey:@"createdAt"];
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
  //  [df setDateFormat:@"HH:mm dd/MM yyyy"];
    
    prepTimeLabel.text = [NSString stringWithFormat:@"%@", [df stringFromDate:creationDate]];
    
    
/*
    btn_like.frame = CGRectMake(15.0, yy+50, 50.0, 20.0);
    [btn_like setUserData:[NSString stringWithFormat:@"%@",wallObject.objectId]];
    NSLog(@"%@",wallObject.objectId);
    [wallImageView addSubview:btn_like];
  */



    UILabel *commentLabel = (UILabel*) [cell viewWithTag:104];
    //Add the comment
   // UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, yy+50, cell.frame.size.width-85, 15)];
    commentLabel.text = [object objectForKey:@"comment"];
    //commentLabel.font = [UIFont fontWithName:@"ArialMT" size:13];
    //commentLabel.textColor = [UIColor blackColor];
    //commentLabel.backgroundColor = [UIColor clearColor];
    //[cell addSubview:commentLabel];




    //  [cell addSubview:wallImageView];
    
    likeButton *iliked = (likeButton *)[cell viewWithTag:107];
    [iliked addTarget:self action:@selector(likeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [iliked setUserData:[NSString stringWithFormat:@"%@",[object objectId]]];
    
    PFQuery *query5 = [PFQuery queryWithClassName:@"Likes"];
    [query5 whereKey:@"WallId" equalTo:[object objectId]];
    [query5 whereKey:@"UserId" equalTo:user];
    NSArray* scoreArray = [query5 findObjects];

    if (scoreArray.count>0){
        for (PFObject *likeObject in scoreArray){
            [iliked setObjId:likeObject.objectId];
        }
        [iliked setImage:[UIImage imageNamed:@"Orange_Like.png"] forState:UIControlStateNormal];
        [iliked setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

    }else{
            [iliked setObjId:@""];
            [iliked setImage:[UIImage imageNamed:@"Gray_Like.png"] forState:UIControlStateNormal];
            [iliked setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
    }
       // [btn_like setTitle:@"Liked" forState:UIControlStateNormal];
//    else
        //[btn_like setTitle:@"Like" forState:UIControlStateNormal];
    
    // Machine row will be an object inside the retrieved product row.
    //          PFObject *machine = wallObject[@"machine"];
    
    
    
      //  iqty.text = [NSString stringWithFormat:@"Like"];
       // [iliked setImage:[UIImage imageNamed:@"Orange_Like.png"] forState:UIControlStateNormal];
      //  [iliked setImage:[UIImage imageNamed:@"Gray_Like.png"] forState:UIControlStateNormal];
    
    
    //NSLog(@"Likes: %@", scoreArray);
    
    
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.objects.count) {
        NSLog(@"----3");
        return 110.0f;  //last cell
    }else{
        NSLog(@"----4 %ld ::: %ld",(long)indexPath.row,(long)self.objects.count);
        PFObject* update = [self.objects objectAtIndex:indexPath.row];
        PFFile *image = (PFFile *)[update objectForKey:@"image"];
        NSLog(@"----41  ");
        float yy=0;
        float xx = [UIImage imageWithData:image.getData].size.width/(self.view.frame.size.width-30);
        yy=[UIImage imageWithData:image.getData].size.height/xx;

        NSLog(@"----5 %f ",yy);
        if (isnan(yy))
            return 110.0f;
        else
            return yy+100;
    }
}
- (void) objectsDidLoad:(NSError *)error{
    [super objectsDidLoad:error];
    
    //NSLog(@"error: %@", [error localizedDescription]);
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        /*
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RecipeDetailViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        Recipe *recipe = [[Recipe alloc] init];
        recipe.name = [object objectForKey:@"name"];
        recipe.imageFile = [object objectForKey:@"imageFile"];
        recipe.prepTime = [object objectForKey:@"prepTime"];
        recipe.ingredients = [object objectForKey:@"ingredients"];
        destViewController.recipe = recipe;
         */        
    }
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self adjustEdgeInsetsForTableView];
}
- (void) adjustEdgeInsetsForTableView {
    
    //NSLog(@"adjustEdgeInsetsForTableView");
    
    if(self.isMovingToParentViewController) {
        NSLog(@"---1");
        self.tableView.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + 30, 0, 0, 0);
    } else {
        NSLog(@"---2");
        self.tableView.contentInset = UIEdgeInsetsZero;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) likeClicked:(likeButton*)sender{
    //NSLog(@"userData %@", sender.userData);
    
    if ([sender.objId isEqualToString:@""]) {
        PFObject *saveObject = [PFObject objectWithClassName:@"Likes"];
        [saveObject setObject:sender.userData forKey:@"WallId"];
        [saveObject setObject:user forKey:@"UserId"];
        [saveObject save];
        [sender setImage:[UIImage imageNamed:@"Orange_Like.png"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
        
    }else{
        PFObject *object = [PFObject objectWithoutDataWithClassName:@"Likes"
                                                           objectId:sender.objId];
        [object deleteEventually];
        
        [sender setImage:[UIImage imageNamed:@"Gray_Like.png"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    }
    
    /**/
}

@end

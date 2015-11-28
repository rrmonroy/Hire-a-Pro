//
//  WALLViewController.m
//  HireAPro
//
//  Created by Ruben Ramos on 10/7/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//

#import "WALLViewController.h"
#import "likeButton.h"
#import "commentsViewController.h"

@interface WALLViewController ()

@end

@implementation WALLViewController{
    PFFile * profPic;
    NSString *fullname;
    NSString *email;
    NSString *phone;
    NSString *wallId;
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
        
        fullname = [NSString stringWithFormat:@"%@ %@", [resutlUsers objectForKey:@"FirstName"],[resutlUsers objectForKey:@"LastName"]];
        email = [resutlUsers objectForKey:@"email"];
        phone = [resutlUsers objectForKey:@"Phone"];
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
    
    [query orderByAscending:@"isheader"];
    [query addDescendingOrder:@"createdAt"];


    return query;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
//    int originY = 10;

    if (indexPath.row == 0) {
        
        UILabel *lblName = [[UILabel alloc] init];
        [lblName setFrame:CGRectMake(140,15,200,20)];
        lblName.backgroundColor=[UIColor clearColor];
        lblName.textColor=[UIColor blackColor];
        lblName.userInteractionEnabled=YES;
        lblName.text= fullname;
        [lblName setFont:[UIFont systemFontOfSize:12]];
        [cell addSubview:lblName];

        
        UILabel *lblEmail = [[UILabel alloc] init];
        [lblEmail setFrame:CGRectMake(140,40,200,20)];
        lblEmail.backgroundColor=[UIColor clearColor];
        lblEmail.textColor=[UIColor blackColor];
        lblEmail.userInteractionEnabled=YES;
        lblEmail.text= email;
        [lblEmail setFont:[UIFont systemFontOfSize:12]];
        [cell addSubview:lblEmail];
        
        UILabel *lblPhone = [[UILabel alloc] init];
        [lblPhone setFrame:CGRectMake(140,65,300,20)];
        lblPhone.backgroundColor=[UIColor clearColor];
        lblPhone.textColor=[UIColor blackColor];
        lblPhone.userInteractionEnabled=YES;
        lblPhone.text= phone;
        [lblPhone setFont:[UIFont systemFontOfSize:12]];
        [cell addSubview:lblPhone];
        
        UILabel *infoLabel = (UILabel*) [cell viewWithTag:101];
        [infoLabel setHidden:TRUE];
        
        UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:102];
        [prepTimeLabel setHidden:TRUE];
        
        UILabel *commentLabel = (UILabel*) [cell viewWithTag:104];
        [commentLabel setHidden:TRUE];
        
        likeButton *iliked = (likeButton *)[cell viewWithTag:107];
        [iliked setHidden:TRUE];

        
        UILabel *lblRecommender = [[UILabel alloc] init];
        [lblRecommender setFrame:CGRectMake(110,150,100,20)];
        lblRecommender.backgroundColor=[UIColor clearColor];
        lblRecommender.textColor=[UIColor redColor];
        lblRecommender.userInteractionEnabled=YES;
        lblRecommender.text= @"20";
        lblRecommender.textAlignment = NSTextAlignmentCenter;
        [lblRecommender setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
        [cell addSubview:lblRecommender];

        UILabel *lblRecommenderT = [[UILabel alloc] init];
        [lblRecommenderT setFrame:CGRectMake(110,170,100,20)];
        lblRecommenderT.backgroundColor=[UIColor clearColor];
        lblRecommenderT.textColor=[UIColor blackColor];
        lblRecommenderT.userInteractionEnabled=YES;
        lblRecommenderT.text= @"Recommenders";
        lblRecommenderT.textAlignment = NSTextAlignmentCenter;
        [lblRecommenderT setFont:[UIFont systemFontOfSize:12]];
        [cell addSubview:lblRecommenderT];

        
        UILabel *lblPost = [[UILabel alloc] init];
        [lblPost setFrame:CGRectMake(20,150,80,20)];
        lblPost.backgroundColor=[UIColor clearColor];
        lblPost.textColor=[UIColor redColor];
        lblPost.userInteractionEnabled=YES;
        lblPost.text= @"10";
        lblPost.textAlignment = NSTextAlignmentCenter;
        [lblPost setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
        [cell addSubview:lblPost];
        
        UILabel *lblPostT = [[UILabel alloc] init];
        [lblPostT setFrame:CGRectMake(20,170,80,20)];
        lblPostT.backgroundColor=[UIColor clearColor];
        lblPostT.textColor=[UIColor blackColor];
        lblPostT.userInteractionEnabled=YES;
        lblPostT.text= @"Posts";
        lblPostT.textAlignment = NSTextAlignmentCenter;
        [lblPostT setFont:[UIFont systemFontOfSize:12]];
        [cell addSubview:lblPostT];
        
        
        UILabel *lblLikes = [[UILabel alloc] init];
        [lblLikes setFrame:CGRectMake(220,150,80,20)];
        lblLikes.backgroundColor=[UIColor clearColor];
        lblLikes.textColor=[UIColor redColor];
        lblLikes.userInteractionEnabled=YES;
        lblLikes.text= @"200";
        lblLikes.textAlignment = NSTextAlignmentCenter;
        [lblLikes setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
        [cell addSubview:lblLikes];
        
        UILabel *lblLikesT = [[UILabel alloc] init];
        [lblLikesT setFrame:CGRectMake(220,170,80,20)];
        lblLikesT.backgroundColor=[UIColor clearColor];
        lblLikesT.textColor=[UIColor blackColor];
        lblLikesT.userInteractionEnabled=YES;
        lblLikesT.text= @"Likes";
        lblLikesT.textAlignment = NSTextAlignmentCenter;
        [lblLikesT setFont:[UIFont systemFontOfSize:12]];
        [cell addSubview:lblLikesT];

        
        PFFile *image = ((PFFile *)profPic);
        
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
        userImage.frame = CGRectMake(10, 10, 120, 120);
        
        PFImageView *mainPicture = [[PFImageView alloc] initWithFrame:CGRectMake(10,10,120,120)];;
        mainPicture.image = [UIImage imageNamed:@"placeholder.jpg"];
        mainPicture.file = image;
        [mainPicture loadInBackground];
        
        mainPicture.layer.cornerRadius = (mainPicture.frame.size.width / 2);
        mainPicture.layer.borderWidth = 2.0f;
        mainPicture.layer.borderColor = [UIColor grayColor].CGColor;
        mainPicture.clipsToBounds = YES;
        
        
        [cell addSubview:mainPicture];
        
        

    }
    else
    {
        PFFile *image = (PFFile *)[object objectForKey:@"image"];
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:image.getData]];
        float yy=0;
        float xx = [UIImage imageWithData:image.getData].size.width/(cell.frame.size.width-30);
        yy=[UIImage imageWithData:image.getData].size.height/xx;
    
        if (isnan(yy))
            yy=0;
    
        userImage.frame = CGRectMake(15, 40, cell.frame.size.width-30, yy);

        PFImageView *mainPicture = (PFImageView*)[cell viewWithTag:103];
        mainPicture.image = [UIImage imageNamed:@"placeholder.jpg"];
        mainPicture.file = (PFFile *)[object objectForKey:@"image"];
        [mainPicture loadInBackground];

        PFImageView *profPicture = (PFImageView*)[cell viewWithTag:100];
        profPicture.image = [UIImage imageNamed:@"placeholder.jpg"];
        profPicture.file = ((PFFile *)profPic);
        [profPicture loadInBackground];
        
        profPicture.layer.cornerRadius = (profPicture.frame.size.width / 2);
        profPicture.layer.borderWidth = 2.0f;
        profPicture.layer.borderColor = [UIColor grayColor].CGColor;
        profPicture.clipsToBounds = YES;
        
        
        
    
        UILabel *infoLabel = (UILabel*) [cell viewWithTag:101];
        infoLabel.text = [NSString stringWithFormat:@"%@ ",userProfile];
    
        NSDate *creationDate = [object createdAt];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm dd/MM yyyy"];
        
        UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:102];
        prepTimeLabel.text = [NSString stringWithFormat:@"%@", [df stringFromDate:creationDate]];

        UILabel *commentLabel = (UILabel*) [cell viewWithTag:104];
        commentLabel.text = [object objectForKey:@"comment"];
    
        likeButton *iliked = (likeButton *)[cell viewWithTag:107];
        [iliked addTarget:self action:@selector(likeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [iliked setUserData:[NSString stringWithFormat:@"%@",[object objectId]]];

        likeButton *iComment = (likeButton *)[cell viewWithTag:109];
        [iComment addTarget:self action:@selector(commentClicked:) forControlEvents:UIControlEventTouchUpInside];
        [iComment setUserData:[NSString stringWithFormat:@"%@",[object objectId]]];
        
        
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
    }
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (indexPath.row == 0) {
        return 200.0f;  //first cell
    }
    else if (indexPath.row == self.objects.count) {

        return 110.0f;  //last cell
    }else{
        PFObject* update = [self.objects objectAtIndex:indexPath.row];
        PFFile *image = (PFFile *)[update objectForKey:@"image"];
        float yy=0;
        float xx = [UIImage imageWithData:image.getData].size.width/(self.view.frame.size.width-30);
        yy=[UIImage imageWithData:image.getData].size.height/xx;

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
    if ([segue.identifier isEqualToString:@"showComments"])
    {
        commentsViewController *destViewController = (commentsViewController*)segue.destinationViewController;
        
        destViewController.wallId = wallId;
        
    }
    
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self adjustEdgeInsetsForTableView];
}
- (void) adjustEdgeInsetsForTableView {
    
    NSLog(@"adjustEdgeInsetsForTableView");
    NSLog(@"---> View %f",self.tableView.frame.origin.x);
    
    if(self.isMovingToParentViewController) {
        NSLog(@"---1");
        //self.tableView.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + 30, 0, 0, 0);
    } else {
        NSLog(@"---2");
        //self.tableView.contentInset = UIEdgeInsetsZero;
    }
    
    NSLog(@"---> View after  %f",self.tableView.frame.origin.x);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void) commentClicked:(likeButton*)sender{
    NSLog(@"userData %@", sender.userData);
    wallId = sender.userData;
    [self performSegueWithIdentifier:@"showComments" sender:self];
}
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

//
//  WALLViewController.m
//  HireAPro
//
//  Created by Ruben Ramos on 10/7/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//

#import "WALLViewController.h"

@interface WALLViewController ()

@end

@implementation WALLViewController{
    PFFile * profPic;
    
}
    @synthesize user;

- (id)initWithCoder:(NSCoder *)aCoder
{
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

- (void)viewDidLoad {
    
    // Do any additional setup after loading the view.
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"viewDidLoad - wallPics - pass %@",    app.currentUser);
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    user = app.currentUser;
    
    PFQuery *query3 = [PFUser query];
    [query3 whereKey:@"username" equalTo:user]; // find all the women
    NSArray *users = [query3 findObjects];
    
    for (PFUser *resutlUsers in users){
        profPic = (PFFile *)[resutlUsers objectForKey:@"ProfPicture"];
    }
    
    //self.navigationController.navigationBar.hidden = YES;
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"user" equalTo:user];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    /*    if ([self.objects count] == 0) {
     query.cachePolicy = kPFCachePolicyCacheThenNetwork;
     }*/
    
    [query orderByAscending:@"createdAt"];
    
    return query;
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
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
    
    [wallImageView addSubview:profPic1];
    
    
    NSLog(@"image width %f  height %f  pantalla width %f",[UIImage imageWithData:image.getData].size.width,[UIImage imageWithData:image.getData].size.height,wallImageView.frame.size.width  );
    
    
    
    
    
    //PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    //thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    //thumbnailImageView.file = thumbnail;
    //[thumbnailImageView loadInBackground];
    
    
    
    
    
    
    
    NSLog(@"---> %@",[object objectForKey:@"user"]);
    
    //UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    //nameLabel.text = [object objectForKey:@"user"];
    
    //UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:102];
    //prepTimeLabel.text = [object objectForKey:@"user"];
    
    //DATE UPDATE
    NSDate *creationDate = [object objectForKey:@"createdAt"];
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
    btn_like.frame = CGRectMake(15.0, yy+50, 50.0, 20.0);
    [btn_like setUserData:[NSString stringWithFormat:@"%@",wallObject.objectId]];
    NSLog(@"%@",wallObject.objectId);
    [wallImageView addSubview:btn_like];
  */
    
    
    
    
    //Add the comment
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, yy+50, wallImageView.frame.size.width-85, 15)];
    commentLabel.text = [object objectForKey:@"comment"];
    commentLabel.font = [UIFont fontWithName:@"ArialMT" size:13];
    commentLabel.textColor = [UIColor blackColor];
    commentLabel.backgroundColor = [UIColor clearColor];
    [wallImageView addSubview:commentLabel];
    

    
    
    
    [cell addSubview:wallImageView];
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.objects.count) {
        return 90.0f;  //last cell
    }else{
        
        PFObject* update = [self.objects objectAtIndex:indexPath.row];
        PFFile *image = (PFFile *)[update objectForKey:@"image"];
        float yy=0;
        float xx = [UIImage imageWithData:image.getData].size.width/(self.view.frame.size.width-30);
        yy=[UIImage imageWithData:image.getData].size.height/xx;
        
        return yy+90;
    }
}


- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    NSLog(@"error: %@", [error localizedDescription]);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self adjustEdgeInsetsForTableView];
}

- (void)adjustEdgeInsetsForTableView {
    if(self.isMovingToParentViewController) {
        self.tableView.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + 30, 0, 0, 0);
    } else {
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

@end

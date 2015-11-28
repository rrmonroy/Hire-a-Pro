//
//  commentsViewController.m
//  HireAPro
//
//  Created by Ruben Ramos on 11/28/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//

#import "commentsViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "Comment.h"

@interface commentsViewController ()
{
    
    CGFloat animatedDistance;
    NSString *userId;
}

@property (nonatomic, retain) NSArray *resutlArray;

@end

@implementation commentsViewController

@synthesize searchResults;
//@synthesize activityIndicator = _loadingSpinner;
//@synthesize resutlArray = _resutlArray;
@synthesize wallId ;
@synthesize resutlArray = _resutlArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFUser *currentUser = [PFUser currentUser];
    userId=@"";
    
        NSLog(@"viewDidLoad %@", wallId);

            NSLog(@"viewDidLoad %@", currentUser);
    if (currentUser) {
            NSLog(@"currentUser.objectId %@", currentUser.objectId);
        userId=currentUser.objectId;
    }
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tgr setCancelsTouchesInView:NO];
    
    [self.view addGestureRecognizer:tgr];
    
    [self.txt_comments setDelegate:self];

//    wallId=@"";
    
    searchResults = [[NSMutableArray alloc] init];
    
    [self loadTableComments];


    
}
- (void)loadTableComments{
    
    searchResults = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Comments"  ];
    [query orderByDescending:KEY_CREATION_DATE];
    
    [query whereKey:@"WallId" equalTo:wallId];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            self.resutlArray = nil;
            self.resutlArray = [[NSArray alloc] initWithArray:objects];
            
            //     NSLog(@"%lo objects :: %@", (long)self.resutlArray.count,objects);
            
            for (PFObject *resutlObject in self.resutlArray){
                
                
                PFQuery *query3 = [PFUser query];
                
                if ([resutlObject objectForKey:@"UserId"]) {
                    
                    [query3 whereKey:@"objectId" equalTo:[resutlObject objectForKey:@"UserId"]];
                    
                    NSArray *users = [query3 findObjects];
                    for (PFUser *resutlUsers in users){
                        
                        NSLog(@"First name %@",[resutlUsers objectForKey:@"FirstName"]);
                        
                        Comment *cmm = [Comment new];
                        cmm.UserId = [resutlObject objectForKey:@"UserId"];
                        cmm.objectId = [resutlObject objectForKey:@"objectId"];
                        cmm.Name = [NSString stringWithFormat:@"%@ %@",[resutlUsers objectForKey:@"FirstName"],[resutlUsers objectForKey:@"LastName"]];
                        
                        cmm.WallId = [resutlObject objectForKey:@"WallId"];

                        cmm.Comment = [resutlObject objectForKey:@"Comment"];
                        
                        cmm.profPicture = (PFFile *)[resutlUsers objectForKey:@"ProfPicture"];
                        
                        [searchResults addObject:cmm];
                    }
                }
                NSLog(@"2.4");
            }
            
            
            
            
            [self.tableView reloadData];
            
            //Remove the activity indicator
            
            
        } else {
            
            NSLog(@"2.2");
            //Remove the activity indicator
            
            //Show the error
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
  //          [self showErrorView:errorString];
        }
    }];


}
- (void)dismissKeyboard {
    [self.view endEditing:TRUE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    
    NSLog(@"btn_send_comment %@ :: %@  :: commenrs: %@", wallId ,userId,self.txt_comments.text);
    
    
    PFObject *saveObject = [PFObject objectWithClassName:@"Comments"];
    [saveObject setObject:wallId forKey:@"WallId"];
    [saveObject setObject:userId forKey:@"UserId"];
    [saveObject setObject:self.txt_comments.text forKey:@"Comment"];
    
    [saveObject save];

    
//    [self loadTableComments];
      [self performSelector:@selector(loadTableComments) withObject:nil afterDelay:1];
    [self.view endEditing:TRUE];
    
        return NO; // We do not want UITextField to insert line-breaks.
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.spaceViewFromBottom.constant = 0.0f;

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.spaceViewFromBottom.constant = 210.0f;
    
    
}


#pragma mark - Fetching
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"myRow";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Comment *cmm = [searchResults objectAtIndex:indexPath.row];
    
    UILabel *lbl_101 = (UILabel *)[cell viewWithTag:101];
    lbl_101.text = [NSString stringWithFormat:@"%@", cmm.Name] ;
    
    UILabel *lbl_102 = (UILabel *)[cell viewWithTag:102];
    lbl_102.text = cmm.Comment ;
    
    UIImageView *userImage = (UIImageView *)[cell viewWithTag:201];;
    
    userImage.image = [UIImage imageWithData:cmm.profPicture.getData];
    userImage.userInteractionEnabled = YES;
    userImage.contentMode = UIViewContentModeScaleAspectFit;
    userImage.layer.cornerRadius = (userImage.frame.size.width / 2);
    userImage.layer.borderWidth = 2.0f;
    userImage.layer.borderColor = [UIColor grayColor].CGColor;
    userImage.clipsToBounds = YES;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@" numberOfRowsInSection ");
    
    //    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
    NSLog(@"%lu",(unsigned long)[searchResults count]);
    return [searchResults count];
    
    
}


- (IBAction)btn_send_comment:(id)sender {

    
    
    
    
}
@end

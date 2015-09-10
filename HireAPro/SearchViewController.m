//
//  SearchViewController.m
//  HireaPro
//
//  Created by Ruben Ramos on 7/10/15.
//
//

#import "SearchViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "Person.h"
#import "LoginViewController.h"

@interface SearchViewController ()
@property (nonatomic, retain) NSArray *resutlArray;
@property (nonatomic, retain) NSArray *resutlArraySec;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) FBLoginView* loginView;

-(void)loadWallViews;
-(void)showErrorView:errorString;
@end



@implementation SearchViewController

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize fetchedResultsController = __fetchedResultsController;

@synthesize searchResults;
@synthesize activityIndicator = _loadingSpinner;


@synthesize resutlArray = _resutlArray;
-(void)showErrorView:(NSString *)errorMsg{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}
-(void)loadWallViews{
    //Clean the scroll view

//    searchResults=self.resutlArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];


    
    if ([app.loginWith isEqualToString:@"facebook"]) {
        self.loginView = [[FBLoginView alloc] init];
        self.loginView.frame = CGRectMake(-500, -500, 0, 0);
        [self.view addSubview:self.loginView];
        self.loginView.delegate = self;
        
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload{
    searchResults = nil;
    
}
- (IBAction)LogOut:(id)sender {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if ([app.loginWith isEqualToString:@"facebook"]) {
        for(id object in self.loginView.subviews){
            if([[object class] isSubclassOfClass:[UIButton class]]){
                UIButton* button = (UIButton*)object;
                [button sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }
        
    }else{
        [PFUser logOut];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"main"
                                                             bundle:nil];
        LoginViewController *add = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:add
                           animated:YES
                         completion:nil];
        
        
    }
    
    NSLog(@"end code");
    
    
}
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}

@end

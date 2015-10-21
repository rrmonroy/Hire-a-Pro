//
//  LoginViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "WallPicturesViewController.h"
#import <Parse/Parse.h>

#import "KeychainItemWrapper.h"

@interface LoginViewController (){

    NSString * cUser ;
    NSString * cUserId ;
}
@end

@implementation LoginViewController

@synthesize userTextField = _userTextField, passwordTextField = _passwordTextField;




- (void)toggleHiddenState:(BOOL)shouldHide{
    NSLog(@"   toggleHiddenState ");
    
    

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - View lifecycle
- (void)viewDidLoad{
        NSLog(@"viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


   // [SSKeychain setPassword:@"AnyPassword" forService:@"AnyService" account:@"AnyUser"]

//    NSString *password = [SSKeychain passwordForService:@"AnyService" account:@"AnyUser"];
    
    
    //Delete me
//    self.userTextField.text = @"222";
  //  self.passwordTextField.text = @"222";
    cUser   = @"";
    cUserId = @"";
    
    
    [[self userTextField]setDelegate:self];
    [[self passwordTextField]setDelegate:self];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];

    self.loginbtn.readPermissions = @[@"public_profile", @"email", @"user_friends"];

    
    self.loginbtn.delegate = self;
    
//    FBLoginView *loginView = [[FBLoginView alloc] init];
//    loginView.delegate = self;
    
  //  [self toggleHiddenState:YES];
//    self.lblLoginStatus.text = @"";
    
    
    
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"hireapro" accessGroup:nil];
    
    NSData *pass =[keychain objectForKey:(__bridge id)(kSecValueData)];
    NSString *passworddecoded = [[NSString alloc] initWithData:pass
                                                      encoding:NSUTF8StringEncoding];
    
    NSString *username = [keychain objectForKey:(id)kSecAttrAccount];
    
    NSLog(@"login %@  %@",username,passworddecoded);
    
    
    if (username.length>0) {
        
        [PFUser logInWithUsernameInBackground:username password:passworddecoded block:^(PFUser *user, NSError *error) {
            if (user) {
                //Open the wall
                
                // self.userTextField.text= [fbuser objectForKey:@"email"];
                cUser = username;
                [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
            }
            
        }];
        
    }
    
    if (FBSession.activeSession.isOpen) {
        NSLog(@"Its open");
    }
    /*
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"email", nil];
    
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState status,
                                                      NSError *error) {
                                      
                                      NSLog(@"%@",permissions);
                                          NSLog(@"%@", error);
                                      
                                      [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                          NSLog(@"%@", result);
                                          NSLog(@"%@", error);

                                          NSLog(@"%@", [result objectForKey:@"email"]);
                                      }];
                                      
                                  }];
    

    
    
    [FBRequestConnection startWithGraphPath:@"me"
                                 parameters:@{@"fields": @"first_name, last_name, picture.type(normal), email"}
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Set the use full name.
                                  NSLog(@" %@", [NSString stringWithFormat:@"%@ %@",
                                                           [result objectForKey:@"first_name"],
                                                           [result objectForKey:@"last_name"]
                                                           ]);
                                  
                                  // Set the e-mail address.
                              //    self.lblEmail.text = [result objectForKey:@"email"];
                                  
                                  // Get the user's profile picture.
                                 // NSURL *pictureURL = [NSURL URLWithString:[[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]];
                                  //self.imgProfilePicture.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:pictureURL]];
                                  
                                  // Make the user info visible.
                                  //[self hideUserInfo:NO];
                                  
                                  // Stop the activity indicator from animating and hide the status label.
                                 // self.lblStatus.hidden = YES;
                                //  [self.activityIndicator stopAnimating];
                                //  self.activityIndicator.hidden = YES;
                              }
                              else{
                                  NSLog(@"---> %@", [error localizedDescription]);
                              }
                          }];
        */
}
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
   NSLog(@"You are logged in.");
    
    [self toggleHiddenState:YES];
    
    
    
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField{
        NSLog(@"textFieldShouldReturn");
    if(textField.tag == 2 ){
        [textField resignFirstResponder];
        return YES;
    }
    else{
        //    return [textField resignFirstResponder];
        NSInteger nextTag = textField.tag + 1;
        // Try to find next responder
        
        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
        if (nextResponder) {
            // Found next responder, so set it.
            [nextResponder becomeFirstResponder];
        } else {
            // Not found, so remove keyboard.
            [textField resignFirstResponder];
        }
        return NO; // We do not want UITextField to insert line-breaks.
    }
    
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)fbuser{
    

    NSLog(@"-----> ");
    NSLog(@"-----> ");
    NSLog(@"-----> ");
    NSLog(@"-----> ");
    
    NSLog(@"loginViewFetchedUserInfo  %@", fbuser);
   // self.profilePicture.profileID = user.id;
   // self.lblUsername.text = user.name;
   // self.lblEmail.text = [user objectForKey:@"email"];
    NSLog(@"Email  %@",[fbuser objectForKey:@"email"]);
    NSLog(@"NAme  %@",fbuser.name);
    
    [PFUser logInWithUsernameInBackground:[fbuser objectForKey:@"email"] password:[fbuser objectForKey:@"id"] block:^(PFUser *user, NSError *error) {
        if (user) {
            //Open the wall

            // self.userTextField.text= [fbuser objectForKey:@"email"];
            cUser = [fbuser objectForKey:@"email"];
            
            NSLog(@"logInWithUsernameInBackground %@   email:%@   textField:%@",user,[fbuser objectForKey:@"email"],cUser);
            

            
            [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
            
        } else {

            
            NSLog(@"Create USer %@",cUser);
            
            if ([cUser isEqual:@""]) {

                PFUser *user = [PFUser user];
                user.username = [fbuser objectForKey:@"email"];
                user.password = [fbuser objectForKey:@"id"];
                

                
 //                user.objectId
                NSLog(@"validate USer");
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        //The registration was succesful, go to the wall
                        //self.userTextField.text= [fbuser objectForKey:@"email"];
                        cUser = [fbuser objectForKey:@"email"];
                        [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
                        
                    } else {
                        //Something bad has ocurred
                        NSString *errorString = [[error userInfo] objectForKey:@"error"];
                        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [errorAlertView show];
                    }
                }];
            }
            

        
        }
    }];

    
    
}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
  //  self.lblLoginStatus.text = @"You are logged out";
    NSLog(@"You are logged out");
    
    [self toggleHiddenState:YES];
}
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
   // NSLog(@"handleError --- %@", [error localizedDescription]);
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");

    [self.loginView setFrame:CGRectMake(self.loginView.frame.origin.x
                                        ,self.view.frame.size.height-465
                                        ,self.loginView.frame.size.width
                                        ,self.loginView.frame.size.height
                                        )];

    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
    
    if(textField.tag == 1 ){
        [self.loginView setFrame:CGRectMake(self.loginView.frame.origin.x
                                            ,self.view.frame.size.height-660
                                            ,self.loginView.frame.size.width
                                            ,self.loginView.frame.size.height
                                            )];

        
    }else{
        [self.loginView setFrame:CGRectMake(self.loginView.frame.origin.x
                                            ,self.view.frame.size.height-680
                                            ,self.loginView.frame.size.width
                                            ,self.loginView.frame.size.height
                                            )];

    }

    NSLog(@" tag: %ld",(long)textField.tag);

}
- (void)dismissKeyboard {
    NSLog(@"dismissKeyboard");
    [self.view endEditing:TRUE];
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    
    
    [self.loginView setFrame:CGRectMake(self.loginView.frame.origin.x,
                                        self.view.frame.size.height-465,self.loginView.frame.size.width,self.loginView.frame.size.height)];


}
- (void)viewDidUnload{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
//    self.userTextField = nil;
  //  self.passwordTextField = nil;
}


#pragma mark IB Actions

//Login button pressed
-(IBAction)logInPressed:(id)sender{
    
    NSLog(@"logInPressed");
    
    /*
    [PFUser logInWithUsernameInBackground:self.userTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            //Open the wall
             [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
     */
}
- (void) prepareForSegue: (UIStoryboardSegue *)segue sender:(id) sender{
    
    NSLog(@"prepareForSegue %@",segue.identifier);
    
    if ([segue.identifier isEqualToString:@"LoginSuccesful"])
    {
        
        

        NSLog(@"cUser %@",cUser);
        
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        app.currentUser = cUser;
        app.loginWith = @"facebook";
        
        
        
    }
}

@end

//
//  RegisterViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "RegisterViewController.h"
#import "WallPicturesViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>

@interface RegisterViewController ()
{
    
    NSString * cUser ;
    NSString * cUserId ;
}
@end

@implementation RegisterViewController

//@synthesize userRegisterTextField = _userRegisterTextField, passwordRegisterTextField = _passwordRegisterTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    
    [[self txt_fname]setDelegate:self];
    [[self txt_lname]setDelegate:self];
    
    [[self txt_street]setDelegate:self];
    [[self txt_city]setDelegate:self];
    [[self txt_state]setDelegate:self];
    [[self txt_zip]setDelegate:self];
    [[self txt_country]setDelegate:self];
    [[self txt_phone]setDelegate:self];
    
    [[self txt_email]setDelegate:self];
    [[self txt_pass1]setDelegate:self];
    [[self txt_pass2]setDelegate:self];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tgr setCancelsTouchesInView:NO];
    
    [self.view addGestureRecognizer:tgr];
    
    
    
}

- (void)dismissKeyboard {
    NSLog(@"dismissKeyboard");
    [self.view endEditing:TRUE];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn");
    if(textField.tag == 11 ){
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
//    self.userRegisterTextField = nil;
//    self.passwordRegisterTextField = nil;
}


#pragma mark IB Actions

////Sign Up Button pressed
- (IBAction)SaveBasicInfo:(id)sender {
    
        NSLog(@"SaveBasicInfo ");
    
    if ([self.txt_pass1.text isEqualToString:self.txt_pass2.text]) {
        
    
        NSLog(@"PFUser ");
        PFUser *user = [PFUser user];
        user.username = self.txt_email.text;
        user.password = self.txt_pass1.text;

        NSLog(@"Set Address ");
        
        [user setObject:self.txt_street.text forKey:@"Address"];
        
        
        [user setObject:self.txt_fname.text forKey:@"FirstName"];
        [user setObject:self.txt_lname.text forKey:@"LastName"];
        [user setObject:self.txt_city.text forKey:@"City"];
        [user setObject:self.txt_state.text forKey:@"State"];
        [user setObject:self.txt_zip.text forKey:@"Zip"];
        [user setObject:self.txt_country.text forKey:@"Country"];
        [user setObject:self.txt_phone.text forKey:@"Phone"];
        [user setObject:self.txt_email.text forKey:@"email"];
        
        [user setObject:@"Vendor" forKey:@"ProfileStatus"];
        
        
        
        
        //                user.objectId
        NSLog(@"validate USer");
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                PFObject *imageObject = [PFObject objectWithClassName:WALL_OBJECT];
                
                [imageObject setObject:[PFUser currentUser].username forKey:KEY_USER];
                [imageObject setObject:@"" forKey:KEY_COMMENT];
                [imageObject setObject:@1 forKey:@"isheader"];
                
                PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:52 longitude:-4];
                [imageObject setObject:point forKey:KEY_GEOLOC];
                
                [imageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded){
                        cUser = self.txt_email.text;
                        [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
                    }
                    else{
                        NSString *errorString = [[error userInfo] objectForKey:@"error"];
                        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error Login" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [errorAlertView show];
                    }
                }];
                
                
            } else {
                //Something bad has ocurred
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorAlertView show];
            }
        }];
    }else{

        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Diff Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
    
    
    }
}
/*
-(IBAction)signUpUserPressed:(id)sender
{
    PFUser *user = [PFUser user];
    user.username = self.userRegisterTextField.text;
    user.password = self.passwordRegisterTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was succesful, go to the wall
            [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];


}
 */
- (void) prepareForSegue: (UIStoryboardSegue *)segue sender:(id) sender{
    
    NSLog(@"prepareForSegue %@",segue.identifier);
    
    if ([segue.identifier isEqualToString:@"SignupSuccesful"])
    {
        
//        WallPicturesViewController *destViewController = (WallPicturesViewController *)segue.destinationViewController;
  //      destViewController.user1 = self.userRegisterTextField.text ;
        UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
 //       destViewController.title =  self.txt_email.text;
        
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        app.currentUser=self.txt_email.text;
        NSLog(@"viewDidLoad - wallPics - pass %@",    app.currentUser);
        

        
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
   
        [self.scrollView setContentOffset:CGPointMake(0, -40) animated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //  [self.lbl_footer setHidden:TRUE];
    // [self.lbl_footer1 setHidden:TRUE];
    
    if(textField.tag == 1 ){
//        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (textField.tag == 2){
  //      [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (textField.tag == 3){
        [self.scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }else if (textField.tag == 4){
        [self.scrollView setContentOffset:CGPointMake(0, 80) animated:YES];
    }else if (textField.tag == 5){
        [self.scrollView setContentOffset:CGPointMake(0, 110) animated:YES];
    }else if (textField.tag == 6){
        [self.scrollView setContentOffset:CGPointMake(0, 140) animated:YES];
    }else if (textField.tag == 7){
        [self.scrollView setContentOffset:CGPointMake(0, 170) animated:YES];
    }else if (textField.tag == 8){
        [self.scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    }else if (textField.tag == 9){
        [self.scrollView setContentOffset:CGPointMake(0, 260) animated:YES];
    }else if (textField.tag == 10){
        [self.scrollView setContentOffset:CGPointMake(0, 290) animated:YES];
    }else if (textField.tag == 11){
        [self.scrollView setContentOffset:CGPointMake(0, 320) animated:YES];
        
    }
    
    
    
    
}

@end

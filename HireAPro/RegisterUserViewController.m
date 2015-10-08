//
//  RegisterUserViewController.m
//  HireAPro
//
//  Created by Ruben Ramos on 9/15/15.
//  Copyright (c) 2015 Ruben Ramos. All rights reserved.
//

#import "RegisterUserViewController.h"
#import <Parse/Parse.h>

@interface RegisterUserViewController ()
{
    
    NSString * cUser ;
    NSString * cUserId ;
}

@end

@implementation RegisterUserViewController

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
        
        [user setObject:self.txt_fname.text forKey:@"FirstName"];
        [user setObject:self.txt_lname.text forKey:@"LastName"];
        [user setObject:self.txt_email.text forKey:@"email"];
        
        [user setObject:@"User" forKey:@"ProfileStatus"];
        
        
        
        
        //                user.objectId
        NSLog(@"validate USer");
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                //The registration was succesful, go to the wall
                //self.userTextField.text= [fbuser objectForKey:@"email"];
                cUser = self.txt_email.text;
                [self performSegueWithIdentifier:@"RegisterUser" sender:self];
                
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

- (void) prepareForSegue: (UIStoryboardSegue *)segue sender:(id) sender{
    
    NSLog(@"prepareForSegue %@",segue.identifier);
    
    if ([segue.identifier isEqualToString:@"RegisterUser"])
    {
        
        //        WallPicturesViewController *destViewController = (WallPicturesViewController *)segue.destinationViewController;
        //      destViewController.user1 = self.userRegisterTextField.text ;
        UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
//        destViewController.title =  self.txt_email.text;

        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        app.currentUser=self.txt_email.text;
        NSLog(@"viewDidLoad - wallPics - pass %@",    app.currentUser);
        
        
        
        
    }
}



@end

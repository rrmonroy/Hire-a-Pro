//
//  ProfileUITableView.m
//  HireAPro
//
//  Created by Ruben Ramos on 9/22/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//

#import "ProfileUITableView.h"
#import "KeychainItemWrapper.h"
#import "LoginViewController.h"

@implementation ProfileUITableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)logout:(id)sender {
    
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"hireapro" accessGroup:nil];
    
    [keychain resetKeychainItem];
    
//    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    /*
     if ([app.loginWith isEqualToString:@"facebook"]) {
     for(id object in self.loginView.subviews){
     if([[object class] isSubclassOfClass:[UIButton class]]){
     UIButton* button = (UIButton*)object;
     [button sendActionsForControlEvents:UIControlEventTouchUpInside];
     }
     }
     
     }else{
     */
    [PFUser logOut];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"main"
                                                         bundle:nil];
    LoginViewController *add = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
  //  [self  presentViewController:add
       //                animated:YES
     //                completion:nil];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
  //      [self presentViewController:add animated:YES completion:nil];
   // });
    
    //}
    
    NSLog(@"end code");
}

@end

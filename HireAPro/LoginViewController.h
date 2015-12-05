//
//  LoginViewController.h
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate ,UITextViewDelegate, FBLoginViewDelegate>



@property (strong, nonatomic) IBOutlet UIView *loginView;

-(IBAction)logInPressed:(id)sender;

@property (weak, nonatomic) IBOutlet FBLoginView *loginbtn;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *userConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *facebookConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *emailConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *guestConstraint;

-(void)toggleHiddenState:(BOOL)shouldHide;
@property (strong, nonatomic) IBOutlet UIButton *btn_user;

@property (strong, nonatomic) IBOutlet UIButton *btn_email;
@property (strong, nonatomic) IBOutlet UIButton *btn_guest;
@property (strong, nonatomic) IBOutlet UIImageView *img_logo;

@end

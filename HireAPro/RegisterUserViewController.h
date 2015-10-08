//
//  RegisterUserViewController.h
//  HireAPro
//
//  Created by Ruben Ramos on 9/15/15.
//  Copyright (c) 2015 Ruben Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface RegisterUserViewController : UIViewController<UITextFieldDelegate ,UITextViewDelegate>



- (IBAction)SaveBasicInfo:(id)sender;

    //-(IBAction)signUpUserPressed:(id)sender;
    @property (strong, nonatomic) IBOutlet UITextField *txt_fname;
    @property (strong, nonatomic) IBOutlet UITextField *txt_lname;



    @property (strong, nonatomic) IBOutlet UITextField *txt_email;
    @property (strong, nonatomic) IBOutlet UITextField *txt_pass1;
    @property (strong, nonatomic) IBOutlet UITextField *txt_pass2;

@end

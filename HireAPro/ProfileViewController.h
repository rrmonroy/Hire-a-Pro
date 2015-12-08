//
//  ProfileViewController.h
//  HireAPro
//
//  Created by Ruben Ramos on 7/28/15.
//  Copyright (c) 2015 Ruben Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ProfileViewController : UIViewController <UITextFieldDelegate ,UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

    @property (strong, nonatomic) IBOutlet UITextField *txt_username;
    @property (strong, nonatomic) IBOutlet UITextField *txt_address ;
    @property (strong, nonatomic) IBOutlet UITextField *txt_city;
    @property (strong, nonatomic) IBOutlet UITextField *txt_state;
    @property (strong, nonatomic) IBOutlet UITextField *txt_zip;
    @property (strong, nonatomic) IBOutlet UITextField *txt_country;
    @property (strong, nonatomic) IBOutlet UITextField *txt_phone;
    @property (strong, nonatomic) IBOutlet UITextField *txt_email;
    - (IBAction)change_profilePic:(id)sender;
    @property (strong, nonatomic) IBOutlet UIImageView *profile_pic;
    @property (strong, nonatomic) IBOutlet UITextField *txt_lastname;


    @property (strong, nonatomic) NSString *user;
    - (IBAction)Save:(id)sender;
    @property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
    - (IBAction)btn_cancel:(id)sender;

@end

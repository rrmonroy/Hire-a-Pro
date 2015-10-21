//
//  GuestSearchViewController.h
//  HireAPro
//
//  Created by Ruben Ramos on 7/27/15.
//  Copyright (c) 2015 Ruben Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuestSearchViewController : UIViewController <UITextFieldDelegate ,UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UITextField *txt_tools;

@property (strong, nonatomic) IBOutlet UISwitch *swi_nearme;

@property (strong, nonatomic) IBOutlet UITextField *txt_ocupation;
- (IBAction)btn_search:(id)sender;
@end

//
//  ServicesTableViewController.h
//  HireAPro
//
//  Created by Ruben Ramos on 7/29/15.
//  Copyright (c) 2015 Ruben Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ServicesTableViewController : UITableViewController

    @property (nonatomic, retain) NSMutableArray *searchResults;
    @property (strong, nonatomic) IBOutlet UIBarButtonItem *btn_save;
    - (IBAction)btn_save:(id)sender;

- (IBAction)btn_cancel:(id)sender;


@end

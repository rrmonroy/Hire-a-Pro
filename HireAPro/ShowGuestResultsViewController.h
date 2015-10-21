//
//  ShowGuestResultsViewController.h
//  HireAPro
//
//  Created by Ruben Ramos on 10/21/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ShowGuestResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


    @property (nonatomic, retain) NSMutableArray *searchResults;
    @property (nonatomic, retain) NSString *occupation;
    @property (strong, nonatomic) IBOutlet UITableView *tableView;

    @property (nonatomic, retain) NSString *userSelected;

@end

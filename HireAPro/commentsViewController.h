//
//  commentsViewController.h
//  HireAPro
//
//  Created by Ruben Ramos on 11/28/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentsViewController : UIViewController<UITextFieldDelegate ,UITextViewDelegate,UITableViewDelegate, UITableViewDataSource>

    @property (strong, nonatomic) IBOutlet UIView *view_comments;
    @property (strong, nonatomic) IBOutlet UITextField *txt_comments;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *spaceViewFromBottom;
@property (strong, nonatomic) IBOutlet UIButton *btn_send;

@property (nonatomic, retain) NSString *wallId;

    @property (nonatomic, retain) NSMutableArray *searchResults;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)btn_send_comment:(id)sender;

@end

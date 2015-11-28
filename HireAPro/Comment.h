//
//  Comment.h
//  HireAPro
//
//  Created by Ruben Ramos on 11/28/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Comment : NSObject
    @property (nonatomic, strong) NSString *objectId;
    @property (nonatomic, strong) NSString *UserId;
    @property (nonatomic, strong) NSString *Name;
    @property (nonatomic, strong) NSString *WallId;
    @property (nonatomic, strong) NSString *Comment;
    @property (nonatomic, strong) PFFile *profPicture;
@end

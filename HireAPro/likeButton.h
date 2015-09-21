//
//  likeButton.h
//  HireAPro
//
//  Created by Ruben Ramos on 9/18/15.
//  Copyright © 2015 Ruben Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface likeButton : UIButton {
    NSString * userData;
}
    @property (nonatomic, readwrite, retain) NSString * userData;

@end

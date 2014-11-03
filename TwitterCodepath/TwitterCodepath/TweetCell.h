//
//  TweetCell.h
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 11/2/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell

@property (nonatomic, weak) Tweet *tweet;

- (void)update;

@end

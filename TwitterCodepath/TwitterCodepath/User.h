//
//  User.h
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/29/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *screenName;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic, copy) NSString *tagline;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)currentUser;

+ (void)logout;

@end

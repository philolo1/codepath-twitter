//
//  LoginViewController.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/29/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "user.h"
#import "TweetsViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)onLogin:(id)sender {
  
  [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
    if (user != nil) {
      NSLog(@"Welcome to %@", user.name);
      
      TweetsViewController *vc = [[TweetsViewController alloc] init];
      UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
      
      [self presentViewController:nvc animated:YES completion:nil];
    } else {
      
    }
  }];
  
  }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

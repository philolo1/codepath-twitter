//
//  TweetsViewController.m
//  TwitterCodepath
//
//  Created by Patrick Klitzke on 10/30/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposerViewController.h"
#import "DetailsViewController.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation TweetsViewController
{
  NSArray *_tweets;
}



- (IBAction)onLogout:(id)sender {
  
  [User logout];
  
}

- (id)init
{
  if (self = [super init]) {
        
    
    self.title = @"Home";
    
    
    
    
  }
  
  return self;
}

#pragma mark TableView -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  Tweet *tweet = (Tweet *)_tweets[indexPath.row];
  TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
  cell.tweet = tweet;
  
  
  [cell update];
  
  return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  

  
  self.refreshControl = [[UIRefreshControl alloc] init];
  [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
  [self.tableView insertSubview:self.refreshControl atIndex:0];
  
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  

    UINib *movieCellNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
  [self.tableView registerNib:movieCellNib forCellReuseIdentifier:@"TweetCell"];

  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(newTweet:)];
  self.navigationItem.rightBarButtonItem = rightButton;
  
  UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout:)];
  self.navigationItem.leftBarButtonItem = leftButton;
  
  [self loadTweets];

  
     // Do any additional setup after loading the view from its nib.
}

- (void) onRefresh
{
  [self loadTweets];
}

- (void) loadTweets
{
  [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *result, NSError *error) {
    [self.refreshControl endRefreshing];
    _tweets = result;
    [self.tableView reloadData];
  }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  DetailsViewController *vc = [[DetailsViewController alloc] init];
  vc.tweet = _tweets[indexPath.row];
  
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)newTweet:(id)sender
{
  ComposerViewController *vc = [[ComposerViewController alloc] init];
  UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
  
  [self.navigationController presentViewController:nvc animated:YES completion:nil];
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

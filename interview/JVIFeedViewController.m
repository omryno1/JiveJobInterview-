//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIFeedViewController.h"
#import "UIView+JVIView.h"
#import "JVIFeedTableViewCell.h"
#import "JVITwitterService.h"
#import "JVITweet.h"
#import "JVIEntities.h"

@interface JVIFeedViewController ()

//State
@property (strong, nonatomic) NSArray<JVITweet *> *items;

@end

@implementation JVIFeedViewController

NSString *tweetID = nil;

- (void)loadView {
    [super loadView];

    self.title = NSLocalizedString(@"interview.title", @"iOS Interview");

    self.items = [[NSArray alloc] init];
    
    UIBarButtonItem *addTweet = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTweet)];
    self.navigationItem.rightBarButtonItem = addTweet;

    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[JVIFeedTableViewCell class] forCellReuseIdentifier:[JVIFeedTableViewCell cellIdentifier]];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlTriggered:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    
    [self.tableView setContentOffset:CGPointMake(0, - self.refreshControl.height) animated:NO];

    [self loadMainFeed];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JVITweet *tweet = self.items[indexPath.row];
    
    JVIFeedTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[JVIFeedTableViewCell cellIdentifier] forIndexPath:indexPath];
    
    [cell updateData:tweet];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JVITweet *tweet = self.items[indexPath.row];
    NSLog(@"%@",tweet);
    
    //Building the url of the specipied Tweet
    
    NSString *tweetID = [tweet id];
    NSString *username = [tweet name];
    NSString *tweetURL = [NSString stringWithFormat:@"https://twitter.com/%@/status/%@",username, tweetID];
    
    NSURL *url = [NSURL URLWithString:tweetURL];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JVITweet *tweet = self.items[indexPath.row];
    CGFloat hasImage = 0;
    if (tweet.entities.media != nil)
        hasImage = 230;
    return [JVIFeedTableViewCell heightForWidth:self.view.width Text:tweet.text imageHeight: hasImage];
}


- (void)refreshControlTriggered:(id)sender {
    
    int itemsLength = (int)[_items count] - 1 ;
    tweetID = [_items[itemsLength] id];
    [self loadMainFeed];
}

- (void)loadMainFeed {
    [self.refreshControl beginRefreshing];
    
    [[JVITwitterService sharedService] getHomeTimelineWithSuccess:^(NSArray<JVITweet *> *list) {
        [self.refreshControl endRefreshing];
        self.items = list;
        [self.tableView reloadData];
    } TweetID: tweetID failed:^(NSError *error) {
        [self.refreshControl endRefreshing];
        NSLog(@"Failed getting feed. %@", error);
    }];
}

-(void) addTweet{
    UIAlertController *add = [UIAlertController alertControllerWithTitle:@"Upload new Tweet" message:@"Enter Your Tweet :" preferredStyle:UIAlertControllerStyleAlert];
    
    [add addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Tweet away ...";
        
    }];
    
    
    
    
    UIAlertAction *upload = [UIAlertAction actionWithTitle:@"Upload" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([add textFields].firstObject != nil){
            UITextField *text = [add textFields].firstObject;
            if ([[text text]  isEqual: @"#jiveisrael interview"]) {
                NSLog(@"Do Somthing");
            }
        }
    }];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [add addAction:upload];
    [add addAction:cancel];
    
    [self presentViewController: add animated:true completion:nil];
}



@end

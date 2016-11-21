//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIFeedViewController.h"
#import "UIView+JVIView.h"
#import "JVIFeedTableViewCell.h"
#import "JVITwitterService.h"
#import "JVITweet.h"

@interface JVIFeedViewController ()

//State
@property (strong, nonatomic) NSArray<JVITweet *> *items;

@end

@implementation JVIFeedViewController

- (void)loadView {
    [super loadView];

    self.title = NSLocalizedString(@"interview.title", @"iOS Interview");

    self.items = [[NSArray alloc] init];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[JVIFeedTableViewCell class] forCellReuseIdentifier:[JVIFeedTableViewCell cellIdentifier]];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlTriggered:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    
    [self.tableView setContentOffset:CGPointMake(0, - self.refreshControl.height) animated:NO];

    [self loadFirstPage];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JVITweet *tweet = self.items[indexPath.row];
    return [JVIFeedTableViewCell heightForWidth:self.view.width Text:tweet.text];
}


- (void)refreshControlTriggered:(id)sender {
    [self loadFirstPage];
}

- (void)loadFirstPage {
    [self.refreshControl beginRefreshing];
    
    [[JVITwitterService sharedService] getHomeTimelineWithSuccess:^(NSArray<JVITweet *> *list) {
        [self.refreshControl endRefreshing];
        self.items = list;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        [self.refreshControl endRefreshing];
        NSLog(@"Failed getting feed. %@", error);
    }];
}


@end

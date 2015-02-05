//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIFeedViewController.h"
#import "UIView+JVIView.h"
#import "JVIFeedTableViewCell.h"
#import "JVITwitterService.h"
#import "JVITweet.h"

@interface JVIFeedViewController () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation JVIFeedViewController {
    UITableView *_tableView;
    UIRefreshControl *_refreshControl;
    NSArray *_items;
}

- (void)loadView {
    [super loadView];

    self.title = NSLocalizedString(@"interview.title", @"iOS Interview");

    _items = [[NSMutableArray alloc] init];

    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init]; // This removes the ugly lines when there is no content.
    [self.view addSubview:_tableView];

    _refreshControl = [[UIRefreshControl alloc] init];
    [_tableView addSubview:_refreshControl];
    [_refreshControl addTarget:self action:@selector(refreshControlTriggered:) forControlEvents:UIControlEventValueChanged];

    [_refreshControl beginRefreshing];
    [_tableView setContentOffset:CGPointMake(0, -_refreshControl.frame.size.height) animated:NO];

    [self loadFirstPage];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    _tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static const NSString *CellIdentifier = @"Cell";

    JVITweet *tweet = _items[indexPath.row];
    JVIFeedTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[JVIFeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.separatorInset = UIEdgeInsetsZero;
        [cell setPreservesSuperviewLayoutMargins:NO];
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    [cell updateData:tweet];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JVITweet *tweet = _items[indexPath.row];
    return [JVIFeedTableViewCell heightForWidth:self.view.width Text:tweet.text];
}


- (void)refreshControlTriggered:(id)sender {
    [self loadFirstPage];
}

- (void)loadFirstPage {
    [[JVITwitterService sharedService] getHomeTimelineWithSuccess:^(NSArray *list) {
        [_refreshControl endRefreshing];
        _items = list;
        [_tableView reloadData];
    }                                                      failed:^(NSError *error) {
        [_refreshControl endRefreshing];
        NSLog(@"Failed getting feed. %@", error);
    }];
}


@end
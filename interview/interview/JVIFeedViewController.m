//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIFeedViewController.h"
#import "UIView+JVDView.h"
#import "JVIInstagramService.h"
#import "JVIPaginatedList.h"


@implementation JVIFeedViewController {
    UITableView *_tableView;
    UIRefreshControl *_refreshControl;
    NSArray *_items;
}

- (void)loadView {
    [super loadView];

    self.title = NSLocalizedString(@"interview.title", @"iOS Interview");

    _items = [[NSMutableArray alloc] init];

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // This removes the ugly lines when there is no content.
    [self.view addSubview:_tableView];

    _refreshControl = [[UIRefreshControl alloc] init];
    [_tableView addSubview:_refreshControl];
    [_refreshControl addTarget:self action:@selector(refreshControlTriggered:) forControlEvents:UIControlEventValueChanged];

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
    return nil;
}

- (void)refreshControlTriggered:(id)sender {
    [self loadFirstPage];
}

- (void)loadFirstPage {
    [[JVIInstagramService sharedService] getFeedWithSuccess:^(JVIPaginatedList *list) {
        [_refreshControl endRefreshing];
        _items = list.entities;
    } failed:^(NSError *error) {
        [_refreshControl endRefreshing];
        NSLog(@"Failed getting feed. %@", error);
    }];
}


@end
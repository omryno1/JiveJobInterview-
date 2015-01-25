//
// Created by Offir Talmor on 1/25/15.
// Copyright (c) 2015 Jive Software. All rights reserved.
//

#import "JVIFeedViewController.h"
#import "UIView+JVIView.h"
#import "JVIInstagramService.h"
#import "JVIPaginatedList.h"
#import "JVIImage.h"
#import "JVIFeedTableViewCell.h"

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

    JVIImage *image = _items[indexPath.row];
    JVIFeedTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[JVIFeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.separatorInset = UIEdgeInsetsZero;
        [cell setPreservesSuperviewLayoutMargins:NO];
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    [cell updateData:image];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [JVIFeedTableViewCell heightForWidth:self.view.width];
}


- (void)refreshControlTriggered:(id)sender {
    [self loadFirstPage];
}

- (void)loadFirstPage {
    [[JVIInstagramService sharedService] getFeedWithSuccess:^(JVIPaginatedList *list) {
        [_refreshControl endRefreshing];
        _items = list.entities;
        [_tableView reloadData];
    }                                                failed:^(NSError *error) {
        [_refreshControl endRefreshing];
        NSLog(@"Failed getting feed. %@", error);
    }];
}


@end
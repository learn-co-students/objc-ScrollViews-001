//
//  ViewController.m
//  ScrollViewAutoLayout
//
//  Created by Daniel Barabander on 4/15/15.
//  Copyright (c) 2015 Flatiron. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"CustomTableViewCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CustomTableViewCell" forIndexPath:indexPath];
    return cell;
}

@end

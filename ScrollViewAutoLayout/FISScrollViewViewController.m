//
//  FISScrollViewViewController.m
//  ScrollViewAutoLayout
//
//  Created by Tom OMalley on 8/31/15.
//  Copyright (c) 2015 Flatiron. All rights reserved.
//

#import "FISScrollViewViewController.h"

@interface FISScrollViewViewController ()
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@end

@implementation FISScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.scrollView setAccessibilityLabel:@"scrollView"];
    [self.scrollView setAccessibilityIdentifier:@"scrollView"];
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

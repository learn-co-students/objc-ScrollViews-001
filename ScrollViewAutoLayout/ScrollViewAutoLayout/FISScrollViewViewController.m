//
//  FISScrollViewViewController.m
//  ScrollViewAutoLayout
//
//  Created by Tom OMalley on 8/31/15.
//  Copyright (c) 2015 Flatiron. All rights reserved.
//

#import "FISScrollViewViewController.h"

@interface FISScrollViewViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourthImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthImageView;

@end

@implementation FISScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.scrollView setAccessibilityLabel: @"scrollView"];
    [self.scrollView setAccessibilityIdentifier:@"scrollView"];
    
    
    /* uncomment this, scroll and see the logs
     to learn more about frame/bounds in scrollviews */
//    self.scrollView.delegate = self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"-----------------------------");
    NSLog(@"SV Frame: %@", NSStringFromCGRect(scrollView.frame));
    NSLog(@"SV Bounds: %@", NSStringFromCGRect(scrollView.bounds));
    NSLog(@"\n");
    NSLog(@"CV Frame: %@", NSStringFromCGRect(self.contentView.frame));
    NSLog(@"CV Bounds: %@", NSStringFromCGRect(self.contentView.bounds));
    NSLog(@"\n");
    NSLog(@"I1 Frame: %@", NSStringFromCGRect(self.firstImageView.frame));
    NSLog(@"I2 Frame: %@", NSStringFromCGRect(self.secondImageView.frame));
    NSLog(@"I3 Frame: %@", NSStringFromCGRect(self.thirdImageView.frame));
    NSLog(@"I4 Frame: %@", NSStringFromCGRect(self.fourthImageView.frame));
    NSLog(@"I5 Frame: %@", NSStringFromCGRect(self.fifthImageView.frame));
    NSLog(@"-----------------------------");
}

@end

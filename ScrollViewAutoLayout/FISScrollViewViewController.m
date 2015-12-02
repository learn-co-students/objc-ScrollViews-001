//
//  FISScrollViewViewController.m
//  ScrollViewAutoLayout
//
//  Created by Tom OMalley on 8/31/15.
//  Copyright (c) 2015 Flatiron. All rights reserved.
//

#import "FISScrollViewViewController.h"

@interface FISScrollViewViewController ()

@end

@implementation FISScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    CGRect rect = [[UIScreen mainScreen]bounds];
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:rect];
    scrollV.pagingEnabled = YES;
    CGRect bigRect = rect;
    bigRect.size.width *=5;
    
    scrollV.contentSize = bigRect.size;
    
    [self.view addSubview:scrollV];
    
    
    
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = [UIColor redColor];
    [scrollV addSubview:view];

    scrollV.accessibilityLabel = @"scrollView";
    scrollV.accessibilityIdentifier = @"scrollView";

    
    for (int i =0; i<4; i++) {
        rect.origin.x += rect.size.width;
        UIView *view = [[UIView alloc] initWithFrame:rect];
        view.backgroundColor = [self randomColor];
        [scrollV addSubview:view];
        
    }
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

-(UIColor *)randomColor{
    float randomRed = arc4random() % 255;
    float randomGreen = arc4random() % 255;
    float randomBlue = arc4random() % 255;
    
    return [UIColor colorWithRed:randomRed/255 green:randomGreen/255 blue:randomBlue/255 alpha:1];
}

@end

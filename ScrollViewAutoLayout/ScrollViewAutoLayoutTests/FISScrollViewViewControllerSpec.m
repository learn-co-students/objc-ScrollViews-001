//
//  FISScrollViewViewControllerSpec.m
//  ScrollViewAutoLayout
//
//  Created by Tom OMalley on 8/31/15.
//  Copyright 2015 Flatiron. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "AppDelegate.h"
#import "FISScrollViewViewController.h"


SpecBegin(FISScrollViewViewController)

describe(@"FISScrollViewViewController", ^{
    
    __block FISScrollViewViewController *scrollViewVC;
    __block UIScrollView *scrollView;
    
    beforeAll(^{
        UIWindow *mainWindow = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
        scrollViewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
        [mainWindow setRootViewController: scrollViewVC];
        [mainWindow makeKeyAndVisible];
        
        scrollView = scrollViewVC.scrollView;
    });
    
    describe(@"scrollView", ^{
        
        it(@"exists", ^{
            expect(scrollView).notTo.beNil;
        });
        
        it(@"has one contentView", ^{
            expect(scrollView.subviews.count).to.equal(1);
            expect(scrollView.subviews[0]).to.beKindOf([UIView class]);
        });
    });

    describe(@"contentView", ^{
        
        __block UIView *contentView;
        
        beforeAll(^{
            contentView = scrollView.subviews[0];
        });
        
        //TODO: make lab explicitly ask for 5 imageViews
        it(@"has 5 subviews", ^{
            expect(contentView.subviews.count).to.equal(5);
        });
        
        it(@"subviews are all imageViews", ^{
            for(UIView *subview in contentView.subviews)
            {
                expect(subview).to.beKindOf([UIImageView class]);
            }
        });
    });
});

SpecEnd

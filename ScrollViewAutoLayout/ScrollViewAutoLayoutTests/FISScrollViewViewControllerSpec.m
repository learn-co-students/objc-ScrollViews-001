//
//  FISScrollViewViewControllerSpec.m
//  ScrollViewAutoLayout
//
//  Created by Tom OMalley on 8/31/15.
//  Copyright 2015 Flatiron. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <KIF/KIF.h>

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
        
        it(@"has subviews", ^{
            expect(scrollView.subviews.count).to.beGreaterThan(0);
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
        
        it(@"has imageViews with images set", ^{
            for(UIImageView *subview in contentView.subviews)
            {
                expect(subview.image).toNot.beNil;
            }
        });
    });    
});

SpecEnd

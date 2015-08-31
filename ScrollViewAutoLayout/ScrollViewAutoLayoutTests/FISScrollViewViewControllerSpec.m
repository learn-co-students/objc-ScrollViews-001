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
    __block NSString *scrollViewAccessLabel;
    __block UIView *contentView;

    
    beforeAll(^{
        UIWindow *mainWindow = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
        scrollViewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
        [mainWindow setRootViewController: scrollViewVC];
        [mainWindow makeKeyAndVisible];
        
        scrollViewAccessLabel = @"scrollView";
        scrollView = (UIScrollView*)[tester waitForViewWithAccessibilityLabel:scrollViewAccessLabel];
        contentView = scrollView.subviews[0];
    });
    
    describe(@"basic setup", ^{
        
        describe(@"scrollView", ^{
            it(@"exists", ^{
                expect(scrollView).notTo.beNil;
            });
            
            it(@"has subviews", ^{
                expect(scrollView.subviews.count).to.beGreaterThan(0);
            });
            
            it(@"paging enabled", ^{
                expect(scrollView.pagingEnabled).to.beTruthy;
            });
        });

        describe(@"contentView", ^{
            
            //TODO: make lab explicitly ask for 5 imageViews
            it(@"has 5 subviews", ^{
                expect(contentView.subviews.count).to.equal(5);
            });
            
            it(@"all subviews are imageViews", ^{
                for(UIView *subview in contentView.subviews)
                {
                    expect(subview).to.beKindOf([UIImageView class]);
                }
            });
            
            it(@"all imageViews have images set", ^{
                for(UIImageView *subview in contentView.subviews)
                {
                    expect(subview.image).toNot.beNil;
                }
            });
        });
    });
    
    
    //TODO: make lab include instructions for accessibilityLabels
    describe(@"scrollView", ^{
        
        beforeEach(^{
            // resets the scrollView to original position
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:1.0 vertical:0];
        });
        
        it(@"shows first image pre-scrolling", ^{
            UIImageView *firstImageView = contentView.subviews[0];
            CGRect scrollViewBounds = scrollView.bounds;
            CGRect firstImageViewFrame = firstImageView.frame;
            
            BOOL firstIVframeIntersectsSVBounds = CGRectIntersectsRect(scrollViewBounds, firstImageViewFrame);
            expect(firstIVframeIntersectsSVBounds).to.beTruthy();
            ;
        });
        
        it(@"does not show second image pre-scrolling", ^{
            UIImageView *secondImageView = contentView.subviews[1];
            CGRect scrollViewBounds = scrollView.bounds;
            CGRect secondImageViewFrame = secondImageView.frame;
           
            BOOL secondIVframeIntersectsSVBounds = CGRectIntersectsRect(scrollViewBounds, secondImageViewFrame);
            expect(secondIVframeIntersectsSVBounds).to.beFalsy();
        });
        
        it(@"shows second image when scrolled -0.2", ^{
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:(-0.2) vertical:0];
            UIImageView *secondImageView = contentView.subviews[1];
            CGRect scrollViewBounds = scrollView.bounds;
            CGRect secondImageViewFrame = secondImageView.frame;
            BOOL secondIVframeIntersectsSVBounds = CGRectIntersectsRect(scrollViewBounds, secondImageViewFrame);
            expect(secondIVframeIntersectsSVBounds).to.beTruthy();
        });
        
        it(@"shows third image when scrolled -0.4", ^{
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:(-0.2) vertical:0];
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:(-0.2) vertical:0];
            
            UIImageView *thirdImageView = contentView.subviews[2];
            CGRect scrollViewBounds = scrollView.bounds;
            CGRect thirdImageViewFrame = thirdImageView.frame;
            
            BOOL thirdIVframeIntersectsSVBounds = CGRectIntersectsRect(scrollViewBounds, thirdImageViewFrame);
            expect(thirdIVframeIntersectsSVBounds).to.beTruthy();
        });

        it(@"shows fourth image when scrolled -0.6", ^{
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:(-0.2) vertical:0];
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:(-0.2) vertical:0];
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:(-0.2) vertical:0];
            
            UIImageView *fourthImageView = contentView.subviews[3];
            CGRect scrollViewBounds = scrollView.bounds;
            CGRect fourthImageViewFrame = fourthImageView.frame;
            
            BOOL fourthIVframeIntersectsSVBounds = CGRectIntersectsRect(scrollViewBounds, fourthImageViewFrame);
            expect(fourthIVframeIntersectsSVBounds).to.beTruthy();
        });

        it(@"shows last image when scrolled -0.8", ^{
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:(-0.2) vertical:0];
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:(-0.2) vertical:0];
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:(-0.2) vertical:0];
            [tester scrollViewWithAccessibilityIdentifier:scrollViewAccessLabel byFractionOfSizeHorizontal:(-0.2) vertical:0];

            UIImageView *fifthImageView = contentView.subviews[4];
            CGRect scrollViewBounds = scrollView.bounds;
            CGRect fifthImageViewFrame = fifthImageView.frame;
            
            BOOL fifthIVframeIntersectsSVBounds = CGRectIntersectsRect(scrollViewBounds, fifthImageViewFrame);
            expect(fifthIVframeIntersectsSVBounds).to.beTruthy();
        });
    });
});

SpecEnd

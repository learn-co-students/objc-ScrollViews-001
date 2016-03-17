objc-ScrollViews
===============

## Goals 
  
  - Learn about scrollviews
  - Use scrollviews with Autolayout 
  - Incorporate scrollviews into UITableViewCells 

##UIScrollView

UIScrollViews are key components of many different UIKit classes. They are the unsung heroes of UITableView, UIPageView, UITextView, UICollectionView, and many, many more. Today, my friends, we liberate the scrollview from the shackles of servitude, and pay homage to the thankless job of scrolling.   

###Autolayout and ScrollViews

Quite frankly, autolayout wreaks havoc on scrollviews. So much so that if you have autolayout enabled, and you add a scrollview to your project, it's very likely that nothing will happen.  No scrolling, no paging, nada.  

But all is not lost! Apple has a **[somewhat useful little article](https://developer.apple.com/library/ios/technotes/tn2154/_index.html)** about working with scrollviews in autolayout-enabled projects. I highly recommend at least scanning this doc before starting this lab. We'll be using the "Pure Auto Layout", which requires a specific (and slightly odd) constraint setup.

###Pure Autolayout Approach 

Apple offers this little snippet 


> To use the pure autolayout approach do the following (emphasis added):

> - Set `translatesAutoresizingMaskIntoConstraints` to `NO` on all views involved.
> - Position and size your scroll view with constraints **external to the scroll view**.
> - Use constraints to lay out the subviews within the scroll view, being sure that **the constraints tie to all four edges of the scroll view** and **do not rely on the ScrollView to get their size**.

Getting scrollview autolayout to work in a storyboard is the darkest form of magic. But fear not; we can use the guidelines that Apple has provided to build an autolayout enabled scrollview without a single line of code. Follow this formula and your content will be scrolling in no time. Perhaps we can even make sense of what's happening when we're done.  

###Paging 
We're all familiar with paging in scroll views. Paging "snaps" the content of your scrollview  when scrolling. For example, a group of 4 pictures can be laid out horizontally such that there are 4 different pages, with each page enclosing an image. Instead of fluid scrolling, your view will snap to the next image after you've scrolled a certain distance. For the sake of brevity, you should lean on [the documentation](https://developer.apple.com/library/ios/documentation/windowsviews/conceptual/UIScrollView_pg/ScrollViewPagingMode/ScrollViewPagingMode.html) for configuring your pages. But the two key properties you're concerned with in regards to paging are the scrollview's `contentSize` and `pagingMode`.

##Tutorial

###Configuring the views on the Storyboard 

Don't worry about constraints yet; we'll do those in the next phase.

- Drag a scrollview onto the view controller and make it exactly fill the view (full screen).
- Drop a plain UIView into the scrollview, and make it fill the entire scrollview. This will be our content view. 
- Expand the content view on the Y axis to make it taller than the scrollview.  This is most easily executed from the size inspector by simply increasing the height of the view to something like 600.
- Add a few buttons to the content view, one at the top, one in the middle and one at the bottom (you may have to do some awkward maneuvering of the content view to pull this off, just make sure you move it back to its origin of (0, 0) when you're done).

###Laying out the views
- Select the scrollview from the document outline and select the 'pin' icon to add new constraints. (It looks kind of like this `|-|-|`  ) 
- Select each of the orange 'pin' icons around the bounding box (spacing to nearest neighbor) and ensure all of the spacing values are set to 0.  This operation should add 4 constraints, as shown at the bottom of the window.  
- Select 'add 4 constraints'. 
- Next, select the content view and add 0 pt spacing around each of its edges (i.e., pin all four edges of the content view to the edges of the scroll view). Also select the height constraint. The height value should be greater than the height of the iPhone screen. (Yes, it seems like this height constraint conflicts with the "0 on all sides" constraints. Bear with me.)
- This time, select both the content view and the scrollview, and add new constraints for equal widths.

###What did we just do? 

OK, let's think about this.  There are a few things that have to go just right to allow the ScrollView to determine its scrollable content size.

- **The scrollview** - The scrollview must have a concrete layout. That is, it must know how to derive its width, height, and x/y position.  We did this by constraining the scrollview to its superview's (the default view) leading, trailing, top and bottom edges.  
- **The content view** - The content view must have bounds that expand beyond that of the scrollview (in our case, we made the content expand down in the y axis, but we could have just as easily extended on the x axis) and have constraints to the scrollview on all 4 edges.  

This all may still not make an incredible amount of sense, but if you can reproduce this template, you now have a very powerful, flexible layout.  At this point, you can embed whatever UI elements you'd like into that content view and have a fully autolayout compatible scrollview. You can even make an outlet from the content view to your view controller and do all of your layout and/or subview creation in code.   

##Cast of Characters 

There are a few properties on scrollview that you'll need to be familiar with in order to use them effectively.  

- **`@property (nonatomic) CGSize contentSize`** - The size of the content view.
- **`@property (nonatomic) CGPoint contentOffset`** -  The point at which the origin of the content view is offset from the origin of the scrollview. The default value is `CGPointZero`.
- **`@property (nonatomic, getter=isPagingEnabled) BOOL pagingEnabled`** - A Boolean value that determines whether paging is enabled for the scrollview. If the value of this property is YES, the scrollview stops on multiples of the scrollview's bounds when the user scrolls. The default value is NO.

###Lab 

## Instructions 

  - Create a scrollview that has 5 pictures on it. The user should be able to scroll horizontally through the pictures and be presented one picture per *page*.  Do this with a scrollview **not** a UIPageViewController.
     - If you need a couple images to get you started click [here](http://imgur.com/a/G1CIG).
  - The `FISScrollViewViewController` class has already been made for you; use it.
    - In `viewDidLoad`, set your scrollview's `accessibilityLabel` and `accessibilityIdentifier` both to `@"scrollView"` so you can run the tests when you're done. 

## Extra Credit

- Create a custom UITableViewCell. Embed your paging ScrollView from part 1 into that cell. You should make it so that you can add load images into your custom cell via the tableview data source.  

- In a separate view controller, create a simple form (a few textfields and maybe a button or two) in scrollview. Make the scrollview intercept the system notifications for the keyboard being presented or dismissed, and scroll the form out of the way of the keyboard when when the keyboard appears, and back down when it is dismissed.  

Here is how you find out if the keyboard will appear or disappear:

```objc
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


- (void)keyBoardWillShow:(NSNotification *)notification
{
    // grab some values from the notification
    NSTimeInterval keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger keyboardAnimationCurve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateKeyframesWithDuration:keyboardAnimationDuration delay:0.0 options:keyboardAnimationCurve animations:^{
        
        // Here is where you change something to make it animate!
        
    } completion:nil];
}
```

## Links

- [Auto Layout with scrollviews](https://developer.apple.com/library/ios/technotes/tn2154/_index.html)
- [Demo of Laying out scrollviews in Storyboard](https://www.youtube.com/watch?v=4oCWxHLBQ-A)
- [Scrolling Using Paging Mode](https://developer.apple.com/library/ios/documentation/windowsviews/conceptual/UIScrollView_pg/ScrollViewPagingMode/ScrollViewPagingMode.html)


## Tip of the day 

- Create a new view controller, select it, show the Attributes Inspector (the badge thingy?), and select "Freeform" under "Simulated Metrics". This allows you to resize your view controller to sizes larger than any particular phone, which is great for laying out scrollable content.
- You could also select your view controller's default view, open the size inspector (the ruler) and set the height to something larger than the point size of a real iPhone screen, say 700.  

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/objc-ScrollViews' title='objc-ScrollViews'>objc-ScrollViews</a> on Learn.co and start learning to code for free.</p>

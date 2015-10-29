
objc-ScrollViews
===============

## Goals 
  
  - Learn about ScrollViews
  - Use ScrollViews with Autolayout 
  - Incorporate ScrollViews into UITableViewCells 

##UIScrollView

UIScrollViews are key components of many different UIKit Classes.  They are the unsung heroes of UITableView, UIPageView, UITextView, UICollectionView, and many, many more.  Today, my friends, we liberate the ScrollView from the shackles of servitude, and pay homage to the thankless job of scrolling.   

###Autolayout and ScrollViews

Quite frankly, Autolayout wreaks havoc on ScrollViews.  So much so, that if you have Autolayout enabled, and you add a ScrollView to your project, it's very likely that nothing will happen.  No scrolling, no paging, nada.  

But all is not lost! Apple has a **[somewhat useful little article](https://developer.apple.com/library/ios/technotes/tn2154/_index.html)** about working with ScrollViews in Autolayout-enabled projects.  I highly recommend at least scanning this doc before starting this lab.  We'll be using the "Mixed Approach", which basically uses Autolayout to position the ScrollView itself and the internal devices of the ScrollView to layout its content.    

###Pure Autolayout Approach 

Apple offers this little snippet 


> To use the pure autolayout approach do the following:

> - Set translatesAutoresizingMaskIntoConstraints to NO on all views involved.
> - Position and size your ScrollView with constraints external to the ScrollView.
> - Use constraints to lay out the subviews within the ScrollView, being sure that the constraints tie to all four edges of the ScrollView and do not rely on the ScrollView to get their size.

Getting autolayout to work in the storyboard is the darkest form of magic.  But fear not, we can use the guidelines that Apple has provided to build an Auto-Layout enabled ScrollView without a single line of code.  Follow this formula and your content will be scrolling in no time. Perhaps we can even make sense of what's happening when we're done.  

###Paging 
We're all familiar with paging in scroll views.  Paging allows you to autoscroll your view with a certain offset when the user pans in a given direction.  For example, a group of 4 pictures can be laid out horizontally such that there are 4 different pages, with each page enclosing an image.  Instead of fluid scrolling, your view will snap to the next image after you've scrolled a certain distance.  For the sake of brevity, you should lean on [the documentation](https://developer.apple.com/library/ios/documentation/windowsviews/conceptual/UIScrollView_pg/ScrollViewPagingMode/ScrollViewPagingMode.html) for configuring your pages.  But the two key properties you're concerned with in regards to paging are the ScrollView's contentSize and pagingMode.  

##Tutorial

###Configuring the views on the StoryBoard 

- Drag a ScrollView onto the view controller and make it exactly fill the bounds rect of the view (full screen).
- Drag a view and drop it over top of the ScrollView making sure it is both the same dimensions and in the same position as the ScrollView.  This will be our content view. 
- Expand the content view on the Y axis to make it taller than the ScrollView.  This is most easily executed from the size inspector by simply increasing the height of the view to 600. 
- Add a few buttons, one at the top, one in the middle and one at the bottom of the view (you may have to do some awkward maneuvering of the content view to pull this off, just make sure you move it back to it's origin of 0,0 when you're done)

###Laying out the views
- Select the ScrollView from the document outline and select the 'pin' icon to add new constraints. (It looks kind of like this |-|-|  ) 
- Select each of the orange 'pin' icons around the bounding box (spacing to nearest neighbor) and ensure all of the spacing values are set to 0.  This operation should add 4 constraints, as shown at the bottom of the window.  
- Select 'add 4 constraints'. 
- Next, select the content view and add 0 pt spacing around each edge of its bounds rect.  Also select the height constraint.  The height value should be greater than the height of the iPhone screen. 
- This time, select both the content view and the ScrollView -> add new constraints and select equal widths.  

###What did we just do? 

OK, let's think about this.  There are a few things that have to go just right to allow the ScrollView to determine its scrollable content size.

- **The ScrollView** - The ScrollView must have a concrete layout.  ie. It must know how to derive its width, height, and x/y position.  We did this by constraining the ScrollView to it's superview's (the default view) leading, trailing, top and bottom edges.  
- **The content view** - 
The content view must have bounds that expand beyond that of the ScrollView (in our case we made the content expand down in the y axis, but we could have just as easily extended on the x axis) and have constraints to the ScrollView on all 4 edges.  

This all may still not make an incredible amount of sense, but if you can reproduce this template, you now have a very powerful, flexible layout.  At this point, you can embed whatever UI elements you'd like into that content view and have a fully Auto-Layout compatible ScrollView.  You can even make an outlet from the content view to your ViewController Subclass code and do all of your layout and/or subview creation in code.   

##Cast of Characters 

There are a few properties on ScrollViews that you'll need to be familiar with in order to use them effectively.  

- **`@property(nonatomic) CGSize contentSize`** - The size of the content view.
- **`@property(nonatomic) CGPoint contentOffset`** -  The point at which the origin of the content view is offset from the origin of the ScrollView. The default value is `CGPointZero`.
- **`@property(nonatomic, getter=isPagingEnabled) BOOL pagingEnabled`** - A Boolean value that determines whether paging is enabled for the ScrollView. If the value of this property is YES, the ScrollView stops on multiples of the ScrollViews' bounds when the user scrolls. The default value is NO.

###Lab 

## Instructions 

  - Create a ScrollView that has 5 pictures on it. The user should be able to scroll horizontally through the pictures and be presented one picture per *page*.  Do this with a ScrollView **not** a UIPageViewController.
     - If you need a couple to get you started click [here](http://imgur.com/a/G1CIG).
  - The `FISScrollViewViewController` class has already been made for you, use it.
    - In `viewDidLoad`, set your scrollview's `accessibilityLabel` and `accessibilityIdentifier` both to `@"scrollView"` so you can run the tests when you're done. 
    - also make sure you `pod install` ! (for tests) 

## Extra Credit

- Create a custom UITableViewCell.  Embed your paging ScrollView from part 1 into that tableViewCell.  You should make it such that you can add load images into your custom cell via the TableView DataSource.  

- In a separate View Controller, create a ScrollView that intercepts the action of the keyboard being presented or dismissed, and scrolls some form UI from the center of the screen to the top of the screen when present and back to the middle when dismissed.  

Here is how you find out if the keyboard has appeared or disappeared 

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
    double keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger keyboardAnimationCurve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateKeyframesWithDuration: keyboardAnimationDuration delay:0.0 options:keyboardAnimationCurve animations:^{
        
        // Here is where you change something to make it animate!
        
    } completion:nil];
}
```
## Links

- **Auto-Layout with ScrollViews** - https://developer.apple.com/library/ios/technotes/tn2154/_index.html
- **Demo of Laying out ScrollView in Storyboard** - https://www.youtube.com/watch?v=4oCWxHLBQ-A
- **Scrolling Using Paging Mode** - https://developer.apple.com/library/ios/documentation/windowsviews/conceptual/UIScrollView_pg/ScrollViewPagingMode/ScrollViewPagingMode.html

## Tip of the day 

- Create a new ViewController, select it, show the 'Attributes Inspector'(the badge thingy?), and select freeform.  (This allows your ViewController to morph to sizes larger than the screen, which is great for laying out Scrollable content)
- Select your view controller's default view, open the size inspector (the ruler) and set the height to something larger than the point size of a real iPhone screen, say 700.  

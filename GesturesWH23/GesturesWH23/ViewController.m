//
//  ViewController.m
//  GesturesWH23
//
//  Created by Nikolay Berlioz on 12.11.15.
//  Copyright © 2015 Nikolay Berlioz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIImageView *animationView;
@property (weak, nonatomic) UIImageView *animationInvertView;
@property (weak, nonatomic) UIImageView *mainImage;
@property (assign, nonatomic) CGFloat viewScale;
@property (assign, nonatomic) CGFloat viewRotation;
@property (weak, nonatomic) NSArray *arrayImages;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor cyanColor];
    
    //-------------------------   Animation image   -----------------------------
    
    //-------------------------   First animation   -----------------------------
    UIImageView *stepManView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 100,
                                                                         CGRectGetMidY(self.view.bounds) - 100,
                                                                         200, 200)];
    stepManView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                   UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    stepManView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:stepManView];
    
    UIImage *step1 = [UIImage imageNamed:@"1.png"];
    UIImage *step2 = [UIImage imageNamed:@"2.png"];
    UIImage *step3 = [UIImage imageNamed:@"3.png"];
    UIImage *step4 = [UIImage imageNamed:@"4.png"];
    UIImage *step5 = [UIImage imageNamed:@"5.png"];
    UIImage *step6 = [UIImage imageNamed:@"6.png"];
    UIImage *step7 = [UIImage imageNamed:@"7.png"];
    UIImage *step8 = [UIImage imageNamed:@"8.png"];
    
    NSArray *animationArray = [[NSArray alloc] initWithObjects:step1, step2, step3, step4, step5, step6, step7, step8, nil];
    self.arrayImages = animationArray;
    
    stepManView.animationImages = animationArray;
    stepManView.animationDuration = 0.8f;
    [stepManView startAnimating];
    
    self.animationView = stepManView;
    self.mainImage = self.animationView;
    
    //-------------------------   Second animation   -----------------------------
    
    UIImageView *stepManInvertView = [[UIImageView alloc] initWithFrame: CGRectMake(-200, -200, 200, 200)];
 
    stepManInvertView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:stepManInvertView];
    
    UIImage *stepIn1 = [UIImage imageNamed:@"1invert.png"];
    UIImage *stepIn2 = [UIImage imageNamed:@"2invert.png"];
    UIImage *stepIn3 = [UIImage imageNamed:@"3invert.png"];
    UIImage *stepIn4 = [UIImage imageNamed:@"4invert.png"];
    UIImage *stepIn5 = [UIImage imageNamed:@"5invert.png"];
    UIImage *stepIn6 = [UIImage imageNamed:@"6invert.png"];
    UIImage *stepIn7 = [UIImage imageNamed:@"7invert.png"];
    UIImage *stepIn8 = [UIImage imageNamed:@"8invert.png"];
    
    NSArray *animationInvertArray = [[NSArray alloc] initWithObjects:stepIn1, stepIn2, stepIn3, stepIn4, stepIn5, stepIn6, stepIn7, stepIn8, nil];
    
    stepManInvertView.animationImages = animationInvertArray;
    stepManInvertView.animationDuration = 0.8f;
    [stepManInvertView startAnimating];
    
    self.animationInvertView = stepManInvertView;

    //-------------------------   Tap Gesture   -------------------------------------

    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    //-------------------------   Right Swipe Gesture   -----------------------------
    
    UISwipeGestureRecognizer *rightSwipeGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleRightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    
    //-------------------------   Left Swipe Gesture   -----------------------------

    UISwipeGestureRecognizer *leftSwipeGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleLeftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];

    //-------------------------    Double Tap Double Touch Gesture   ---------------
    
    UITapGestureRecognizer *doubleTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];
    
    //-------------------------    Pinch Gesture   ---------------------------------

    UIPinchGestureRecognizer *pinchGesture =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
    
    
    //-------------------------    Rotation Gesture   ---------------------------------
    
    UIRotationGestureRecognizer *rotationGesture =
    [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
    
    
}

//***************************   Gestures  ******************************************

#pragma mark - Gestures

- (void) handleRotation: (UIRotationGestureRecognizer*) rotationGesture
{
    NSLog(@"Rotation");
    
    CGFloat newRotation = rotationGesture.rotation - self.viewRotation;
    
    CGAffineTransform currentTransform = self.mainImage.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    self.mainImage.transform = newTransform;
    self.viewRotation = rotationGesture.rotation;

}

- (void) handlePinch:(UIPinchGestureRecognizer*) pinchGesture
{
     NSLog(@"Pinch");
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan)
    {
        self.viewScale = 1.f;
    }
    
    CGFloat newScale = 1.f + pinchGesture.scale - self.viewScale;
    
    CGAffineTransform currentTransform = self.mainImage.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    self.mainImage.transform = newTransform;
    
    self.viewScale = pinchGesture.scale;
    
}

- (void) handleDoubleTap:(UITapGestureRecognizer*) doubleTapGesture
{
    NSLog(@"DoubleTap DoubleTouch - stop animation!");
    [self.mainImage stopAnimating];
    self.mainImage.image = [self.arrayImages objectAtIndex:0];
}

- (void) handleLeftSwipe:(UISwipeGestureRecognizer*) leftSwipeGesture
{
    NSLog(@"Left Swipe");
    
    CGAffineTransform currentTransform = self.mainImage.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, 3.14);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.mainImage.transform = newTransform;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void) handleRightSwipe:(UISwipeGestureRecognizer*) rightSwipeGesture
{
    NSLog(@"Right Swipe");
    
    CGAffineTransform currentTransform = self.mainImage.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, -3.14);
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.mainImage.transform = newTransform;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void) handleTap:(UITapGestureRecognizer*) tapGesture
{
    NSLog(@"Tap");

    
    CGPoint pointToMainView = [tapGesture locationInView:self.view];//point of tap
    CGPoint saveLocation = self.mainImage.center;
    CGAffineTransform currentTransform = self.mainImage.transform;
    
    void (^animationBlock)(void) = ^(void) //block with animation
    {
        self.mainImage.alpha = 1;
        self.mainImage.transform = currentTransform;
        [UIView animateWithDuration:2
                              delay:0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.mainImage.center = pointToMainView;
                         } completion:^(BOOL finished) {
                             
                         }];
    };
    
    if (CGPointEqualToPoint(CGPointMake(-100, -100), self.animationInvertView.center))
    {
        if (saveLocation.x < pointToMainView.x)
        {
            animationBlock();
        }
        else if (saveLocation.x > pointToMainView.x)
        {
            self.animationView.center = CGPointMake(-100, -100);
            self.animationView.alpha = 0;
            self.mainImage = self.animationInvertView;
            self.mainImage.center = saveLocation;
            animationBlock();
        }
    }
    else if (CGPointEqualToPoint(CGPointMake(-100, -100), self.animationView.center))
    {
        if (saveLocation.x < pointToMainView.x)
        {
            self.animationInvertView.center = CGPointMake(-100, -100);
            self.animationInvertView.alpha = 0;
            self.mainImage = self.animationView;
            self.mainImage.center = saveLocation;
            animationBlock();
        }
        else if (saveLocation.x > pointToMainView.x)
        {
            animationBlock();
        }
    }
    
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
        shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}




@end

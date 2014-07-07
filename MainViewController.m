//
//  MainViewController.m
//  Week3Project
//
//  Created by Andrew Janich on 7/1/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "MainViewController.h"


//color hex import
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *menu;
@property (weak, nonatomic) IBOutlet UIView *headlines;
@property (weak, nonatomic) IBOutlet UIScrollView *news;

//- (void)onPanGlobal:(UIPanGestureRecognizer *)panGestureRecognizer;

- (IBAction)onHeadlinePan:(UIPanGestureRecognizer *)sender;

@end

@implementation MainViewController

CGPoint touchBeginPoint;
CGPoint initialPoint;
CGPoint viewBeginPoint;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.news.contentSize = CGSizeMake(1484, 253);
    initialPoint = self.headlines.center;
    UIPanGestureRecognizer *globalGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onHeadlinePan:)];
    
    [self.view addGestureRecognizer:(UIGestureRecognizer *)globalGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGPoint)newYvalue:(CGPoint)location
{
    
    return location;
}


//- (void)onPanGlobal:(UIPanGestureRecognizer *)panGestureRecognizer {


- (IBAction)onHeadlinePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    
    CGPoint touchCurrentPoint = [panGestureRecognizer locationInView:self.view];
    CGPoint moveToPoint = initialPoint;
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        touchBeginPoint = [panGestureRecognizer locationInView:self.view];
        viewBeginPoint  = self.headlines.center;
        
        NSLog(@"Gesture began at: %@", NSStringFromCGPoint(initialPoint));
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat newY = viewBeginPoint.y + (touchCurrentPoint.y - touchBeginPoint.y);
        moveToPoint = CGPointMake(initialPoint.x, newY);
        self.headlines.center = moveToPoint;
        
        NSLog(@"Gesture changed: %@", NSStringFromCGPoint(initialPoint));
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat delta = touchCurrentPoint.y - touchBeginPoint.y;
        
        if (delta<0){
            moveToPoint = initialPoint;
        }
        
        else {
            moveToPoint = CGPointMake(initialPoint.x, 800);
        }
        
        [UIView
         animateWithDuration:.6
         delay:0
         usingSpringWithDamping:.8
         initialSpringVelocity:1
         options:0
         animations:^{
             self.headlines.center = moveToPoint;
         }
         completion:nil
         
         ];
        
        NSLog(@"Gesture ended: %@", NSStringFromCGPoint(initialPoint));
    }
}

@end

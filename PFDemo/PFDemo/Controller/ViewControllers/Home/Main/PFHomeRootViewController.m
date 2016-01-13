//
//  PFHomeRootViewController.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/13/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFHomeRootViewController.h"
#import "SlideNavigationController.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "PFHomeSettingsViewController.h"
#import "PFHomeUsersViewController.h"

@interface PFHomeRootViewController () <SlideNavigationControllerDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) PFHomeSettingsViewController *homeSettingsVC;
@property (nonatomic, strong) PFHomeUsersViewController *homeUsersVC;

@end

@implementation PFHomeRootViewController

+(NSString *)className{
    return @"PFHomeRootViewController";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    PFBaseViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = @[initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    [self setAnimatorSlide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"");
}

-(void) setAnimatorSlide
{
    id <SlideNavigationContorllerAnimator> revealAnimator;
    revealAnimator = [[SlideNavigationContorllerAnimatorSlide alloc] init];
    [SlideNavigationController sharedInstance].menuRevealAnimator = revealAnimator;
    [[SlideNavigationController sharedInstance] setEnableSwipeGesture:YES];
    
}

#pragma mark - UIPageViewController
- (PFBaseViewController *)viewControllerAtIndex:(NSUInteger)index {
    PFBaseViewController *vc = nil;
    if (index == 0) {
        if (!_homeUsersVC) {
            _homeUsersVC = [[PFHomeUsersViewController alloc]init];
        }
        vc = _homeUsersVC;
    }
    else if (index == 1) {
        if (!_homeSettingsVC) {
            _homeSettingsVC = [[PFHomeSettingsViewController alloc]init];
        }
        vc = _homeSettingsVC;
    }
    vc.index = index;
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PFBaseViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PFBaseViewController *)viewController index];
    
    
    index++;
    
    if (index == 5) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
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

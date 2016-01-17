//
//  PFHomeRootViewController.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/13/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFHomeRootViewController.h"
#import "SlideNavigationController.h"
#import "PFSlideViews.h"
#import "SlideNavigationContorllerAnimatorSlide.h"

@interface PFHomeRootViewController () <SlideNavigationControllerDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) PFSlideViews *slideViews;

@end

@implementation PFHomeRootViewController

+(NSString *)className{
    return @"PFHomeRootViewController";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _slideViews = [[PFSlideViews alloc]init];
    [self.view addSubview:_slideViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_slideViews setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_slideViews loadItemViews];
    
//    [_AppSlideViewController setEnableSwipeGesture:YES forVC:self];
}

-(void)loginCompleted{
    [_slideViews loginCompleted];
}

//-(void)handleGesture{
//    NSLog(@"pan");
//}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

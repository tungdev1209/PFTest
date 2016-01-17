//
//  PFCoreViewController.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/12/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFCoreViewController.h"
#import "PFLoginViewController.h"

#import "PFHomeRootViewController.h"
#import "PFMenuViewController.h"

#define MainStoryboardName @"Main"

@interface PFCoreViewController () <PFDataHandlerDelegate>

@property (nonatomic, strong) UIStoryboard *mainStoryBoard;
@property (nonatomic, strong) PFMenuViewController *menuViewController;
@property (nonatomic, strong) PFHomeRootViewController *homeRootViewController;

@end

@implementation PFCoreViewController

+(instancetype)shareCore{
    static PFCoreViewController *core = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        core = [[PFCoreViewController alloc]init];
    });
    return core;
}

-(UIViewController*)loadMainNavigator{
    _menuViewController = (PFMenuViewController*)[_AppCoreViewController loadViewControllerWithName:[PFMenuViewController className]];
    _homeRootViewController = (PFHomeRootViewController*)[_AppCoreViewController loadViewControllerWithName:[PFHomeRootViewController className]];
    
    _slideMenu = [[SlideNavigationController alloc]initWithRootViewController:_homeRootViewController];
    
    _slideMenu.menuRevealAnimationDuration = .18;
    _slideMenu.leftMenu = _menuViewController;
    _slideMenu.navigationBar.tintColor = [UIColor whiteColor];
    
    [_slideMenu setEnableSwipeGesture:NO];
    
    return _slideMenu;
}

-(PFBaseViewController*)loadViewControllerWithName:(NSString*)className{
    if (!_mainStoryBoard) {
        _mainStoryBoard = [UIStoryboard storyboardWithName:MainStoryboardName bundle:nil];
    }
    return (PFBaseViewController*)[_mainStoryBoard instantiateViewControllerWithIdentifier:className];
}

-(void)pushToSlideViews{
    _slideMenu.enableSwipeGesture = YES;
    [_homeRootViewController loginCompleted];
}

-(void)pushLoginView{
    UINavigationController *loginNavigator = [[UINavigationController alloc]initWithRootViewController:[self loadViewControllerWithName:[PFLoginViewController className]]];
    [loginNavigator setNavigationBarHidden:YES];
    [_AppCoreViewController presentViewController:loginNavigator completion:nil];
}

-(void)presentViewController:(id)viewController completion:(void(^)())completion{
    [self ensureBlockExecuteOnMainThread:^{
        [_slideMenu presentViewController:[self checkTypeOfVC:viewController] animated:YES completion:completion];
    }];
}

-(void)pushViewController:(id)viewController{
    [self ensureBlockExecuteOnMainThread:^{
        [_slideMenu pushViewController:[self checkTypeOfVC:viewController] animated:YES];
    }];
}

-(void)switchToViewController:(id)viewController{
    [self ensureBlockExecuteOnMainThread:^{
        [_slideMenu popToRootAndSwitchToViewController:[self checkTypeOfVC:viewController] withCompletion:nil];
    }];
    
}

-(UIViewController*)checkTypeOfVC:(id)sender{
    UIViewController *vc;
    if ([sender isKindOfClass:[UIViewController class]]) {
        vc = sender;
    }
    else if ([vc isKindOfClass:[NSString class]]) {
        vc = [self loadViewControllerWithName:sender];
    }
    return vc;
}

-(void)ensureBlockExecuteOnMainThread:(void(^)())block{
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
        return;
    }
    block();
}

@end

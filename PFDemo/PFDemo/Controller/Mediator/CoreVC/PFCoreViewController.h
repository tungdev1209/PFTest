//
//  PFCoreViewController.h
//  PFDemo
//
//  Created by Tung Nguyen on 1/12/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFDataHandler.h"
#import "PFSettings.h"
#import "PFBaseViewController.h"
//#import "PFStartupViewController.h"

#import "SlideNavigationController.h"

@interface PFCoreViewController : NSObject

//@property (nonatomic, strong, readonly) PFStartupViewController *startupVC;

@property (nonatomic, strong) SlideNavigationController *slideMenu;

+(instancetype)shareCore;

-(UIViewController*)loadMainNavigator;

-(PFBaseViewController*)loadViewControllerWithName:(NSString*)className;

-(void)pushToSlideViews;
-(void)pushLoginView;

-(void)presentViewController:(id)viewController completion:(void(^)())completion;
-(void)pushViewController:(id)viewController;
-(void)switchToViewController:(id)viewController;

@end

//
//  PFLoginViewController.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/12/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFLoginViewController.h"
#import "PFSignUpViewController.h"

@interface PFLoginViewController ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *constraintTopViewBG;
@property (nonatomic, weak) IBOutlet UITextField *tfEmail;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation PFLoginViewController

+(NSString *)className{
    return @"PFLoginViewController";
}

-(IBAction)btnLoginPressed:(id)sender{
    PFUser *user = [[PFUser alloc]init];
    user.email = _tfEmail.text;
    user.password = _tfPassword.text;
    [_AppDataHandler login:user completion:^(PFUser *currentUser) {
        if (currentUser) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    [_AppManager loginCompleted];
                }];
            });
        }
    }];
}

-(IBAction)btnSignUpPressed:(id)sender{
    [self.navigationController pushViewController:[_AppCoreViewController loadViewControllerWithName:[PFSignUpViewController className]] animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_tfEmail resignFirstResponder];
    [_tfPassword resignFirstResponder];
}

@end

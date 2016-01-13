//
//  PFSignUpViewController.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/12/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFSignUpViewController.h"

@interface PFSignUpViewController ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *constraintTopViewBG;
@property (nonatomic, weak) IBOutlet UITextField *tfEmail;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) IBOutlet UITextField *tfUserName;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation PFSignUpViewController

+(NSString *)className{
    return @"PFSignUpViewController";
}

-(IBAction)btnSignUpPressed:(id)sender{
    PFUser *newUser = [[PFUser alloc]init];
    newUser.username = _tfUserName.text;
    newUser.email = _tfEmail.text;
    newUser.password = _tfPassword.text;
    [_AppDataHandler signupUser:newUser completion:^(BOOL success) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_tfEmail resignFirstResponder];
    [_tfPassword resignFirstResponder];
    [_tfUserName resignFirstResponder];
}

@end

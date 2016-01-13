//
//  PFApplicationManager.h
//  PFDemo
//
//  Created by Tung Nguyen on 1/13/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFSettings.h"
#import "PFDataHandler.h"

typedef enum : NSUInteger {
    ApplicationEventStartupLoad,
    ApplicationEventLoadConfig,
    ApplicationEventLoginComplete,
    ApplicationEventLogout,
} ApplicationEvent;

@interface PFApplicationManager : NSObject

@property (nonatomic, strong) PFSettings *appSettings;
@property (nonatomic, strong) PFDataHandler *appDataHandler;
@property (nonatomic, assign) ApplicationEvent lastAppEvent;

+(instancetype)shareManager;

-(void)startup;
-(void)appConfigLoaded;
-(void)loginCompleted;
-(void)logout;

@end

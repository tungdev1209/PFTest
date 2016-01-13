//
//  PFApplicationManager.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/13/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFApplicationManager.h"

@implementation PFApplicationManager

+(instancetype)shareManager{
    static PFApplicationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PFApplicationManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        _appSettings = [[PFSettings alloc]init];
        _appDataHandler = [[PFDataHandler alloc]initWithDelegate:self];
    }
    return self;
}

#pragma mark - Application States
-(void)startup{
    [self processApplicationStateWithLastEvent:ApplicationEventStartupLoad];
}

-(void)appConfigLoaded{
    [self processApplicationStateWithLastEvent:ApplicationEventLoadConfig];
}

-(void)loginCompleted{
    [self processApplicationStateWithLastEvent:ApplicationEventLoginComplete];
}

-(void)logout{
    [self processApplicationStateWithLastEvent:ApplicationEventLogout];
}

-(void)processApplicationStateWithLastEvent:(ApplicationEvent)event{
    switch (event) {
        case ApplicationEventStartupLoad:{
//            [_AppCoreViewController startupLoad];
            break;
        }
            
        case ApplicationEventLoadConfig:{
            [_AppCoreViewController pushLoginView];
            break;
        }
            
        case ApplicationEventLoginComplete:{
            [_AppCoreViewController pushToSlideViews];
            break;
        }
            
        case ApplicationEventLogout:{
            [_AppCoreViewController pushLoginView];
            break;
        }
            
        default:
            break;
    }
    _lastAppEvent = event;
}

#pragma mark - PFDataRequestComplete
-(void)PFDataRequestComplete:(id)results{
    if (![results boolValue]) {
        [self processApplicationStateWithLastEvent:ApplicationEventLoadConfig];
    }
}

@end

//
//  PFMacros.h
//  PFDemo
//
//  Created by Tung Nguyen on 1/12/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#ifndef PFMacros_h
#define PFMacros_h

#define _AppDelegate [AppDelegate sharedDelegate]
#define _AppCoreViewController [PFCoreViewController shareCore]
#define _AppManager [PFApplicationManager shareManager]
#define _AppSlideViewController [SlideNavigationController sharedInstance]

#define _AppDataHandler [_AppManager appDataHandler]
#define _AppSettings [_AppManager appSettings]
#define _AppMainView [_AppCoreViewController startupVC]

#endif /* PFMacros_h */

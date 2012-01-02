//
//  SPAppDelegate.h
//  SidePanel
//
//  Created by Jerish Brown on 12/11/11.
//  Copyright (c) 2011 i3Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPViewController;

@interface SPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SPViewController *viewController;

@end

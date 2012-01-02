//
//  SPViewController.h
//  SidePanel
//
//  Created by Jerish Brown on 12/11/11.
//  Copyright (c) 2011 i3Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPWindow.h"
#import "SPPanel.h"

@interface SPViewController : UIViewController<SPPanelContentHandler> {
    SPWindow *Window;
}

@property (strong, nonatomic) SPWindow *Window;

@end

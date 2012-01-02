//
//  SPWindow.h
//  SidePanel
//
//  Created by Jerish Brown on 12/11/11.
//  Copyright (c) 2011 i3Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPDragger;
@class SPPanel;

@protocol SPPanelStyleHandler;
@protocol SPPanelBackgroundContentHandler;
@protocol SPPanelContentHandler;
typedef enum {
    SPWindow_Closed,
    SPWindow_Open
} SPWindow_State;

@interface SPWindow : UIView {
    SPDragger *Dragger;
    SPPanel *Panel;
    UIView __weak *SuperView;
    SPWindow_State State;
}

@property (nonatomic, strong) SPDragger *Dragger;
@property (nonatomic, strong) SPPanel *Panel;
@property (nonatomic, weak) UIView *SuperView;
@property (nonatomic) SPWindow_State State;

// Big default initilizer... Sorry that it's so messy. If you can think of a better way to do this, tell me about it!
- (id)initWithSuperView:(UIView *)sv andPanelWidth:(NSInteger)panelWidth withStyleHandler:(id<SPPanelStyleHandler>)styleHanler backgroundContentHandler:(id<SPPanelBackgroundContentHandler>)backgroundContentHandler andContentHandler:(id<SPPanelContentHandler>)contentHandler;

- (id)initWithSuperView:(UIView *)sv andPanelWidth:(NSInteger)panelWidth;

@end

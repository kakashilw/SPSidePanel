//
//  SPPanel.h
//  SidePanel
//
//  Created by Jerish Brown on 12/12/11.
//  Copyright (c) 2011 i3Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPWindow;

@protocol SPPanelStyleHandler;
@protocol SPPanelBackgroundContentHandler;
@protocol SPPanelContentHandler;
@interface SPPanel : UIView {
    UIScrollView *ContentView;
    UIView *BackgroundView;
    SPWindow __weak *ParentWindow;
    id<SPPanelStyleHandler> __unsafe_unretained StyleHandler;
    id<SPPanelBackgroundContentHandler> __unsafe_unretained BackgroundContentHandler;
    id<SPPanelContentHandler> __unsafe_unretained ContentHandler;
}

@property (nonatomic, strong) UIScrollView *ContentView;
@property (nonatomic, strong) UIView *BackgroundView;
@property (nonatomic, weak) __weak SPWindow *ParentWindow;
@property (nonatomic, unsafe_unretained) id<SPPanelStyleHandler> StyleHandler;
@property (nonatomic, unsafe_unretained) id<SPPanelBackgroundContentHandler> BackgroundContentHandler;
@property (nonatomic, unsafe_unretained) id<SPPanelContentHandler> ContentHandler;

// Big default initilizer... Sorry that it's so messy. If you can think of a better way to do this, tell me about it!
- (id)initWithFrame:(CGRect)frame withStyleHandler:(id<SPPanelStyleHandler>)styleHanler backgroundContentHandler:(id<SPPanelBackgroundContentHandler>)backgroundContentHandler andContentHandler:(id<SPPanelContentHandler>)contentHandler;

- (void)addControl:(UIControl*)control styled:(BOOL)styled;
- (void)addView:(UIView*)view;

@end

@protocol SPPanelStyleHandler

// styleControl:control
// Style the control passed into the method appropriately.
- (void)styleControl:(UIControl*)control;

@end

@protocol SPPanelBackgroundContentHandler

// shouldDrawDefaultBackgroundImage
// Return YES to draw  the default background image
// Return NO to not draw the image.
- (BOOL)shouldDrawDefaultBackgroundImage;

// setupBackgroundView:view fromSender:sender
// Add any images, effects, or content to the background view.
- (void)setupBackgroundView:(UIView*)view fromSender:(id)sender;

@end

@protocol SPPanelContentHandler

// setupContentView:view fromSender:sender
// Add any images, buttons, sliders, or content to the content view.
// To add a UIControl or UIView to the content view, you should call
// [sender addControl:control styled:BOOL]; or
// [sender addView:view styled:BOOL];
// These methods will add the view or contol to the bottom of the panel, spaced appropriately.
// Therefore, the X and Y values in the frame of the control or view do not matter, as they are set in the addControl: or addView: methods.
// You could write your own method to handle drawing to the panel.
- (void)setupContentView:(UIView*)view fromSender:(id)sender;

@end
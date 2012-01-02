//
//  SPDragger.h
//  SidePanel
//
//  Created by Jerish Brown on 12/11/11.
//  Copyright (c) 2011 i3Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPWindow;

@interface SPDragger : UIView {
    UIImageView *DraggerImageView;
    SPWindow __weak *ParentWindow;
    BOOL currentTouchIsTap;
    
    UIImage *draggerImage;
    UIImage *selectedImage;
}

@property (nonatomic, strong) UIImageView *DraggerImageView;
@property (nonatomic, weak) SPWindow *ParentWindow;
@property (nonatomic) BOOL currentTouchIsTap;

@property (nonatomic, strong) UIImage *draggerImage;
@property (nonatomic, strong) UIImage *selectedImage;

- (id)initWithImage:(UIImage*)_draggerImage selectedImage:(UIImage *)_selectedImage andParentWindow:(SPWindow*)pw;

- (void)toggleDraggerState:(BOOL)animated;

@end

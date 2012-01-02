//
//  SPDragger.m
//  SidePanel
//
//  Created by Jerish Brown on 12/11/11.
//  Copyright (c) 2011 i3Software. All rights reserved.
//

#import "SPDragger.h"
#import "SPWindow.h"

@interface SPDragger (PrivateMethods)

// May be needed in future

@end

@implementation SPDragger
@synthesize DraggerImageView, ParentWindow, currentTouchIsTap, draggerImage, selectedImage;

- (id)initWithImage:(UIImage*)_draggerImage selectedImage:(UIImage *)_selectedImage andParentWindow:(SPWindow*)pw {
    self = [super init];
    if (self) {
        self.ParentWindow = pw;
        self.ParentWindow.State = SPWindow_Closed;
        
        if (_draggerImage.size.width != _selectedImage.size.width ||
            _draggerImage.size.height != _selectedImage.size.height) {
            [NSException raise:@"Dragger image and selected image must have the same width and height." format:nil];
        }
        
        self.draggerImage = _draggerImage;
        self.selectedImage = _selectedImage;
        
        self.DraggerImageView = [[UIImageView alloc] init];
        self.DraggerImageView.image = self.draggerImage;
        self.DraggerImageView.frame = CGRectMake(0, 0, self.draggerImage.size.width, self.draggerImage.size.height);
        [self addSubview:self.DraggerImageView];
        
        NSInteger viewWidth = self.ParentWindow.SuperView.frame.size.width;
        NSInteger viewHeight = self.ParentWindow.SuperView.frame.size.height;
        if ((viewHeight < self.draggerImage.size.height) || (viewWidth < self.draggerImage.size.width)) {
            [NSException raise:@"The view you are trying to place SPDragger in is too small. The Window must be equal to or bigger the dragger in height and width." format:nil];
        }
        
        NSInteger yValue = viewHeight / 2 - self.draggerImage.size.height / 2;
        self.frame = CGRectMake(0, yValue, self.draggerImage.size.width, self.draggerImage.size.height);
    }
    return self;
}

- (void)toggleDraggerState:(BOOL)animated {
    SPWindow *p_Window = self.ParentWindow;
    CGRect SuperViewFrame = self.ParentWindow.SuperView.frame;
    NSInteger windowWidth = p_Window.frame.size.width;
    NSInteger windowMaxX = SuperViewFrame.size.width - windowWidth;
    NSInteger windowMinX = SuperViewFrame.size.width - self.frame.size.width;
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            if (p_Window.State == SPWindow_Open) {
                p_Window.frame =
                    CGRectMake(windowMinX, p_Window.frame.origin.y, p_Window.frame.size.width, p_Window.frame.size.height);
            } else {
                p_Window.frame =
                    CGRectMake(windowMaxX, p_Window.frame.origin.y, p_Window.frame.size.width, p_Window.frame.size.height);
            }
        }];
    } else {
        if (p_Window.State == SPWindow_Open) {
            p_Window.frame =
                CGRectMake(windowMinX, p_Window.frame.origin.y, p_Window.frame.size.width, p_Window.frame.size.height);
        } else {
            p_Window.frame =
                CGRectMake(windowMaxX, p_Window.frame.origin.y, p_Window.frame.size.width, p_Window.frame.size.height);
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.currentTouchIsTap = YES;
    self.DraggerImageView.image = self.selectedImage;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (currentTouchIsTap) {
        [self toggleDraggerState:YES];
    }
    self.DraggerImageView.image = self.draggerImage;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.DraggerImageView.image = self.draggerImage;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.currentTouchIsTap = NO;
    SPWindow *p_Window = self.ParentWindow;
    
    UITouch *touch = [touches anyObject];
    CGPoint cLocation = [touch locationInView:self];
    
    if (cLocation.x > 0) {
        CGPoint pLocation = [touch previousLocationInView:self];
        NSInteger newX = p_Window.frame.origin.x + (cLocation.x - pLocation.x);

        CGRect SuperViewFrame = p_Window.SuperView.frame;
        NSInteger windowWidth = p_Window.frame.size.width;
        NSInteger windowMinX = SuperViewFrame.size.width - windowWidth;
        NSInteger windowMaxX = SuperViewFrame.size.width - self.frame.size.width;
        
        if (newX >= windowMinX && newX <= windowMaxX) {
            p_Window.frame =
                CGRectMake(newX, p_Window.frame.origin.y, p_Window.frame.size.width, p_Window.frame.size.height);
        }
    }
}

@end

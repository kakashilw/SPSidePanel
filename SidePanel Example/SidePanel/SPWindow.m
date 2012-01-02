//
//  SPWindow.m
//  SidePanel
//
//  Created by Jerish Brown on 12/11/11.
//  Copyright (c) 2011 i3Software. All rights reserved.
//

#import "SPWindow.h"
#import "SPDragger.h"
#import "SPPanel.h"

@implementation SPWindow
@synthesize Dragger, Panel, SuperView, State;

- (id)initWithSuperView:(UIView *)sv andPanelWidth:(NSInteger)panelWidth withStyleHandler:(id<SPPanelStyleHandler>)styleHanler backgroundContentHandler:(id<SPPanelBackgroundContentHandler>)backgroundContentHandler andContentHandler:(id<SPPanelContentHandler>)contentHandler
{
    self = [super init];
    if (self) {
        self.SuperView = sv;
        self.State = SPWindow_Closed;
        
        UIImage *draggerImage = [UIImage imageNamed:@"Dragger"];
        UIImage *selectedImage = [UIImage imageNamed:@"DraggerSelected"];
        
        
        NSInteger Width = panelWidth + draggerImage.size.width;
        NSInteger draggerWidth = draggerImage.size.width;
        
        NSInteger viewWidth = self.SuperView.frame.size.width;
        NSInteger viewHeight = self.SuperView.frame.size.height;
        if ((viewHeight < 64) || (viewWidth < Width)) {
            [NSException raise:@"The view you are trying to place SPWindow in is too small. The Window must be equal to or bigger the window in height and width." format:nil];
        }
        
        self.frame = CGRectMake(self.SuperView.frame.size.width - draggerWidth, 0, Width, self.SuperView.frame.size.height);
        self.Dragger = [[SPDragger alloc] initWithImage:draggerImage selectedImage:selectedImage andParentWindow:self];
        [self addSubview:self.Dragger];
        
        self.Panel = [[SPPanel alloc] initWithFrame:CGRectMake(draggerWidth, self.frame.origin.y, panelWidth, self.frame.size.height) withStyleHandler:styleHanler backgroundContentHandler:backgroundContentHandler andContentHandler:contentHandler];
        [self addSubview:self.Panel];
    }
    return self;
}

- (id)initWithSuperView:(UIView *)sv andPanelWidth:(NSInteger)panelWidth {
    self = [super init];
    if (self) {
        self.SuperView = sv;
        self.State = SPWindow_Closed;
        
        UIImage *draggerImage = [UIImage imageNamed:@"Dragger"];
        UIImage *selectedImage = [UIImage imageNamed:@"DraggerSelected"];
        
        
        NSInteger Width = panelWidth + draggerImage.size.width;
        NSInteger draggerWidth = draggerImage.size.width;
        
        NSInteger viewWidth = self.SuperView.frame.size.width;
        NSInteger viewHeight = self.SuperView.frame.size.height;
        if ((viewHeight < 64) || (viewWidth < Width)) {
            [NSException raise:@"The view you are trying to place SPWindow in is too small. The Window must be equal to or bigger the window in height and width." format:nil];
        }
        
        self.frame = CGRectMake(self.SuperView.frame.size.width - draggerWidth, 0, Width, self.SuperView.frame.size.height);
        self.Dragger = [[SPDragger alloc] initWithImage:draggerImage selectedImage:selectedImage andParentWindow:self];
        [self addSubview:self.Dragger];
        
        self.Panel = [[SPPanel alloc] initWithFrame:CGRectMake(draggerWidth, self.frame.origin.y, panelWidth, self.frame.size.height)];
        [self addSubview:self.Panel];
    }
    return self;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    NSInteger windowMinX = self.SuperView.frame.size.width - self.frame.size.width;
    NSInteger windowMaxX = self.SuperView.frame.size.width - self.Dragger.frame.size.width;
    
    if (self.frame.origin.x == windowMinX) {
        self.State = SPWindow_Open;
    } else if (self.frame.origin.x <= windowMaxX) {
        self.State = SPWindow_Closed;
    }
}

@end

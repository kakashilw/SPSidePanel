//
//  SPPanel.m
//  SidePanel
//
//  Created by Jerish Brown on 12/12/11.
//  Copyright (c) 2011 i3Software. All rights reserved.
//

#import "SPPanel.h"
#import "SPWindow.h"

@interface SPPanel (PrivateMethods)

- (void)setupContentView;
- (void)setupBackgroundView;

@end

@implementation SPPanel
@synthesize ContentView, BackgroundView, ParentWindow, StyleHandler, BackgroundContentHandler, ContentHandler;

- (id)initWithFrame:(CGRect)frame withStyleHandler:(id<SPPanelStyleHandler>)styleHanler backgroundContentHandler:(id<SPPanelBackgroundContentHandler>)backgroundContentHandler andContentHandler:(id<SPPanelContentHandler>)contentHandler
{
    self = [super initWithFrame:frame];
    if (self) {
        self.StyleHandler = styleHanler;
        self.BackgroundContentHandler = backgroundContentHandler;
        self.ContentHandler = contentHandler;
        
        [self setupBackgroundView];
        [self setupContentView];
        
        [self addSubview:self.BackgroundView];
        [self addSubview:self.ContentView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBackgroundView];
        [self setupContentView];
        
        [self addSubview:self.BackgroundView];
        [self addSubview:self.ContentView];
    }
    return self;
}

- (void)setupContentView {
    CGRect CVFrame = CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.height - 4);
    self.ContentView = [[UIScrollView alloc] initWithFrame:CVFrame];
    self.ContentView.scrollEnabled = YES;
    self.ContentView.alwaysBounceVertical = YES;
    self.ContentView.contentSize = CGSizeMake(CVFrame.size.width, 8);
    if (self.ContentHandler != nil) {
        [self.ContentHandler setupContentView:self.ContentView fromSender:self];
    }
}

- (void)setupBackgroundView {
    CGRect BGFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.BackgroundView = [[UIView alloc] initWithFrame:BGFrame];
    UIImage *BackgroundImage = [[UIImage imageNamed:@"Window"] stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    UIImageView *BackgroundImageView = [[UIImageView alloc] initWithImage:BackgroundImage];
    BackgroundImageView.frame = BGFrame;
    if (self.BackgroundContentHandler != nil) {
        if ([self.BackgroundContentHandler shouldDrawDefaultBackgroundImage]) {
            [self.BackgroundView addSubview:BackgroundImageView];
        }
        [self.BackgroundContentHandler setupBackgroundView:self.BackgroundView fromSender:self];
    } else {
        [self.BackgroundView addSubview:BackgroundImageView];
    }
}

- (void)addControl:(UIControl*)control styled:(BOOL)styled {
    CGSize cSize = self.ContentView.contentSize;
    CGRect newFrame = CGRectMake(8, cSize.height, cSize.width - 16, control.frame.size.height);
    
    if (styled) {
        if (self.StyleHandler == nil) {
            Class cClass = [control class];
            if (cClass == [UIButton class]) {
                UIButton *button = (UIButton*)control;
                UIImage *bgImage = [[UIImage imageNamed:@"Button"] stretchableImageWithLeftCapWidth:2 topCapHeight:11];
                UIImage *bgImageHighlighted =
                    [[UIImage imageNamed:@"ButtonHighlighted"] stretchableImageWithLeftCapWidth:2 topCapHeight:11];
                [button setBackgroundImage:bgImage forState:UIControlStateNormal];
                [button setBackgroundImage:bgImageHighlighted forState:UIControlStateHighlighted];
                [button setBackgroundImage:bgImageHighlighted forState:UIControlStateSelected];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.backgroundColor = [UIColor clearColor];
            } else if (cClass == [UISlider class]) {
                UISlider *slider = (UISlider*)control;
                UIImage *SliderMinimum = [[UIImage imageNamed:@"SliderMinimumBar"] stretchableImageWithLeftCapWidth:4 topCapHeight:1];
                UIImage *SliderMaximum = [[UIImage imageNamed:@"SliderMaximumBar"] stretchableImageWithLeftCapWidth:4 topCapHeight:1];
                UIImage *thumb = [UIImage imageNamed:@"Thumb"];
                [slider setMinimumTrackImage:SliderMinimum forState:UIControlStateNormal];
                [slider setMaximumTrackImage:SliderMaximum forState:UIControlStateNormal];
                [slider setThumbImage:thumb forState:UIControlStateNormal];
                slider.backgroundColor = [UIColor clearColor];
            } else {
                NSLog(@"WARNING: No style is availible for the UIControl");
            }
        } else {
            [self.StyleHandler styleControl:control];
        }
    }
    
    control.frame = newFrame;
    self.ContentView.contentSize = CGSizeMake(cSize.width, cSize.height + control.frame.size.height + 8);
    
    [self.ContentView addSubview:control];
}

- (void)addView:(UIView*)view {
    CGSize cSize = self.ContentView.contentSize;
    CGRect newFrame = CGRectMake(8, cSize.height, cSize.width - 16, view.frame.size.height);
    view.frame = newFrame;
    view.backgroundColor = [UIColor clearColor];
    self.ContentView.contentSize = CGSizeMake(cSize.width, cSize.height + view.frame.size.height + 8);
    [self.ContentView addSubview:view];
}

@end

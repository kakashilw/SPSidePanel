//
//  SPViewController.m
//  SidePanel
//
//  Created by Jerish Brown on 12/11/11.
//  Copyright (c) 2011 i3Software. All rights reserved.
//

#import "SPViewController.h"

@implementation SPViewController
@synthesize Window;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	self.Window = [[SPWindow alloc] initWithSuperView:v andPanelWidth:160 withStyleHandler:nil backgroundContentHandler:nil andContentHandler:self];
    [v addSubview:Window];
    [self.view addSubview:v];
}

- (void)setupContentView:(UIView*)view fromSender:(id)sender {
    SPPanel *Panel = (SPPanel*)sender;
    
    UILabel *Label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 32)];
    Label1.text = @"Buttons";
    [Panel addView:Label1];

    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake(0, 0, 0, 32);
    [Button setTitle:@"Hello, World" forState:UIControlStateNormal];
    [Panel addControl:Button styled:YES];
    
    UIButton *Button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    Button2.frame = CGRectMake(0, 0, 0, 32);
    [Button2 setTitle:@"I am a Button!" forState:UIControlStateNormal];
    [Panel addControl:Button2 styled:YES];
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(0, 0, 0, 32);
    [b setTitle:@"Hello, World" forState:UIControlStateNormal];
    [Panel addControl:b styled:YES];
    
    UILabel *Label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 32)];
    Label2.text = @"Sliders";
    [Panel addView:Label2];
    
    UISlider *Slider1 = [[UISlider alloc] init];
    [Slider1 setMinimumValue:0];
    [Slider1 setMaximumValue:1];
    [Slider1 setValue:0.25];
    [Panel addControl:Slider1 styled:YES];
    
    UISlider *Sldier2 = [[UISlider alloc] init];
    [Sldier2 setMinimumValue:0];
    [Sldier2 setMaximumValue:1];
    [Sldier2 setValue:0.5];
    [Panel addControl:Sldier2 styled:YES];
    
    UISlider *Sldier3 = [[UISlider alloc] init];
    [Sldier3 setMinimumValue:0];
    [Sldier3 setMaximumValue:1];
    [Sldier3 setValue:0.75];
    [Panel addControl:Sldier3 styled:YES];
    
    UILabel *Label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 32)];
    Label3.text = @"SPSidePanel";
    [Panel addView:Label3];
    
    UILabel *Label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 32)];
    Label4.text = @"From i3Software";
    [Panel addView:Label4];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

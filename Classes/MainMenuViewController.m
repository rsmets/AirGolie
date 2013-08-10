//
//  MainMenuViewController.m
//  AirGoalie
//
//  Created by BCT Department on 6/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"

@implementation MainMenuViewController

- (IBAction)continueGame{
	[self presentModalViewController:gravityTutViewController animated:YES];
}	

- (IBAction)newGame{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];	
	[prefs setInteger:0 forKey:@"highScore"];
	[prefs synchronize];
	NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];	
	[prefs2 setInteger:0 forKey:@"highScore2"];
	[prefs2 synchronize];
	[self presentModalViewController:gravityTutViewController animated:YES];
    [self presentViewController:gravityTutViewController animated:YES completion:nil];
}

- (IBAction)settings{
    [self presentViewController:settingsViewController animated:YES completion:nil];
}

- (IBAction)networking{
    [self presentViewController:networkingViewController animated:YES completion:nil];
}

- (IBAction)info{
	[self presentModalViewController:infoViewController animated:YES];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end

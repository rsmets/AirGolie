//
//  MainView.m
//  AirGoalie
//
//  Created by BCT Department on 5/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (IBAction)goToMainView{
	[self presentModalViewController:gravityTutViewController animated:YES];
}

- (IBAction)resetScore{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];	
	[prefs setInteger:0 forKey:@"highScore"];
	[prefs synchronize];
}
@end
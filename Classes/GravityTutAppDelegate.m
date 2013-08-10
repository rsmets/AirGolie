//
//  GravityTutAppDelegate.m
//  GravityTut
//
//  Created by BCT Department on 5/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "GravityTutAppDelegate.h"
#import "MainMenuViewController.h"

@implementation GravityTutAppDelegate

@synthesize window;
@synthesize mainMenuViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:mainMenuViewController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc {
    [mainMenuViewController release];
    [window release];
    [super dealloc];
}


@end

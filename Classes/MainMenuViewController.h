//
//  MainMenuViewController.h
//  AirGoalie
//
//  Created by BCT Department on 6/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GravityTutViewController.h"
#import "SettingsViewController.h"
#import "NetworkingViewController.h"
#import "InfoViewController.h"


@interface MainMenuViewController : UIViewController {
	IBOutlet GravityTutViewController *gravityTutViewController;
	IBOutlet SettingsViewController *settingsViewController;
	IBOutlet NetworkingViewController *networkingViewController;
	IBOutlet InfoViewController *infoViewController;
}

- (IBAction)continueGame;
- (IBAction)newGame;
- (IBAction)settings;
- (IBAction)networking;
- (IBAction)info;

@end

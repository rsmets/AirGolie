//
//  SettingsViewController.h
//  AirGoalie
//
//  Created by BCT Department on 6/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface SettingsViewController : UIViewController {
	IBOutlet UISlider * goalieSlider;
	//Settings * settings;
}

- (IBAction)backToMenu;
@property (nonatomic, retain) UISlider *goalieSlider;
- (int)goalieSense;

@end

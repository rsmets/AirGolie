//
//  Settings.m
//  AirGoalie
//
//  Created by BCT Department on 6/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"


@implementation Settings
@synthesize gSense;

-(int)getGSense{
	SettingsViewController * shit = [SettingsViewController alloc];
	gSense = [shit goalieSense];
}

/*
-(void)init{
	SettingsViewController * shit = [SettingsViewController alloc];
	gSense = [shit goalieSense];

}
 */

@end

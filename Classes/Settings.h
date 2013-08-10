//
//  Settings.h
//  AirGoalie
//
//  Created by BCT Department on 6/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsViewController.h"

@interface Settings : NSObject {
	CGFloat gSense;

}

@property CGFloat gSense;

-(int)getGSense;
//-(void)init;

@end

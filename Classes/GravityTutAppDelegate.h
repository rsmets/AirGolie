//
//  GravityTutAppDelegate.h
//  GravityTut
//
//  Created by BCT Department on 5/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainMenuViewController;

@interface GravityTutAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	MainMenuViewController *mainMenuViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainMenuViewController *mainMenuViewController;

@end


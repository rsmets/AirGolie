//
//  MainView.h
//  AirGoalie
//
//  Created by BCT Department on 5/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GravityTutViewController.h"

@interface MainView : UIViewController {
	IBOutlet GravityTutViewController *gravityTutViewController;
}

- (IBAction)goToMainView;
- (IBAction)resetScore;
@end

//
//  MainViewController.h
//  GravityTut
//
//  Created by Mary Moore on 5/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GravityTutViewController.h"

@interface MainViewController : UIViewController {
	IBOutlet GravityTutViewController *gravityTutViewController;
}

- (IBAction)goToMainView;
- (IBAction)resetScore;
@end

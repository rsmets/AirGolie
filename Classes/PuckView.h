//
//  PuckView.h
//  GravityTut
//
//  Created by BCT Department on 5/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Puck.h"
#import "Paddle.h"
#import "Goalie.h"


@interface PuckView : UIView {
	Puck *puck;
	Paddle *paddle;
	Paddle *paddle2;
	Goalie *goalie;
	Goalie *goalie2;
}

-(void)refresh:(Puck *) aPuck;
-(void)refresh2:(Paddle *) aPaddle;
-(void)refresh3:(Goalie *) aGoalie;
-(void)refresh4:(Goalie *) aGoalie;
-(void)refresh5:(Paddle *) aPaddle;

@end

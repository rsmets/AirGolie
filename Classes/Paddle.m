//
//  Paddle.m
//  GravityTut
//
//  Created by Mary Moore on 5/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Paddle.h"


@implementation Paddle
@synthesize position;
@synthesize velocity;
@synthesize radius;
@synthesize color;
@synthesize dragging;
@synthesize width;
@synthesize goals;

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = CGPointMake(100.0, 100.0);
        velocity = CGPointMake(0.0, 0.0);
        radius = 25.0;
		width = 9;
		goals = 0;
    }
    return self;
}

- (void)update {
	if(dragging) return;
	
    if(position.x + radius +width> 320.0) {
        position.x = 320.0 - radius -width;
    }
    else if(position.x - radius-width <0.0) {
        position.x = radius +width;
    }
	
    if(position.y + radius+width> 460.0) {
        position.y = 460.0 - radius-width;
    }
    else if(position.y - radius -width<0.0) {
        position.y = radius+width;
    }
}

-(void)resetPaddle:(int) yValue{
	//goals++; 		
	position = CGPointMake(160, yValue);
	velocity = CGPointMake(0, 0);
	
		
}

- (CGRect)getRect {
    return CGRectMake(position.x - radius, position.y - radius, radius * 2.0, radius * 2.0);
}

@end


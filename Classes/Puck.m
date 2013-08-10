//
//  Puck.m
//  GravityTut
//
//  Created by BCT Department on 5/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Puck.h"



@implementation Puck
@synthesize position;
@synthesize velocity;
@synthesize radius;
@synthesize color;
@synthesize bounce;
@synthesize gravity;
@synthesize dragging;
@synthesize width;
@synthesize bheight;
@synthesize bwidth;
@synthesize thickness;
@synthesize gRight;
@synthesize gLeft;

- (id) init
{
    self = [super init];
    if (self != nil) {
        bheight = 460.0;
		bwidth = 320.0;
		position = CGPointMake(bwidth/2, bheight/2 -10);
        velocity = CGPointMake(0, 0);
        radius = 13.0;
        color = [UIColor orangeColor].CGColor;
        bounce = -0.25f;
        gravity = 0.0f;
		width = 4;
		gRight = 255;
		gLeft = 65;
		thickness = 4;
		
    }
    return self;
}


- (void)update {
	if(dragging) return;
	
	velocity.y += gravity; //updates velocity
    position.x += velocity.x;//updates position
    position.y += velocity.y;
	
    if(position.x + radius +width> bwidth - thickness) { //if hit right wall
        position.x = bwidth - radius-width - thickness;
        velocity.x *= bounce;
    }
    else if(position.x - radius-width <0.0 + thickness) {//if hit left wall
        position.x = radius+thickness + width;
        velocity.x *= bounce;
    }
	if(position.x - radius - width> gLeft && position.x + radius + width< gRight){ //if is in sliver
		if(position.y + radius + width<0.0 + thickness || position.y - radius - width>bheight - thickness)
		{
			//[self resetPuck];
		}
	}
	else if(position.x -radius -width> gLeft-10 && position.x+radius +width< gRight+10 && position.y - radius -width<0.0 + thickness){
		position.y = radius+width + thickness; //if hits top corner of goal
		velocity.y *= bounce;
		velocity.x = -velocity.x;
	}
	else if(position.x -radius -width> gLeft-10 && position.x+radius +width< gRight+10 && position.y + radius +width>460.0 - thickness){
		position.y = bheight - (radius+width + thickness); //if hits top corner of goal
		velocity.y *= bounce;
	}
	
	else{
		if(position.y - radius -width<0.0 + thickness) {
			position.y = radius+width + thickness;
			velocity.y *= bounce;
		}
		if(position.y +radius + width > bheight - thickness){
			position.y = bheight - radius -width -thickness;
			velocity.y *= bounce;
			}
	}

}


- (void)resetPuck{
	position = CGPointMake(bwidth/2, bheight/2);
	velocity = CGPointMake(0, 0);
		
}

-(void)faceOff{//not used right now because don't know how to do it
	radius = radius*4;
	for (int y = 4; y >= 1; y--)
		radius = radius * (y-1/y);
}

- (CGRect)getRect {
    return CGRectMake(position.x - radius, position.y - radius, radius * 2.0, radius * 2.0);
}

@end

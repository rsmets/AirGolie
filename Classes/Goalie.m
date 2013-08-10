//
//  Goalie.m
//  GravityTut
//
//  Created by BCT Department on 5/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Goalie.h"


@implementation Goalie
@synthesize position;
@synthesize color;
@synthesize width;
@synthesize height;
@synthesize gRight;
@synthesize gLeft;

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = CGPointMake(320.0/2, 1.5);
        color = [UIColor blackColor].CGColor;
		width = 40;
		height = 3.5;
		gRight = 255;
		gLeft = 65;
    }
    return self;
}

- (void)update {
	//if(dragging) return;
	
    if(position.x + width > gRight) { //right side of goal
        position.x = gRight - width;
    }
    else if(position.x < gLeft) { //left side of goal
        position.x = gLeft;
    }
}

- (CGRect)getRect {
    return CGRectMake(position.x, position.y, width, height);
}

@end


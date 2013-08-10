//
//  PuckView.m
//  GravityTut
//
//  Created by BCT Department on 5/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PuckView.h"


@implementation PuckView
int wBoundary=8;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	//puck
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, puck.color);
    CGContextSetLineWidth(context, puck.width);
    CGContextAddEllipseInRect(context, [puck getRect]);
    CGContextStrokePath(context);
	//paddle
    CGContextSetStrokeColorWithColor(context, paddle.color);
    CGContextSetLineWidth(context, paddle.width);
    CGContextAddEllipseInRect(context, [paddle getRect]);
    CGContextStrokePath(context);
	//paddle2
	CGContextSetStrokeColorWithColor(context, paddle2.color);
    CGContextSetLineWidth(context, paddle2.width);
    CGContextAddEllipseInRect(context, [paddle2 getRect]);
    CGContextStrokePath(context);	
	//boundaries
	CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextSetLineWidth(context, wBoundary);
	CGContextMoveToPoint(context, puck.gLeft, 0);
	CGContextAddLineToPoint(context, 0,0);
	CGContextAddLineToPoint(context, 0,460);
	CGContextAddLineToPoint(context, puck.gLeft,460);
	CGContextStrokePath(context);
	CGContextMoveToPoint(context, puck.gRight, 460);
	CGContextAddLineToPoint(context, 320,460);
	CGContextAddLineToPoint(context, 320,0);
	CGContextAddLineToPoint(context, puck.gRight,0);
	CGContextStrokePath(context);
	//Goalie
	CGContextSetStrokeColorWithColor(context, goalie.color);
    CGContextSetLineWidth(context, goalie.height);
    CGContextAddRect(context, [goalie getRect]);
    CGContextStrokePath(context);
	//goalie2
	CGContextSetStrokeColorWithColor(context, goalie2.color);
    CGContextSetLineWidth(context, goalie2.height);
    CGContextAddRect(context, [goalie2 getRect]);
    CGContextStrokePath(context);
	
	
}

- (void)refresh:(Puck *)aPuck {
		puck = aPuck;
    [self setNeedsDisplay];
}

- (void)refresh2:(Paddle *)aPaddle {
	paddle = aPaddle;
    [self setNeedsDisplay];
}

- (void)refresh3:(Goalie *)aGoalie {
	goalie = aGoalie;
    [self setNeedsDisplay];
}

- (void)refresh4:(Goalie *)aGoalie {
	goalie2 = aGoalie;
    [self setNeedsDisplay];
}

- (void)refresh5:(Paddle *)aPaddle {
	paddle2 = aPaddle;
    [self setNeedsDisplay];
}


- (void)dealloc {
    [super dealloc];
}


@end

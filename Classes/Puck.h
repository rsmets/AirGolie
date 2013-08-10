//
//  Puck.h
//  GravityTut
//
//  Created by BCT Department on 5/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Puck : NSObject {
    CGPoint position;
    CGPoint velocity;
    CGFloat radius;
    CGColorRef color;
    CGFloat bounce;
    CGFloat gravity;
	CGFloat width;
	CGFloat bheight;
	CGFloat bwidth;
	CGFloat thickness;
	BOOL dragging;
	NSInteger gRight;
	NSInteger gLeft;
	
	
}

@property CGPoint position;
@property CGPoint velocity;
@property CGFloat radius;
@property CGColorRef color;
@property CGFloat bounce;
@property CGFloat gravity;
@property CGFloat width;
@property CGFloat bheight;
@property CGFloat bwidth;
@property CGFloat thickness;
@property BOOL dragging;
@property NSInteger gRight;
@property NSInteger gLeft;

- (void)update;
- (void)resetPuck;
- (void) faceOff;
- (CGRect)getRect;

@end
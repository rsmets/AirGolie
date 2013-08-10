//
//  Paddle.h
//  GravityTut
//
//  Created by Mary Moore on 5/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Paddle : NSObject {
    CGPoint position;
    CGPoint velocity;
    CGFloat radius;
    CGColorRef color;
	CGFloat width;
	NSInteger goals;
	BOOL dragging;
}

@property CGPoint position;
@property CGPoint velocity;
@property CGFloat radius;
@property CGColorRef color;
@property CGFloat width;
@property BOOL dragging;
@property NSInteger goals;

- (void)update;
- (CGRect)getRect;
- (void)resetPaddle: (int) yValue;

@end

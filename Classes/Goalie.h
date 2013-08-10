//
//  Goalie.h
//  GravityTut
//
//  Created by BCT Department on 5/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Goalie : NSObject {
	CGPoint position;
	CGColorRef color;
	CGFloat width;
	CGFloat height;
	NSInteger gRight;
	NSInteger gLeft;
}

@property CGPoint position;
@property CGColorRef color;
@property CGFloat width;
@property CGFloat height;
@property NSInteger gRight;
@property NSInteger gLeft;

- (void)update;
- (CGRect)getRect;

@end

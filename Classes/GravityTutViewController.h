//
//  GravityTutViewController.h
//  GravityTut
//
//  Created by BCT Department on 5/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Puck.h"
#import "Paddle.h"
#import "Goalie.h"
#import "Settings.h"
//#import <GameKit/GameKit.h>
#import <AudioToolbox/AudioServices.h>
//networking
/*typedef enum {
	NETWORK_ACK,					// no packet
	NETWORK_COINTOSS,				// decide who is going to be the server
	NETWORK_MOVE_EVENT,				// send position
	NETWORK_FIRE_EVENT,				// send fire
	NETWORK_HEARTBEAT				// send of entire state at regular intervals
} packetCodes; */

@class SoundEffect;

@interface GravityTutViewController : UIViewController<UIAccelerometerDelegate>{
	IBOutlet UILabel *score;
	IBOutlet UILabel *score2;
    Puck *puck;
	Paddle *paddle; 
	Paddle *paddle2;
	Goalie *goalie;
	Goalie *goalie2;
	Settings *settings;
	CGPoint lastTouch;
	CGPoint currentTouch;
	SoundEffect * hitP;
	SoundEffect * hitG;
	SoundEffect * scored;
	SoundEffect * scoredOn;
	SoundEffect * hitPad;
	
	// networking
	/*NSInteger gameState;
	NSInteger peerStatus;
	GKSession		*gameSession;
	int				gameUniqueID;
	int				gamePacketNumber;
	NSString		*gamePeerId;
	NSDate			*lastHeartbeatDate;
	
	UIAlertView		*connectionAlert;*/
	
}

@property (nonatomic, retain) UILabel *score;
@property (nonatomic, retain) UILabel *score2;
//networking
/*@property(nonatomic) NSInteger gameState;
@property(nonatomic) NSInteger peerStatus;
@property(nonatomic, retain) GKSession	 *gameSession;
@property(nonatomic, copy)	 NSString	 *gamePeerId;
@property(nonatomic, retain) NSDate		 *lastHeartbeatDate;
@property(nonatomic, retain) UIAlertView *connectionAlert;*/


-(void)updateScore;
-(void)updateScore2;
-(void)onTimer; //every frame
-(void)checkCollision;
-(void)checkGCollision; //check goalie collision
-(void)update;
-(void)resetPuck;
-(int)isScored;
-(void)gameState;
-(int)impact;
-(void)checkPCollision;
-(void)activateGodMode;
-(BOOL)secretCodeActivated;
-(void)goalieAI;
-(void)paddle2AI;

@end


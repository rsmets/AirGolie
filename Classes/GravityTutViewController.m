//
//  GravityTutViewController.m
//  GravityTut
//
//  Created by BCT Department on 5/7/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "GravityTutViewController.h"
#import "PuckView.h"
#import "SoundEffect.h"
//#import "SettingsViewController.h"

/*typedef enum {
 kStateStartGame,
 kStatePicker,
 kStateMultiplayer,
 kStateMultiplayerCointoss,
 kStateMultiplayerReconnect
 } gameStates; */


//
// for the sake of simplicity tank1 is the server and tank2 is the client
//
/*typedef enum {
 kServer,
 kClient
 } gameNetwork;
 
 GameKit Session ID for app
 #define kTankSessionID @"gktank"
 
 #define kMaxTankPacketSize 1024
 
 #pragma mark - */

@implementation GravityTutViewController
@synthesize score;
@synthesize score2;
//@synthesize gameState, peerStatus,gameSession, gamePeerId, lastHeartbeatDate, connectionAlert;
int move=-1;
int bHeight = 460;
int bWidth = 320;
int gameState = 1;
int frameRate = 90;
BOOL activated = false;
int lastScore;
int lastScore2;

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSInteger yourHighScoreValue = [prefs integerForKey:@"highScore"];
	
	NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
	NSInteger yourHighScoreValue2 = [prefs2 integerForKey:@"highScore2"];
	
	//networking
	/* peerStatus = kServer;
	 gamePacketNumber = 0;
	 gameSession = nil;
	 gamePeerId = nil;
	 lastHeartbeatDate = nil; */
	//creates all objects
	puck = [[Puck alloc] init];
	
	settings = [Settings alloc];
	//[settings getGSense];
	
	paddle = [[Paddle alloc] init];
	paddle.position = CGPointMake(bWidth/2, bHeight*3/4);
	paddle.color = [UIColor yellowColor].CGColor;
	paddle.goals = yourHighScoreValue;
	
	paddle2 = [[Paddle alloc] init];
	paddle2.position = CGPointMake(bWidth/2, bHeight/4);
	paddle2.color = [UIColor greenColor].CGColor;
	paddle2.goals = yourHighScoreValue2;
	//paddle2.color = [UIColor colorWithHue: .9 saturation:.7 brightness:.5 alpha:1].CGColor;
	
	goalie = [[Goalie alloc] init];
	goalie.position = CGPointMake(bWidth/2 - goalie.width/2, bHeight-goalie.height-1);
	goalie.color = [UIColor yellowColor].CGColor;
	
	goalie2 = [[Goalie alloc] init];
	goalie2.position = CGPointMake(bWidth/2 - goalie2.width/2, 1);
	goalie2.color = [UIColor greenColor].CGColor;
	
	//loads sound
	NSBundle *mainBundle = [NSBundle mainBundle];	
	hitG = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Laser" ofType:@"wav"]];
	hitP = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Gun Silencer" ofType:@"wav"]];
	scored = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Laser Blasts" ofType:@"wav"]];
	scoredOn = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Laser Blaster" ofType:@"wav"]];
	hitPad = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Alien Death Ray" ofType:@"wav"]];
	
	//makes accelerometer
	UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
	accel.updateInterval = 0.025f;
	accel.delegate = self;
	
	//do if to stop timer
	[NSTimer scheduledTimerWithTimeInterval:1.0 / frameRate target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    NSLog(@"(%.02f, %.02f, %.02f)", acceleration.x, acceleration.y, acceleration.z);
    goalie.position = CGPointMake(goalie.position.x + acceleration.x * (64/**[settings getGSense]*/) ,goalie.position.y);
}

/*
-(void)gameState{
 if(gameState = 1){
 [NSTimer scheduledTimerWithTimeInterval:1.0 / frameRate target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
 }
 else{
 [puck faceOff];
 gameState = 1;
 }*/
 
- (void)onTimer {
	if(gameState = 1){
		//use accel comment out below
		/*
		if(goalie2.position.x + goalie2.width>=puck.gRight)
			move=-1;
		if(goalie2.position.x<=puck.gLeft)
			move= 1;
		goalie2.position = CGPointMake(goalie2.position.x + move,goalie2.position.y);
		 */
			
		if([self isScored] == 1){
			paddle.goals ++;
			NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];	
			[prefs setInteger:paddle.goals forKey:@"highScore"];
			[prefs synchronize];
			[puck resetPuck];
			[paddle resetPaddle: bHeight/4*3];
			[paddle2 resetPaddle: bHeight/4];
		}
		else if([self isScored] == 2){  
			paddle2.goals ++;
			NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];	
			[prefs2 setInteger:paddle2.goals forKey:@"highScore2"];
			[prefs2 synchronize];
			[puck resetPuck];
			[paddle resetPaddle: bHeight/4*3];
			[paddle2 resetPaddle: bHeight/4];
		}
		
		//[paddle setAlphaValue: .1] ;
		[puck update];
		[(PuckView *)self.view refresh:puck];
		[paddle update];
		[(PuckView *)self.view refresh2:paddle];
		[paddle2 update];
		[(PuckView *)self.view refresh5:paddle2];
		[goalie update];
		[(PuckView *)self.view refresh3:goalie];
		[goalie2 update];
		[(PuckView *)self.view refresh4:goalie2];
		[self checkCollision];
		[self checkGCollision];
		[self updateScore];
		[self updateScore2];
		[self checkPCollision];
		[self goalieAI];
		[self paddle2AI];
		
		if([self secretCodeActivated]){
			[self activateGodMode];
		}

		
	}
	else {
		[puck faceOff];
		gameState = 1;
	}
	
	lastTouch = currentTouch;
	
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)updateScore{
	if(paddle.goals>lastScore)
	{
		NSString *scoreDisplay = [NSString stringWithFormat:@"%d",paddle.goals];
		[score setText:scoreDisplay];
	}
	lastScore = paddle.goals;
}


- (void)updateScore2{
	if(paddle2.goals>lastScore2)
	{
		NSString *score2Display = [NSString stringWithFormat:@"%d",paddle2.goals];
		[score2 setText:score2Display];//need to connect label with score to have 2 scores in game.
	}
	lastScore2 = paddle2.goals;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.view];
	//paddle.position = currentTouch;
    CGFloat dx = currentTouch.x - paddle.position.x;
    CGFloat dy = currentTouch.y - paddle.position.y;
    CGFloat dist = (dx * dx + dy * dy);
    if(dist < paddle.radius*paddle.radius) {
			paddle.dragging = YES;
		
		int left = paddle.position.x - paddle.radius - paddle.width;
		int right = paddle.position.x + paddle.radius + paddle.width;
		int top = paddle.position.y - paddle.radius - paddle.width;
		int bottom = paddle.position.y + paddle.radius + paddle.width;
		
		if(currentTouch.x > left && currentTouch.x < right && currentTouch.y > top  && currentTouch.y < bottom){
		paddle.position = currentTouch;}
		else{}
			
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    currentTouch = [touch locationInView:self.view];
	
	int dx = currentTouch.x - paddle.position.x;
	int dy = currentTouch.y - paddle.position.y;
	
	if(dx <= paddle.radius + paddle.width  && dy <= paddle.radius + paddle.width)
		paddle.position = CGPointMake(currentTouch.x, currentTouch.y);
	
	
	/*
	int left = paddle.position.x - paddle.radius - paddle.width;
	int right = paddle.position.x + paddle.radius + paddle.width;
	int top = paddle.position.y - paddle.radius - paddle.width;
	int bottom = paddle.position.y + paddle.radius + paddle.width;

	if(currentTouch.x > left && currentTouch.x < right && currentTouch.y > top  && currentTouch.y < bottom){}
	else*/
			//paddle.position = currentTouch;
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    paddle.dragging = NO;
}

- (void)checkGCollision{//checking collision with golies
	//checking collision with opposing goalie
	if(puck.position.y - puck.radius < goalie2.position.y + goalie2.height){
		if(puck.position.x >= goalie2.position.x && puck.position.x <= goalie2.position.x+goalie2.width){
			[hitG play];
			puck.position = CGPointMake(puck.position.x, puck.radius + puck.width + puck.thickness);
			puck.velocity = CGPointMake(puck.velocity.x,puck.velocity.y * puck.bounce);
		}
		else if(puck.position.x < goalie2.position.x && puck.position.x + puck.radius > goalie2.position.x){
			if(puck.velocity.x > 0){
				[hitG play];
				puck.position = CGPointMake(puck.position.x, puck.radius + puck.width + puck.thickness);
				puck.velocity = CGPointMake(-puck.velocity.x,puck.velocity.y * puck.bounce);
			}
			else {
				[hitG play];
				puck.position = CGPointMake(puck.position.x, puck.radius + puck.width + puck.thickness);
				puck.velocity = CGPointMake(puck.velocity.x,puck.velocity.y * puck.bounce);
			}
		}
		else if(puck.position.x > goalie2.position.x + goalie2.width && puck.position.x - puck.radius < goalie2.position.x + goalie2.width){
			if(puck.velocity.x < 0){
				[hitG play];
				puck.position = CGPointMake(puck.position.x, puck.radius + puck.width + puck.thickness);
				puck.velocity = CGPointMake(-puck.velocity.x,puck.velocity.y * puck.bounce);
			}
			else {
				[hitG play];
				puck.position = CGPointMake(puck.position.x, puck.radius + puck.width + puck.thickness);
				puck.velocity = CGPointMake(puck.velocity.x,puck.velocity.y * puck.bounce);
			}
		}
	}
	
	//checking collision with our golie
	if(puck.position.y + puck.radius > goalie.position.y - goalie.height){
		if(puck.position.x >= goalie.position.x && puck.position.x <= goalie.position.x+goalie.width){
			[hitG play];
			puck.position = CGPointMake(puck.position.x, bHeight - puck.radius - puck.width - puck.thickness);
			puck.velocity = CGPointMake(puck.velocity.x,puck.velocity.y * puck.bounce);
		}
		else if(puck.position.x < goalie.position.x && puck.position.x + puck.radius > goalie.position.x){
			if(puck.velocity.x > 0){
				[hitG play];
				puck.position = CGPointMake(puck.position.x, bHeight - puck.radius - puck.width - puck.thickness);
				puck.velocity = CGPointMake(-puck.velocity.x,puck.velocity.y * puck.bounce);
			}
			else {
				[hitG play];
				puck.position = CGPointMake(puck.position.x, bHeight - puck.radius - puck.width - puck.thickness);
				puck.velocity = CGPointMake(puck.velocity.x,puck.velocity.y * puck.bounce);
			}
		}
		else if(puck.position.x > goalie.position.x + goalie.width && puck.position.x - puck.radius < goalie.position.x + goalie.width){
			if(puck.velocity.x < 0){
				[hitG play];
				puck.position = CGPointMake(puck.position.x, bHeight - puck.radius - puck.width - puck.thickness);
				puck.velocity = CGPointMake(-puck.velocity.x,puck.velocity.y * puck.bounce);
			}
			else {
				[hitG play];
				puck.position = CGPointMake(puck.position.x, bHeight - puck.radius - puck.width - puck.thickness);
				puck.velocity = CGPointMake(puck.velocity.x,puck.velocity.y * puck.bounce);
			}
		}
	}
	
}

- (void)checkCollision{
	CGFloat dx = paddle.position.x - puck.position.x; //difference b/w paddle and puck x value
	CGFloat dy = paddle.position.y - puck.position.y; //" " y value
	CGFloat dist = (dx * dx + dy * dy);
	if(dist < (paddle.radius + puck.radius+puck.width)*(paddle.radius + puck.radius+puck.width))
	{
		[hitP play];
		puck.velocity = CGPointMake(-dx/5, -dy/5);
	}
	CGFloat fx = paddle2.position.x - puck.position.x; //difference b/w paddle and puck x value
	CGFloat fy = paddle2.position.y - puck.position.y; //" " y value
	CGFloat fist = (fx * fx + fy * fy);
	if(fist < (paddle2.radius + puck.radius+puck.width)*(paddle2.radius + puck.radius+puck.width))
	{
		[hitP play];
		puck.velocity = CGPointMake(-fx/5, -fy/5);
	}
}

-(void)checkPCollision{//check paddle collisions
	
	CGFloat dx = paddle.position.x - paddle2.position.x; //difference b/w paddle and paddle2 x value
	CGFloat dy = paddle.position.y - paddle2.position.y; //" " y value
	CGFloat dist = (dx * dx + dy * dy);
	if(dist < (paddle.radius + paddle2.radius+paddle.width)*(paddle.radius + paddle2.radius+paddle2.width))
	{
		[hitPad play];
		//if paddle is: above, below, left, or right dy/dx
		//if(dx<=0 && dy<=0)
			paddle.position = CGPointMake(paddle.position.x + (dx/5), paddle.position.y + (dy/5)); //look at maybe a +
			paddle2.position = CGPointMake(paddle2.position.x - (dx/5), paddle2.position.y - (dy/5));
		//paddle.position = CGPointMake(lastTouch.x, lastTouch.y);
	}
	
	}

-(int) impact {
	int c = (lastTouch.x - currentTouch.x)*(lastTouch.x - currentTouch.x) + (lastTouch.y - currentTouch.y)*(lastTouch.y - currentTouch.y);
	if(c=0)
		return 100;
	else if(c>.5 && c<=1)
		return 11;
	else if(c > 1 && c <= 2)
		return 9;
	else if(c > 2 && c<=3)
		return 7;
	else if(c>3)
		return 5;

	return 13;
}

- (int)isScored {
	//1 is if we score 2 is if they score.
	if(puck.position.x -puck.radius -puck.width> puck.gLeft && puck.position.x+puck.radius +puck.width< puck.gRight){ //if is in sliver
		if(puck.position.y <0.0 ){
			gameState = 0;
			//AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
			[scored play];
			return 1;//returns 1 for player 1 and 2 for player 2
		}
		else if(puck.position.y >bHeight){
			gameState = 0;
			//AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
			[scoredOn play];
			return 2;}
    }
	gameState=1;
	return 0; //if not scored.
}

-(void)activateGodMode{
	if(puck.position.x - puck.radius - puck.width> puck.gLeft && puck.position.x + puck.radius + puck.width< puck.gRight) //if is in sliver
		goalie.position = CGPointMake(puck.position.x - goalie.width/2, goalie.position.y );
	}

-(void)goalieAI{
	int error = arc4random()%50;
	int LR = arc4random()%2;
	int moveORnot = arc4random()%100;

	
	if (LR <= 1)
		error = -error;
	
	if(puck.position.x - puck.radius - puck.width> puck.gLeft && puck.position.x + puck.radius + puck.width< puck.gRight
	   && moveORnot <=10) //if is in sliver
			goalie2.position = CGPointMake(puck.position.x - goalie2.width/2 + error, goalie2.position.y );
}

-(void)paddle2AI{
	
	int px = paddle2.position.x - paddle2.radius - paddle2.width;
	int ppx = paddle2.position.x + paddle2.radius + paddle2.width;
	//int py = paddle2.position.y - paddle2.radius - paddle2.width;
	//int ppy = paddle2.position.y + paddle2.radius + paddle2.width;
	int change = 1;
	int paddleSpeed = 1;
	int lowPoint = 345; // 345 = 3/4 of bHeight
	int highPoint = 40;
	int LR = arc4random()%4;
	
	//going after puck AI
	//based on puck position
if(paddle2.position.y>lowPoint && (px < puck.gLeft || ppx>puck.gRight))
{
	if(px < puck.gLeft)
		paddle2.position = CGPointMake(paddle2.position.x+change,paddle2.position.y); // - paddleSpeed
	else if(ppx>puck.gRight)
		paddle2.position = CGPointMake(paddle2.position.x-change,paddle2.position.y);
}
else if (paddle2.position.y<highPoint && (px< puck.gLeft || ppx>puck.gRight)) /*|| 
		(paddle2.position.x < bWidth/2 && puck.position.x > puck.gLeft) ||
		(paddle2.position.x > bWidth/2 && puck.position.x < puck.gLeft)))*/
{
	if(px < puck.gLeft)
		paddle2.position = CGPointMake(paddle2.position.x+change,paddle2.position.y);
	else if(ppx>puck.gRight)
		paddle2.position = CGPointMake(paddle2.position.x-change,paddle2.position.y);
	else if(paddle2.position.x < bWidth/2 && puck.position.x > puck.gLeft)	
		paddle2.position = CGPointMake(paddle2.position.x,paddle2.position.y - paddleSpeed);
	else if(paddle2.position.x > bWidth/2 && puck.position.x < puck.gLeft)	
		paddle2.position = CGPointMake(paddle2.position.x,paddle2.position.y - paddleSpeed);

}
else
{
	if(puck.position.x<paddle2.position.x)
		//if(paddle2.position.y < lowPoint)
			if(paddle2.position.y > puck.position.y-15)
				paddle2.position = CGPointMake(paddle2.position.x- paddleSpeed,paddle2.position.y - 2*paddleSpeed);
			else
				paddle2.position = CGPointMake(paddle2.position.x- paddleSpeed,paddle2.position.y);
        //else //if under lowpoint
			//if(paddle.position.y > puck.position.y)
			//	paddle2.position = CGPointMake(paddle2.position.x- paddleSpeed,paddle2.position.y - paddleSpeed/2);
			//else
			//	paddle2.position = CGPointMake(paddle2.position.x- paddleSpeed,paddle2.position.y);
	else //if(puck.position.x>=paddle2.position.x)
		//if(paddle2.position.y < lowPoint)
			if(paddle2.position.y > puck.position.y-15)
				paddle2.position = CGPointMake(paddle2.position.x+ paddleSpeed,paddle2.position.y - 2*paddleSpeed);
			else 
				paddle2.position = CGPointMake(paddle2.position.x+ paddleSpeed,paddle2.position.y);
		//else //if under lowpoint
			//if(paddle2.position.y > puck.position.y-15)
			//	paddle2.position = CGPointMake(paddle2.position.x+ paddleSpeed,paddle2.position.y - paddleSpeed/2);
			//else 
			//	paddle2.position = CGPointMake(paddle2.position.x+ paddleSpeed,paddle2.position.y);
	
	
	if(puck.position.y<paddle2.position.y)
		if(puck.position.x < bWidth/2)
			paddle2.position = CGPointMake(paddle2.position.x + paddleSpeed,paddle2.position.y-paddleSpeed);
		else
			paddle2.position = CGPointMake(paddle2.position.x - paddleSpeed,paddle2.position.y-paddleSpeed);
	
	else //if(puck.position.y>=paddle2.position.y)
		if(paddle2.position.y<lowPoint)
			if(paddle2.position.x < puck.position.x)
				paddle2.position = CGPointMake(paddle2.position.x + paddleSpeed, paddle2.position.y + paddleSpeed);
			else
				paddle2.position = CGPointMake(paddle2.position.x - paddleSpeed, paddle2.position.y + paddleSpeed);
		else //under lowPoint
			if(LR <= 2)//if goes left or right when near goal when paddle2.x = puck.x
				if(paddle2.position.x + goalie.width < puck.position.x)
					paddle2.position = CGPointMake(paddle2.position.x - paddleSpeed, paddle2.position.y + paddleSpeed);
				else
					paddle2.position = CGPointMake(paddle2.position.x + paddleSpeed, paddle2.position.y + paddleSpeed);
			else
				if(paddle2.position.x + goalie.width > puck.position.x)
					paddle2.position = CGPointMake(paddle2.position.x - 2*paddleSpeed, paddle2.position.y + paddleSpeed);
				else
					paddle2.position = CGPointMake(paddle2.position.x + 2*paddleSpeed, paddle2.position.y + paddleSpeed);
	
	
}
	
	
	
	/*
	if(px < 20  && py <20)
		paddle2.position = CGPointMake(paddle2.position.x-paddleSpeed/2,paddle2.position.y+2*paddleSpeed);
	else if (px < 20 && ppy > bHeight - 20)
		paddle2.position = CGPointMake(paddle2.position.x-paddleSpeed/2,paddle2.position.y-2*paddleSpeed);
	else if(ppx > bWidth - 20 && py <20)
		paddle2.position = CGPointMake(paddle2.position.x-5,paddle2.position.y+5);
	else if(ppx > bWidth - 20 && ppy > bHeight - 20)
		paddle2.position = CGPointMake(paddle2.position.x-5,paddle2.position.y-5);
	 */
	
	
}

-(BOOL)secretCodeActivated{
	CGPoint secretPoint = CGPointMake(300,20);
	CGPoint secretPoint2 = CGPointMake(20,440);
	if(lastTouch.x >secretPoint.x && lastTouch.y < secretPoint.y  && 
	   currentTouch.x < secretPoint2.x && currentTouch.y > secretPoint2.y){
		activated = true;
		return true;
	}
	if (activated == true)
		return true;
	return false;
		
		
}

- (void)dealloc {
	[goalie release];
	[goalie2 release];
	[paddle release];
	[paddle2 release];
	[puck release];
	[hitP dealloc];
	[hitG dealloc];
	[scored dealloc];
	[scoredOn dealloc];
	[hitPad dealloc];
	[settings dealloc];
	//[ourSound dealloc];
    [super dealloc];
}

@end

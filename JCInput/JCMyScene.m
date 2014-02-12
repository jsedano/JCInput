//
//  JCMyScene.m
//  JCInput
//
//  Created by Juan Carlos Sedano Salas on 19/09/13.
//  Copyright (c) 2013 Juan Carlos Sedano Salas. All rights reserved.
//

#import "JCMyScene.h"
#import "JCJoystick.h"
#import "JCImageJoystick.h"
#import "JCButton.h"
@interface JCMyScene()
    @property (strong, nonatomic) JCJoystick *joystick;
    @property (strong, nonatomic) JCButton *normalButton;
    @property (strong, nonatomic) JCButton *turboButton;
    @property SKLabelNode *myLabel1;
    @property SKLabelNode *myLabel2;
    @property (strong, nonatomic) JCImageJoystick *imageJoystick;


@end

@implementation JCMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        //JCJoystick
        self.joystick = [[JCJoystick alloc] initWithControlRadius:40 baseRadius:45 baseColor:[SKColor blueColor] joystickRadius:25 joystickColor:[SKColor redColor]];
        [self.joystick setPosition:CGPointMake(70,70)];
        [self addChild:self.joystick];
        
        
        //JCImageJoystic
        self.imageJoystick = [[JCImageJoystick alloc]initWithJoystickImage:(@"redStick.png") baseImage:@"stickbase.png"];
        [self.imageJoystick setPosition:CGPointMake(80, 200)];
        [self addChild:self.imageJoystick];
        
        //JCButton
        
        self.normalButton = [[JCButton alloc] initWithButtonRadius:25 color:[SKColor greenColor] pressedColor:[SKColor blackColor] isTurbo:NO];
        [self.normalButton setPosition:CGPointMake(size.width - 40,95)];
        [self addChild:self.normalButton];
        
        
        self.turboButton = [[JCButton alloc] initWithButtonRadius:25 color:[SKColor yellowColor] pressedColor:[SKColor blackColor] isTurbo:YES];
        [self.turboButton setPosition:CGPointMake(size.width - 85,50)];
        [self addChild:self.turboButton];
        
        //scheduling the action to check buttons
        SKAction *wait = [SKAction waitForDuration:0.3];
        SKAction *checkButtons = [SKAction runBlock:^{
            [self checkButtons];
        }];
        SKAction *checkButtonsAction = [SKAction sequence:@[wait,checkButtons]];
        [self runAction:[SKAction repeatActionForever:checkButtonsAction]];

        
        
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        self.myLabel1 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        self.myLabel1.text = @"Hello";
        self.myLabel1.fontSize = 30;
        self.myLabel1.position = CGPointMake(CGRectGetMidX(self.frame)*0.5,
                                       CGRectGetMidY(self.frame));
        
        [self addChild:self.myLabel1];
        
        self.myLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        self.myLabel2.text = @"World";
        self.myLabel2.fontSize = 30;
        self.myLabel2.position = CGPointMake(CGRectGetMidX(self.frame)*1.5,
                                            CGRectGetMidY(self.frame));
        
        [self addChild:self.myLabel2];
        
        
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    [self.myLabel1 setPosition:CGPointMake(self.myLabel1.position.x+self.joystick.x, self.myLabel1.position.y+self.joystick.y)];
    
    
    [self.myLabel2 setPosition:CGPointMake(self.myLabel2.position.x+self.imageJoystick.x, self.myLabel2.position.y+self.imageJoystick.y)];

    /* Called before each frame is rendered */
}

- (void)checkButtons
{
    
    if (self.normalButton.wasPressed) {
        [self addSquareIn:CGPointMake(0,self.size.height-40) withColor:[SKColor greenColor]];
    }
    
    if (self.turboButton.wasPressed) {
        [self addSquareIn:CGPointMake(0,self.size.height-80) withColor:[SKColor yellowColor]];
    }
    
}

- (void)addSquareIn:(CGPoint)position
          withColor:(SKColor *)color
{
    SKSpriteNode *square = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(15,10)];
    [square setPosition:position];
    SKAction *move = [SKAction moveTo:CGPointMake(self.size.width+square.size.width/2,position.y) duration:1];
    SKAction *destroy = [SKAction removeFromParent];
    [self addChild:square];
    [square runAction:[SKAction sequence:@[move,destroy]]];
}

@end

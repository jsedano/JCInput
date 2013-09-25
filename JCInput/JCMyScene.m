//
//  JCMyScene.m
//  JCInput
//
//  Created by Juan Carlos Sedano Salas on 19/09/13.
//  Copyright (c) 2013 Juan Carlos Sedano Salas. All rights reserved.
//

#import "JCMyScene.h"
#import "JCJoystick.h"
#import "JCButton.h"
@interface JCMyScene()
    @property (strong, nonatomic) JCJoystick *joystick;
    @property (strong, nonatomic) JCButton *normalButton;
    @property (strong, nonatomic) JCButton *turboButton;
    @property SKLabelNode *myLabel;
@end

@implementation JCMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        //JCJoystick
        self.joystick = [[JCJoystick alloc] initWithControlRadius:40 baseRadius:45 baseColor:[SKColor blueColor] joystickRadius:25 joystickColor:[SKColor redColor]];
        [self.joystick setPosition:CGPointMake(70,70)];
        [self addChild:self.joystick];
        //JCButton
        
        self.normalButton = [[JCButton alloc] initWithButtonRadius:25 onColor:[SKColor greenColor] offColor:[SKColor blackColor] isTurbo:NO];
        [self.normalButton setPosition:CGPointMake(size.width - 40,95)];
        [self addChild:self.normalButton];
        
        
        self.turboButton = [[JCButton alloc] initWithButtonRadius:25 onColor:[SKColor yellowColor] offColor:[SKColor blackColor] isTurbo:YES];
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
        
        self.myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        self.myLabel.text = @"Hello, World!";
        self.myLabel.fontSize = 30;
        self.myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:self.myLabel];
        
        
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    [self.myLabel setPosition:CGPointMake(self.myLabel.position.x+self.joystick.x, self.myLabel.position.y+self.joystick.y)];
    

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

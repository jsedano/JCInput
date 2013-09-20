//
//  JCMyScene.m
//  JCInput
//
//  Created by Juan Carlos Sedano Salas on 19/09/13.
//  Copyright (c) 2013 Juan Carlos Sedano Salas. All rights reserved.
//

#import "JCMyScene.h"
#import "JCJoystick.h"
@interface JCMyScene()
    @property JCJoystick *joystick;
    @property SKLabelNode *myLabel;
@end

@implementation JCMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        self.joystick = [[JCJoystick alloc] initWithControlRadius:40 baseRadius:45 baseColor:[SKColor blueColor] joystickRadius:25 joystickColor:[SKColor redColor]];
        [self.joystick setPosition:CGPointMake(70,70)];
        [self addChild:self.joystick];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
     */
}

-(void)update:(CFTimeInterval)currentTime {
    [self.myLabel setPosition:CGPointMake(self.myLabel.position.x+self.joystick.x, self.myLabel.position.y+self.joystick.y)];
    /* Called before each frame is rendered */
}

@end

//
//  JCImageJoystick.m
//  JCInput
//
//  Created by Juan Carlos Sedano Salas on 11/02/14.
//  Copyright (c) 2014 Juan Carlos Sedano Salas. All rights reserved.
//

#import "JCImageJoystick.h"
#import "Math.h"
@interface JCImageJoystick()
    @property (strong, nonatomic) SKSpriteNode *joystick;
    @property (nonatomic,strong) UITouch *onlyTouch;
    @property float angle;
    @property float radiousSR2;
    @property float controlRadius;
@end

@implementation JCImageJoystick
-(id)initWithJoystickImage:(NSString *)joystickImage baseImage:(NSString *)baseImage
{
    if((self = [super initWithImageNamed:baseImage]))
    {
        self.joystick = [[SKSpriteNode alloc]initWithImageNamed:joystickImage];
        [self.joystick setPosition:CGPointMake(self.position.x/2, self.position.y/2)];
        [self addChild:self.joystick];
        self.controlRadius = self.joystick.size.width/2;
        self.radiousSR2 = pow(self.controlRadius, 2);
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (!self.onlyTouch) {
        self.onlyTouch = [touches anyObject];
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if(!self.onlyTouch){
        return;
    }
    CGPoint location = [self.onlyTouch locationInNode:[self parent]];
    CGFloat newx = location.x;
    CGFloat newy = location.y;
    if((pow(newx-self.position.x,2)+pow(newy-self.position.y,2))>self.radiousSR2){
        self.angle = atan2f (newy -self.position.y,newx  -self.position.x);
        newx = (float)(self.position.x + self.controlRadius*cos(self.angle));
        newy = (float)(self.position.y + self.controlRadius*sin(self.angle));
    }
    self.joystick.position=[self convertPoint:CGPointMake(newx, newy) fromNode:[self parent]];
    self.x = (newx-self.position.x)/self.controlRadius;
    self.y = (newy-self.position.y)/self.controlRadius;

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if ([[touches allObjects] containsObject:self.onlyTouch]) {
        self.onlyTouch = nil;
        self.joystick.position=CGPointMake(0,0);
        self.x = 0;
        self.y = 0;
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if ([[touches allObjects] containsObject:self.onlyTouch]) {
        self.onlyTouch = nil;
        self.joystick.position=CGPointMake(0,0);
        self.x = 0;
        self.y = 0;
    }
}
@end

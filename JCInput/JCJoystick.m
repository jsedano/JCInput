//
//  JC.m
//  TestSpriteKit01
//
//  Created by Juan Carlos Sedano Salas on 30/08/13.
//  Copyright (c) 2013 Juan Carlos Sedano Salas. All rights reserved.
//

#import "JCJoystick.h"
#import "Math.h"
@interface JCJoystick ()
    @property (nonatomic, strong) SKShapeNode *interior;
    @property float angle;
    @property (nonatomic,strong) UITouch *onlyTouch;
    @property float baseRadius;
    @property float controlRadius;
    @property float joystickRadius;
    @property float radiusSR2;
    @property SKColor *baseColor;
    @property SKColor *joystickColor;
@end

@implementation JCJoystick

-(id)initWithControlRadius:(float)controlRadious
                baseRadius:(float)baseRadius
                 baseColor:(SKColor *)baseColor
            joystickRadius:(float)joystickRadius
             joystickColor:(SKColor *)joystickColor

{
    if((self = [super init]))
    {
        self.controlRadius = controlRadious;
        self.baseRadius = baseRadius;
        self.joystickRadius = joystickRadius;
        self.baseColor = baseColor;
        self.joystickColor = joystickColor;
        self.onlyTouch = nil;
        self.radiusSR2 = pow(controlRadious, 2);
        [self setUserInteractionEnabled:YES];
        
        CGMutablePathRef circlePath = CGPathCreateMutable();
        CGPathAddEllipseInRect(circlePath , NULL , CGRectMake(self.position.x-self.baseRadius, self.position.y-self.baseRadius, self.baseRadius*2, self.baseRadius*2) );
        self.path = circlePath;
        self.fillColor =  self.baseColor;
        self.lineWidth=0;
        CGPathRelease( circlePath );
        
        
        self.interior = [SKShapeNode node];
        circlePath = CGPathCreateMutable();
        CGPathAddEllipseInRect(circlePath , NULL , CGRectMake(self.position.x-self.joystickRadius, self.position.y-self.joystickRadius, self.joystickRadius*2, self.joystickRadius*2) );
        self.interior.path = circlePath;
        self.interior.fillColor =  self.joystickColor;
        self.interior.lineWidth = 0;
        CGPathRelease( circlePath );
        
        self.interior.position = self.position;
        self.interior.zPosition = 1;
        [self addChild:self.interior];
        
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
    if((pow(newx-self.position.x,2)+pow(newy-self.position.y,2))>self.radiusSR2){
        self.angle = atan2f (newy -self.position.y,newx  -self.position.x);
        newx = (float)(self.position.x + self.controlRadius*cos(self.angle));
        newy = (float)(self.position.y + self.controlRadius*sin(self.angle));
    }
    self.interior.position=[self convertPoint:CGPointMake(newx, newy) fromNode:[self parent]];
    self.x = (newx-self.position.x)/self.controlRadius;
    self.y = (newy-self.position.y)/self.controlRadius;
}   
    
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if ([[touches allObjects] containsObject:self.onlyTouch]) {
        self.onlyTouch = nil;
        self.interior.position=CGPointMake(0,0);
        self.x = 0;
        self.y = 0;
    }
}
    
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if ([[touches allObjects] containsObject:self.onlyTouch]) {
        self.onlyTouch = nil;
        self.interior.position=CGPointMake(0,0);
        self.x = 0;
        self.y = 0;
    }
}
@end

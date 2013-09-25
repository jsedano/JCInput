//
//  JCButton.m
//  TestSpriteKit01
//
//  Created by Juan Carlos Sedano Salas on 18/09/13.
//  Copyright (c) 2013 Juan Carlos Sedano Salas. All rights reserved.
//

#import "JCButton.h"
#import "JCJoystick.h"
#import "Math.h"
@interface JCButton()
@property (nonatomic,strong) UITouch *onlyTouch;
@property float buttonRadius;
@property SKColor *onColor;
@property SKColor *offColor;
@property BOOL wasRead;
@property BOOL isOn;
@property BOOL isTurbo;

@end

@implementation JCButton

-(id)initWithButtonRadius:(float)buttonRadious
                  onColor:(SKColor *)onColor
                 offColor:(SKColor *)offColor
                  isTurbo:(BOOL)isTurbo

{
    if((self = [super init]))
    {
        NSLog(@"??");
        self.onColor = onColor;
        self.offColor = offColor;
        self.onlyTouch = nil;
        self.buttonRadius = buttonRadious;
        self.isTurbo = isTurbo;
        self.isOn = NO;
        self.wasRead = NO;
        [self setUserInteractionEnabled:YES];
        CGMutablePathRef circlePath = CGPathCreateMutable();
        CGPathAddEllipseInRect(circlePath , NULL , CGRectMake(self.position.x-self.buttonRadius, self.position.y-self.buttonRadius, self.buttonRadius*2, self.buttonRadius*2) );
        self.path = circlePath;
        self.fillColor =  self.onColor;
        self.lineWidth=0;
        CGPathRelease( circlePath );
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (!self.onlyTouch) {
        self.onlyTouch = [touches anyObject];
        self.isOn = YES;
        self.wasRead = NO;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if(!self.onlyTouch){
        return;
    }
    CGPoint location = [self.onlyTouch locationInNode:[self parent]];
    if (![self containsPoint:location]) {
        self.onlyTouch = nil;
        if (self.isTurbo) {
            if (self.wasRead) {
                self.isOn = NO;
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if ([[touches allObjects] containsObject:self.onlyTouch]) {
        if (self.wasRead) {
            self.isOn = NO;
        }
        self.onlyTouch = nil;
    }
    
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if ([[touches allObjects] containsObject:self.onlyTouch]) {
        self.onlyTouch = nil;
    }
}


-(BOOL)wasPressed
{
    self.wasRead = YES;
    if (self.isOn) {
        if (!self.isTurbo) {
            self.isOn = NO;
        }
        return YES;
    }
    return NO;

}
@end

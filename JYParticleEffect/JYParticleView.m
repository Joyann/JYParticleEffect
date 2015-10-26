//
//  JYParticleView.m
//  JYParticleEffect
//
//  Created by joyann on 15/10/26.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "JYParticleView.h"

@interface JYParticleView ()
@property (nonatomic, strong) UIBezierPath *linePath;
@property (nonatomic, weak) CALayer *particleLayer;
@property (nonatomic, weak) CAReplicatorLayer *repLayer;
@end

@implementation JYParticleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUp];
}

- (void)setUp
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:pan];
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    self.linePath = linePath;
    
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.frame = self.bounds;
    repLayer.instanceCount = 20;
    repLayer.instanceDelay = 0.1;
    [self.layer addSublayer:repLayer];
    self.repLayer = repLayer;
    
    CALayer *particleLayer = [CALayer layer];
    particleLayer.frame = CGRectMake(-10, -10, 10, 10);
    particleLayer.backgroundColor = [UIColor purpleColor].CGColor;
    [repLayer addSublayer:particleLayer];
    self.particleLayer = particleLayer;
}

#pragma mark - Handle Pan

- (void)handlePan: (UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        [self.linePath moveToPoint:point];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.linePath addLineToPoint:point];
        [self setNeedsDisplay];
    }
}

#pragma mark - Draw Rect

- (void)drawRect:(CGRect)rect
{
    [self.linePath stroke];
}

#pragma mark - Actions

- (void)start
{
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation"];
    translation.path = self.linePath.CGPath;
    translation.duration = 0.5;
    translation.repeatCount = MAXFLOAT;
    translation.autoreverses = YES;
    [self.particleLayer addAnimation:translation forKey:nil];
}

- (void)redraw
{
    [self.particleLayer removeAllAnimations];
    
    [self.linePath removeAllPoints];
    
    [self setNeedsDisplay];
}

@end

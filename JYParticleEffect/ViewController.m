//
//  ViewController.m
//  JYParticleEffect
//
//  Created by joyann on 15/10/26.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "ViewController.h"
#import "JYParticleView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet JYParticleView *particleView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Actions

- (IBAction)start:(id)sender
{
    [self.particleView start];
}

- (IBAction)redraw:(id)sender
{
    [self.particleView redraw];
}


@end

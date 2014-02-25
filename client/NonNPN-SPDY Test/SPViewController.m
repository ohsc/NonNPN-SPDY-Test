//
//  SPViewController.m
//  NonNPN-SPDY Test
//
//  Created by OHSC on 14-2-25.
//  Copyright (c) 2014年 imchao. All rights reserved.
//

#import "SPViewController.h"
#import "SPDYClient.h"

@interface SPViewController () {
    SPDYClient *_client;
}
@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _client = [[SPDYClient alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)test:(id)sender {
    [self testSending];
}

- (void)testSending {
    NSDate *now = [NSDate new];
    NSLog(@"begin time %@", now);
    for (NSUInteger i = 0; i < 100; i++) {
        [_client sendMessage:[NSString stringWithFormat:@"the %d nd message", i]];
    }
    
}


@end

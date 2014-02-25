//
//  SPDYClient.h
//  NonNPN-SPDY Test
//
//  Created by OHSC on 14-2-25.
//  Copyright (c) 2014年 imchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDYClient : NSObject

- (void)sendMessage:(NSString *)payload;

@end

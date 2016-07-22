//
//  Comment.m
//  TableView
//
//  Created by sbxfc on 16/7/22.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import "Comment.h"

@implementation Comment

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = super.init;
    if (self) {
        _identifier = [self uniqueIdentifier];
        _name = dict[@"name"];
        _addr = dict[@"addr"];
        _time = dict[@"time"];
        _content = dict[@"content"];
        _praise = dict[@"praise"];
    }
    return self;
}

- (NSString *)uniqueIdentifier
{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end

//
//  GifView.h
//  GifView
//
//  Created by sbxfc on 16/7/25.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GifView : UIView

-(instancetype)initWithGif:(NSURL*)gifURL;
-(void)play;
-(void)stop;
@end

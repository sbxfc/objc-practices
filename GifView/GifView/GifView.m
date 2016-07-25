//
//  GifView.m
//  GifView
//
//  Created by sbxfc on 16/7/25.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import "GifView.h"
#import <ImageIO/ImageIO.h>

@interface GifView()
@property (nonatomic, strong) NSMutableArray *gifFrames;
@property (nonatomic, strong) NSMutableArray *gifTimes;
@property (nonatomic) CGFloat timeTotal;
@end

@implementation GifView

-(instancetype)initWithGif:(NSURL*)gifURL
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.gifFrames = @[].mutableCopy;
        self.gifTimes  = @[].mutableCopy;
        self.timeTotal = 0;
        
        CGFloat width = 0,height = 0;
        [self fetchData:gifURL width:&width height:&height];
        self.frame = CGRectMake(0, 0, width, height);
    }
    
    return self;
}

-(void)fetchData:(NSURL*)gifURL width:(CGFloat*)width height:(CGFloat*)height
{
    NSData *data = [NSData dataWithContentsOfURL:gifURL];
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    if (src) {
        NSMutableArray* frameDurations = @[].mutableCopy;
        size_t count = CGImageSourceGetCount(src);
        for (size_t i = 0; i < count; i++) {
            CGImageRef imgRef = CGImageSourceCreateImageAtIndex(src, i, NULL);
            CFDictionaryRef propertiesCF = CGImageSourceCopyPropertiesAtIndex(src,i,nil);
            NSDictionary *properties = (__bridge NSDictionary*)(propertiesCF);
            
            if(!*width && !*height){
                *width = [[properties valueForKey:(NSString *)kCGImagePropertyPixelWidth] floatValue];
                *height = [[properties valueForKey:(NSString *)kCGImagePropertyPixelHeight] floatValue];
            }
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            CGFloat duration = 0.0;
            NSNumber *delayTimeUnclampedProp = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            if(delayTimeUnclampedProp){
                duration = [delayTimeUnclampedProp floatValue];
            }
            else{
                NSNumber *delayTimeProp = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFDelayTime];
                if(delayTimeProp) {
                    duration = [delayTimeProp floatValue];
                }
            }
            
            UIImage* img = nil;
            if (imgRef) {
                img = [UIImage imageWithCGImage:imgRef];
                CGImageRelease(imgRef);
            }
            
            [self.gifFrames addObject:(__weak id)(img.CGImage)];
            [frameDurations addObject:@(duration)];
            self.timeTotal += duration;
            
            CFRelease(propertiesCF);
        }
        
        CGFloat delayTime = 0;
        self.gifTimes = @[@(delayTime)].mutableCopy;
        for (NSNumber* time in frameDurations) {
            delayTime += time.floatValue;
            [self.gifTimes addObject:@(delayTime/self.timeTotal)];
        }
        
        CFRelease(src);
    }
}

-(void)play
{
    if(self.timeTotal > 0)
    {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
        animation.calculationMode = kCAAnimationDiscrete;
        animation.keyTimes = self.gifTimes;
        animation.values = self.gifFrames;
        animation.duration = self.timeTotal;
        animation.repeatCount = HUGE_VAL;
        [self.layer addAnimation:animation forKey:nil];
    }
}

-(void)stop
{
    [self.layer removeAllAnimations];
}



@end

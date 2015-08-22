//
//  ImageProcesser.m
//  PictureSampled
//
//  Created by VKWK on 8/22/15.
//  Copyright (c) 2015 VKWK. All rights reserved.
//

#import "ImageProcesser.h"
@import QuartzCore;
@import ImageIO;

@interface ImageProcesser()
{
    CGContextRef imageContext;
    CGImageRef imageref;
    CGColorSpaceRef colorSpace;
    unsigned long PicWidth;
    unsigned long PicHeight;
//    CGFloat *bitmap;
//    UIColor* sampledArray[30][30];
    NSMutableArray *ColorList;
    unsigned long perRow;
    unsigned char *ImageBitmaps;
    
    int widthCount;
    int heightCount;
}
@end

@implementation ImageProcesser

//+(ImageProcesser*)sharedObject
//{
//    static dispatch_once_t once;
//    static ImageProcesser* share;
//    dispatch_once(&once, ^{
//        if (share==nil) {
//            share=[[ImageProcesser alloc]init];
//        }
//    });
//    return share;
//}

-(instancetype)init
{
    self=[super init];
    if (self) {
        ColorList=[NSMutableArray array];
    }
    return self;
}

-(UIImage*)sampledImage
{
    
    return nil;
}

-(void)setOriginalImage:(UIImage *)originalImage
{
    imageref=originalImage.CGImage;
    PicWidth=CGImageGetWidth(imageref);
    PicHeight=CGImageGetHeight(imageref);
    perRow=PicWidth*4;
    [ColorList removeAllObjects];
    unsigned long totalBytes=perRow*PicHeight;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    void*bitmap=malloc(totalBytes);

    if (imageContext) {
        CGContextRelease(imageContext);
    }
    
    imageContext=CGBitmapContextCreate(bitmap, PicWidth, PicHeight, 8, perRow, colorSpace, 1);
    CGRect rect={{0,0},{PicWidth,PicHeight}};
    CGContextDrawImage(imageContext, rect, imageref);

    if (ImageBitmaps) {
        free(ImageBitmaps);
    }
    ImageBitmaps = CGBitmapContextGetData(imageContext);
    
}

-(void)processSampleSize:(int)width AndHeight:(int)height
{
    double perWidth=PicWidth/(width+1.f);
    double perHeight=PicHeight/(height+1.f);
//    NSLog(@"total Width is %ld",PicWidth);
//    NSLog(@"total Height is %ld",PicHeight);
//    NSLog(@"per width is %lf",perWidth);
//    NSLog(@"per height is %lf",perHeight);
    widthCount=width;
    heightCount=height;
    
    for (int i=0; i<width; i++) {
        for (int j=0; j<height; j++) {
            unsigned long position_x=(unsigned long)round(perWidth*(i+1)-1);
            unsigned long position_y=(unsigned long)round(perHeight*(j+1)-1);
            unsigned long offset=(position_y-1)*perRow+position_x*4;
//            NSLog(@"x is %ld;y is %ld",position_x,position_y);
//            NSLog(@"offset is %ld",offset);
            u_int32_t Red=ImageBitmaps[offset];
            u_int32_t Green=ImageBitmaps[offset+1];
            u_int32_t Blue=ImageBitmaps[offset+2];
            u_int32_t Alpha=ImageBitmaps[offset+3];

            [ColorList addObject:[UIColor colorWithRed:Red/255.f green:Green/255.f blue:Blue/255.f alpha:Alpha/255.f]];
        }
    }
}

-(UIColor*)colorAtX:(int)x_axis andY:(int)y_axis
{
    NSInteger index=x_axis*widthCount+y_axis;
    return ColorList[index];
}

-(UIColor*)getColorAtPosition:(unsigned long)X_axis AndY_axis:(unsigned long)Y_axis
{
    return nil;
}


-(void)freeMemmory
{
    if (imageContext) {
        CGContextRelease(imageContext);
    }
    if (colorSpace) {
        CGColorSpaceRelease(colorSpace);
    }
    if (ImageBitmaps) {
        free(ImageBitmaps);
    }
    if (imageref) {
        imageref=nil;
    }
}

@end

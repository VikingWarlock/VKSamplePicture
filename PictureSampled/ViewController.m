//
//  ViewController.m
//  PictureSampled
//
//  Created by VKWK on 8/22/15.
//  Copyright (c) 2015 VKWK. All rights reserved.
//

#import "ViewController.h"
#import "ImageProcesser.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIView *screen[64][64];
    UIImageView *originalImageView;
    ImageProcesser *processer;
    NSMutableArray *imageList;
    int index;
    int sampleW;
    int sampleH;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    
    [self resetImageset];
    
    processer=[[ImageProcesser alloc]init];
    
    
    sampleW=15;
    sampleH=15;
    
    
    float width=self.view.frame.size.width/sampleW;
    float offset_y=120.f;
    
    
    for (int i =0; i<sampleW; i++) {
        for (int j=0; j<sampleH; j++) {
            screen[i][j]=[[UIView alloc]initWithFrame:CGRectMake(width*i, offset_y+width*j, width, width)];
            screen[i][j].layer.borderColor=[UIColor grayColor].CGColor;
            screen[i][j].layer.borderWidth=0.5f;
            
            [self.view addSubview:screen[i][j]];
            [screen[i][j] setBackgroundColor:[UIColor blackColor]];
        }
    }
    originalImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2.f-50.f, self.view.frame.size.height-100.f, 100.f, 100.f)];
    [self.view addSubview:originalImageView];
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    [self changeImage];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)changeImage
{
    UIImage *origin=imageList[index];
    
    processer.originalImage=origin;
    [processer processSampleSize:sampleW AndHeight:sampleH];
    originalImageView.image=origin;
    
    for (int i =0; i<sampleW; i++) {
        for (int j=0; j<sampleH; j++) {
        [screen[i][j] setBackgroundColor:[processer  colorAtX:i andY:j]];
        }
    }
}

-(void)resetImageset
{
    imageList=[NSMutableArray array];
    NSArray *fileName=@[@"xuan.png",@"lun.png",@"02.png",@"05.png",@"13.png",@"14.png",@"03.png",@"11.png",@"04.png",@"01.png",@"10.png",@"06.png",@"07.png",@"08.png",@"09.png",@"15.png",@"12.png",@"16.jpg",@"test1.png",@"da.png"];
    for(NSString *name in fileName)
    {
        [imageList addObject:[UIImage imageNamed:name]];
    }
}

-(void)handleTimer
{
    index++;
    if (index>=imageList.count) {
        index=0;
    }
    [self changeImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

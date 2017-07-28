# VKSamplePicture
### A small class that can get the sample of an image quickly.

---
### Usage
##### Step1. alloc and init the helper class.
	[[VKSamplePicture alloc]init];
##### Step2. Setup the image;
	@property(nonatomic,assign)UIImage* originalImage;
##### Step3. Give the sample rate
	-(void)processSampleSize:(int)width AndHeight:(int)height;
##### Step4. Now you can fetch the color for a specific position
	-(UIColor*)colorAtX:(int)x_axis andY:(int)y_axis;

---
### Notice 
##### If It will Lead To A Memory Leak
##### Invoke This Mothod Might Help
	-(void)freeMemmory;

---
### Contribution
##### If you find some bugs about it,please let me know, thank you
##### More features will come

---
### Screenshot

![screenshot1](https://raw.githubusercontent.com/VikingWarlock/vikingwarlock.github.io/master/resource/1.png) ![screenshot2](https://raw.githubusercontent.com/VikingWarlock/vikingwarlock.github.io/master/resource/2.png) ![screenshot3](https://raw.githubusercontent.com/VikingWarlock/vikingwarlock.github.io/master/resource/3.png) ![screenshot4](https://raw.githubusercontent.com/VikingWarlock/vikingwarlock.github.io/master/resource/4.png) ![screenshot5](https://raw.githubusercontent.com/VikingWarlock/vikingwarlock.github.io/master/resource/5.png)

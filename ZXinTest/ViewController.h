//
//  ViewController.h
//  ZXinTest
//
//  Created by 陈 鑫琦 on 7/17/16.
//  Copyright © 2016 cxq. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startScan;
- (IBAction)startScanBanner:(id)sender;

@end


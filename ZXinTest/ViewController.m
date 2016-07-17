//
//  ViewController.m
//  ZXinTest
//
//  Created by 陈 鑫琦 on 7/17/16.
//  Copyright © 2016 cxq. All rights reserved.
//

#import "ViewController.h"
#import <ZXingObjC/ZXingObjC.h>

@interface ViewController (){
    UIImagePickerController * mPicker;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mPicker = [[UIImagePickerController alloc] init];
    mPicker.delegate = self;
    mPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    CGImageRef cgRef= chosenImage.CGImage;
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:cgRef];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString *contents = result.text;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"条形码" message:contents preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"条形码" message:@"找不到条形码" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancleAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (IBAction)startScanBanner:(id)sender {
    [self presentViewController:mPicker animated:YES completion:NULL];
}
@end

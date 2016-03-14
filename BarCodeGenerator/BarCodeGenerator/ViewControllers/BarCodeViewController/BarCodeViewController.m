//
//  ViewController.m
//  BarCodeGenerator
//
//  Created by Panda, Debasish on 13/03/16.
//  Copyright © 2016 Panda, Debasish. All rights reserved.
//

#import "BarCodeViewController.h"
#import "BarcodeGenerationClass.h"
#import "ConstantsEnums.h"

@interface BarCodeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *barcodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *generateBarcodeButton;

@property (weak, nonatomic) IBOutlet UIImageView *barcodeImageView;

@end

@implementation BarCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)generateBarcodeButonClicked:(id)sender {
    if (self.barcodeTextField.text.length)
    {
        UIImage *generatedBarImage = [BarcodeGenerationClass returnBarcodeImageForBarcodeFormat:kUpcaBarcode forBarcodeString:self.barcodeTextField.text forSize:self.barcodeImageView.frame.size];
        
        if (generatedBarImage != nil)
        {
            [self.barcodeImageView setImage:generatedBarImage];
        }
        else
        {
            UIAlertView *barAlert = [[UIAlertView alloc]initWithTitle:@"Invalid Text" message:@"Please enter a valid text." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [barAlert show];
        }
    }
    else
    {
        UIAlertView *barAlert = [[UIAlertView alloc]initWithTitle:@"Invalid Text" message:@"Please enter a valid text." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [barAlert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // test comment
    // Dispose of any resources that can be recreated.
}

@end

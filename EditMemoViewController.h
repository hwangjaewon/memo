//
//  EditMemoViewController.h
//  example7
//
//  Created by smart on 15. 5. 21..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface EditMemoViewController : UIViewController
{
    ViewController *viewController;
}
@property (strong, nonatomic) NSMutableArray *receivedMemo;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBtn;
@property (strong, nonatomic) IBOutlet UILabel *dateTextField;
@property (strong, nonatomic) IBOutlet UITextView *bodyText;

- (IBAction)saveBtn:(id)sender;

@end

//
//  AddMemoViewController.m
//  example7
//
//  Created by smart on 15. 5. 19..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import "AddMemoViewController.h"
#import "ViewController.h"
#import "DBInterface.h"

@interface AddMemoViewController ()

@end

@implementation AddMemoViewController
@synthesize titleTextField,bodyTextField;

//컨트롤러를 생성,할당한 후 딱 한 번만 호출된다.
- (void)viewDidLoad
{
    NSLog(@"%s",__FUNCTION__);
    self.navigationItem.title = @"메모 추가";
    viewController = [[ViewController alloc]init];
    [self.navigationItem setRightBarButtonItem:self.saveBtn];
    [self.bodyTextField.layer setBorderWidth:1.0];
    [super viewDidLoad];
}


//화면을 호출할 때마다 함수가 호출된다.
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s",__FUNCTION__);
    [self.titleTextField setText:@""];
    [self.bodyTextField setText:@""];
}

//입력한 내용을 memo.db에 저장하고 첫 화면으로 돌아간다.
- (IBAction)saveMemoBtn:(id)sender {
        NSLog(@"%s",__FUNCTION__);
    NSString *get_title = titleTextField.text;
    NSLog(@"title is %@",get_title);
    
    NSString *get_body = bodyTextField.text;
    NSLog(@"body is %@",get_body);
    
    //DB를 오픈한다.
    [[DBInterface sharedDB] openDB];
    
    //DB를 생성한다. 있다면 스킵한다.
     [[DBInterface sharedDB] createTableNamed:@"memo" withField1:@"title" withField2:@"body"];

    //데이터를 삽입한다.
     [[DBInterface sharedDB] insertRecord:@"memo" title:get_title body:get_body];
    
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController pushViewController:viewController animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end

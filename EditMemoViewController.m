//
//  EditMemoViewController.m
//  example7
//
//  Created by smart on 15. 5. 21..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import "EditMemoViewController.h"
#import "ViewController.h"

@interface EditMemoViewController ()

@end

@implementation EditMemoViewController

- (void)viewDidLoad
{
    self.navigationItem.title = @"메모 보기,수정";
    viewController = [[ViewController alloc]init];
    [self.navigationItem setRightBarButtonItem:self.saveBtn];
    [self.bodyText.layer setBorderWidth:1.0];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.titleTextField setText:self.receivedMemo[0]];
    [self.dateTextField setText:self.receivedMemo[2]];
    [self.bodyText setText:self.receivedMemo[1]];
    //1. 텍스트필드를 텍스트뷰로 바꾸고 싶을 경우, 닙 연결을 해주고 디폴트값을 세팅해준다.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//메모 데이터를 업데이트 하는 버튼 클릭 이벤트.
- (IBAction)saveBtn:(id)sender {
    NSString *get_title = self.titleTextField.text;
    
    NSString *get_body = self.bodyText.text;
    
    //DB를 오픈한다.
    [[DBInterface sharedDB] openDB];
    
    //DB를 생성한다. 있다면 스킵한다.
    [[DBInterface sharedDB] createTableNamed:@"memo" withField1:@"title" withField2:@"body"];
    
    //데이터를 업데이트한다.
    [[DBInterface sharedDB] updateRecord:@"memo" title:get_title body:get_body original_title:self.receivedMemo[0]];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end

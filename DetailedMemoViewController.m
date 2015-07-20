//
//  DetailedMemoViewController.m
//  example7
//
//  Created by smart on 15. 5. 20..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import "DetailedMemoViewController.h"
#import "ViewController.h"
#import "DBInterface.h"
#import "EditMemoViewController.h"

@interface DetailedMemoViewController ()
@end

@implementation DetailedMemoViewController

- (void)viewDidLoad
{
    self.navigationItem.title = @"메모 보기";
    viewController = [[ViewController alloc]init];
    editMemoController = [[EditMemoViewController alloc]init];
    NSLog(@"received detail : %@", self.receivedMemo);
    
    [self.titleViewLabel setText:self.receivedMemo[0]];
    [self.contentViewLabel setText:self.receivedMemo[1]];
    [self.dateViewLabel setText:self.receivedMemo[2]];
    
    [self.navigationItem setRightBarButtonItem:self.editBtn];
    [super viewDidLoad];
}
//viewWillAppear (함수)


//메모 수정 버튼 클릭 이벤트.
- (IBAction)gotoEditMemoViewController:(id)sender {
    editMemoController.receivedMemo = self.receivedMemo;
    [self.navigationController pushViewController:editMemoController animated:YES];
    
}

//Back 버튼 클릭 이벤트
-(void)didMoveToParentViewController:(UIViewController *)parent
{
    if(![parent isEqual:self.parentViewController])
    {
        [super viewDidLoad];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

//
//  Makezongzi.m
//  BCBookDW
//
//  Created by sunzhong on 16/3/30.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Makezongzi.h"
@interface Makezongzi()
@end

@implementation Makezongzi
@synthesize user,button1,button2,button3,button4,button5,button6,step1,step2,step3,step4,step5,step6;

User *userMakezongzi;
int step=0;
- (void)viewDidLoad {
    [super viewDidLoad];
    userMakezongzi = self.user;
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userMakezongzi.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"Makezongzi-(void)viewDidLoad"];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    UIImage *image1=[UIImage imageNamed:@"zongzi1"];
    UIImage *image2=[UIImage imageNamed:@"zongzi2"];
    UIImage *image3=[UIImage imageNamed:@"zongzi3"];
    UIImage *image4=[UIImage imageNamed:@"zongzi4"];
    UIImage *image5=[UIImage imageNamed:@"zongzi5"];
    UIImage *image6=[UIImage imageNamed:@"zongzi6"];
    [button1 setBackgroundImage:image1 forState:UIControlStateNormal];
    [button2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [button3 setBackgroundImage:image3 forState:UIControlStateNormal];
    [button4 setBackgroundImage:image4 forState:UIControlStateNormal];
    [button5 setBackgroundImage:image5 forState:UIControlStateNormal];
    [button6 setBackgroundImage:image6 forState:UIControlStateNormal];
    button1.tag=1;
    button2.tag=2;
    button3.tag=3;
    button4.tag=4;
    button5.tag=5;
    button6.tag=6;
    [button1 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button4 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button5 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button6 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
}



//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)btnPressed:(id)sender{
    UIButton* btn = (UIButton*)sender;
    NSLog(@"tag=%d",btn.tag);
    step++;
    NSString *stringstep=[[NSString alloc]init];
    stringstep= [NSString stringWithFormat:@"%d",btn.tag];
    if(step==1) step1.text=stringstep;
    else if(step==2) step2.text=stringstep;
    else if(step==3) step3.text=stringstep;
    else if(step==4) step4.text=stringstep;
    else if(step==5) step5.text=stringstep;
    else if(step==6) step6.text=stringstep;
    else if(step>6) step=0;
}



- (IBAction)finish:(UIButton *)sender {
    if([step1.text isEqualToString:@"1"]&&[step2.text isEqualToString:@"3"]&&[step3.text isEqualToString:@"5"]&&[step4.text isEqualToString:@"2"]&&[step5.text isEqualToString:@"6"]&&[step6.text isEqualToString:@"4"]) {  [self nextpage1];
        
    }
    else {
        [self prompt:@"很抱歉你的制作顺序不正确，请再试试吧！" ];
        step=0;
        step1.text=nil;
        step2.text=nil;
        step3.text=nil;
        step4.text=nil;
        step5.text=nil;
        step6.text=nil;
    }}

//跳转到下一页
-(void)nextpage1{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   Zongzi* zongzi = [mainStoryboard instantiateViewControllerWithIdentifier:@"Zongzi"];
   zongzi.user = userMakezongzi;
    [zongzi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:zongzi animated:YES completion:nil];
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end

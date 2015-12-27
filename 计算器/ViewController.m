//
//  ViewController.m
//  计算器
//
//  Created by myApple on 15/12/26.
//  Copyright © 2015年 myApple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *btnArray;
    NSArray *arr;
    UILabel *label;
    float btnWidth;
    int flag,changeNum;
    double num1,num2,num3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor blackColor];
    arr=@[@"0",@"#",@".",@"=",@"1",@"2",@"3",@"+",@"4",@"5",@"6",@"-",@"7",@"8",@"9",@"x",@"C",@"+/–",@"%",@"÷"];
    
    btnArray=[[NSMutableArray alloc]initWithCapacity:16];
    btnWidth=self.view.frame.size.width/4;
    for (int i=0; i<5; i++) {
        for (int j=0; j<4; j++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            
            if(i==0)
            {
                if(j==0)
                {
                    btn.frame=CGRectMake(j*btnWidth, self.view.frame.size.height-(i+1)*btnWidth, (btnWidth*2)-1, btnWidth-1);
                }
                else
                {
                    if (j==1) {
                        btn.frame=CGRectMake(j*(self.view.frame.size.width-btnWidth-btnWidth), self.view.frame.size.height-(i+1)*btnWidth, btnWidth-1, btnWidth-1);
                        btn.titleLabel.textAlignment=NSTextAlignmentLeft;
                    }
                    else
                    {
                        btn.frame=CGRectMake(j*btnWidth, self.view.frame.size.height-(i+1)*btnWidth, btnWidth-1, btnWidth-1);
                    }
                    
                }
            }
            else
            {
                btn.frame=CGRectMake(j*btnWidth, self.view.frame.size.height-(i+1)*btnWidth, btnWidth-1, btnWidth-1);
            }
            
            
            if(j==3)
            {
                btn.backgroundColor=[UIColor orangeColor];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else
            {
                 btn.backgroundColor=[UIColor colorWithRed:217/255.0 green:218/255.0 blue:220/255.0 alpha:1];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            btn.titleLabel.font=[UIFont fontWithName:@"Heiti SC" size:30];
            
            [btnArray addObject:btn];
            [self.view addSubview:btn];
        }
    }
    
    for (int i=0; i<arr.count; i++) {
        [[btnArray objectAtIndex:i] setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
    }

    label=[[UILabel alloc]initWithFrame:CGRectMake(15, self.view.frame.size.height-btnWidth*6-5, self.view.frame.size.width-15*2,btnWidth)];
    label.backgroundColor=[UIColor blackColor];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont fontWithName:@"Heiti SC" size:72];
    label.text=@"1";
    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:label];
    
    for (int i=0; i<btnArray.count; i++) {
        [[btnArray objectAtIndex:i] addTarget:self action:@selector(btnTextContent:) forControlEvents:UIControlEventTouchDown];
    }
}

-(void)labelContent:(id)sender
{
    
}

-(void)btnTextContent:(UIButton *)sender
{
    
    if ([sender.titleLabel.text isEqualToString:@"+"]) {
        num1=label.text.doubleValue;
        NSLog(@"%g",num1);
        flag=1;
        changeNum=1;
    }
    else if ([sender.titleLabel.text isEqualToString:@"-"]) {
        num1=label.text.doubleValue;
        NSLog(@"%g",num1);
        label.text=@"";
        flag=2;
        changeNum=1;
    }
    else if ([sender.titleLabel.text isEqualToString:@"x"]) {
        num1=label.text.doubleValue;
        NSLog(@"%g",num1);
        label.text=@"";
        flag=3;
        changeNum=1;
    }
    else  if ([sender.titleLabel.text isEqualToString:@"÷"]) {
        num1=label.text.doubleValue;
        NSLog(@"%g",num1);
        label.text=@"";
        flag=4;
        changeNum=1;
    }
    else  if ([sender.titleLabel.text isEqualToString:@"C"]) {
        label.text=@"0";
        num1=0;
        num2=0;
        num3=0;
        changeNum=1;
    }
    else if ([sender.titleLabel.text isEqualToString:@"="]) {
        
        num2=label.text.doubleValue;
        NSLog(@"%g,%g",num1,num2);
        
        switch (flag) {
            case 0:
                num3=num2;
                break;
            case 1:
                num3=num1+num2;
                break;
            case 2:
                num3=num1-num2;
                break;
            case 3:
                num3=num1*num2;
                break;
            case 4:
                num3=num1/num2;
                break;
            default:
                break;
        }
        
         NSLog(@"%g",num3);
        label.text=[NSString stringWithFormat:@"%g",num3];
        changeNum=1;
    }
    else {
        if(changeNum!=0)
        {
            label.text=@"";
        }
        label.text= [label.text stringByAppendingString:sender.titleLabel.text];
        changeNum=0;
    }


    

    
    
    

   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

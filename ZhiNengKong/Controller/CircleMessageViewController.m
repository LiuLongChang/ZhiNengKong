//
//  CircleMessageViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/24.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "CircleMessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageReplyTableViewCell.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
#import "GetTopCircleMessagesModel.h"
#import "UserInfoModel.h"
#import "EqInfoModel.h"
#import "CircleInfoViewController.h"
#import "DBHelper.h"

@interface CircleMessageViewController ()
{
    NSMutableArray *_messages;
    NSDate *_updateTime;
    NSMutableArray *_equips;
    NSMutableArray *_users;
    NSMutableDictionary *_equipDic;
    NSDateFormatter *_longDateFormatter;
    NSMutableArray *_atEquips;
    NSTimer *_timer;
    NSMutableDictionary *_eqImageDic;
    NSMutableDictionary *_userImageDic;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation CircleMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UIImage *image = [UIImage imageNamed:@"circle_edit"];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(viewCircle) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
    
    self.title = _circle.name;
    _footerView.layer.borderColor = [UIColor colorWithRed:195.0/255.0 green:195.0/255.0 blue:197.0/255.0 alpha:1.0].CGColor;
    _footerView.layer.borderWidth = 0.5f;
    
    _messageTextView.layer.cornerRadius = 5.0f;
    _messageTextView.layer.borderWidth = 0.5f;
    _messageTextView.layer.borderColor =[UIColor colorWithRed:195.0/255.0 green:195.0/255.0 blue:197.0/255.0 alpha:1.0].CGColor;
    _messageTextView.delegate = self;
    _messageTextView.font = [UIFont systemFontOfSize:17.0f];
    
    [_sendButton setTitleColor:[UIColor colorWithRed:110.0/255.0 green:165.0/255.0 blue:234.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    _sendButton.enabled = NO;
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    
    [self.view addGestureRecognizer:singleTap];
    _messages = [NSMutableArray array];
    [self loadDetail];
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_timer) {
        [_timer invalidate];
    }
}

-(void)viewCircle{
    [self performSegueWithIdentifier:@"info" sender:self];
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    NSDictionary* info = [aNotification userInfo];
    CGRect kb = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.view.frame = CGRectOffset(mainWindow.frame, 0, -kb.size.height);
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    CGFloat topHeight =self.navigationController.navigationBar.bounds.size.height +
    [UIApplication sharedApplication].statusBarFrame.size.height;
    self.view.frame = CGRectMake(0, topHeight, self.view.frame.size.width, mainWindow.frame.size.height - topHeight);
    
    if (_messages.count > 0) {
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([@"@" isEqualToString:text]) {
        [self performSegueWithIdentifier:@"at" sender:self];
        return NO;
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    [self resizeMessageTextView];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([@"at" isEqualToString:segue.identifier]) {
        UINavigationController *navVC = segue.destinationViewController;
        AtEquipViewController *vc = navVC.viewControllers[0];
        vc.atEqiupDelegate = self;
        vc.circleId = _circle.circleID;
    }
    
    if ([@"info" isEqualToString:segue.identifier]) {
        CircleInfoViewController *vc = segue.destinationViewController;
        vc.circleId = _circle.circleID;
        vc.circleName = _circle.name;
        vc.isCreator = [_circle.isCreater intValue] == 1;
    }
}

-(void)AtEquip:(NSString *)eqID withName:(NSString *)eqName{
    [_messageTextView insertText:[NSString stringWithFormat:@"@%@ ",eqName]];
}

-(void)pickAtEquipIds{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"@([@\\S]+)" options:0 error:NULL];
    NSArray *matches = [regex matchesInString:_messageTextView.text options:0 range:NSMakeRange(0, _messageTextView.text.length)];
    
    _atEquips = [NSMutableArray array];
    
    for (NSTextCheckingResult *match in matches) {
        NSRange nameRange = [match rangeAtIndex:1];
        NSString *name = [_messageTextView.text substringWithRange:nameRange];
        
        if (_equipDic[name]) {
            [_atEquips addObject:_equipDic[name]];
        }
    }
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [_messageTextView endEditing:YES];
}
- (IBAction)sendButtonClick:(id)sender {
    _sendButton.enabled = NO;
    [self pickAtEquipIds];
    NSNumber *timestamp = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    NSLog(@"发送消息：%@",timestamp);
    [CloudBL SendCircleMessages_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] CircleID:_circle.circleID EqIDs:_atEquips Text:_messageTextView.text TS:timestamp success:^{
        _messageTextView.text = @"";
        [self resizeMessageTextView];
        [_messageTextView endEditing:YES];
        [self loadMessageData];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
        _sendButton.enabled = YES;
    }];
}

-(void)resizeMessageTextView{
    _sendButton.enabled = ![@"" isEqualToString:_messageTextView.text];
    
    CGRect rect = [_messageTextView.text boundingRectWithSize:_messageTextView.contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]} context:nil];
    
    if (rect.size.height <= 17.0f * 5) {
        [_messageTextView sizeToFit];
        _messageTextView.frame = CGRectMake(_messageTextView.frame.origin.x, _messageTextView.frame.origin.y, self.view.frame.size.width - 30.0f - _sendButton.frame.size.width, _messageTextView.frame.size.height);
        _footerHeightConstraint.constant = _messageTextView.frame.size.height + 20.0f;
    }
}

-(void)loadOldMessage{
    
    _messages = [DBHelper getCircleMessagesWithCircleId:_circle.circleID];
    
    _updateTime = [NSDate date];
    if (_messages.count > 0) {
        Message *msg = _messages[_messages.count - 1];
        _updateTime = [NSDate dateWithTimeIntervalSince1970:[msg.time doubleValue]];
        
        [_tableView reloadData];
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(loadMessageData) userInfo:nil repeats:YES];
}

-(void)loadMessageData{
    
    NSNumber *timestamp = [NSNumber numberWithInt:0];
    
    if (_updateTime) {
        timestamp = [NSNumber numberWithDouble:[_updateTime timeIntervalSince1970]];
    }
    
    NSLog(@"接收消息：%@",timestamp);
    
    [CloudBL GetTopCircleMessages_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] CircleID:_circle.circleID TS:timestamp PageSize:[NSNumber numberWithInt:10] success:^(NSNumber *TopTS, NSArray *Messages, NSArray *MessageUser, NSArray *MessageEquip) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            double t = [[NSDate date] timeIntervalSince1970];
            
            if ([TopTS intValue] != 0 && [TopTS doubleValue] < t){
                t = [TopTS doubleValue];
            }

            
            _updateTime = [NSDate dateWithTimeIntervalSince1970:t];
            
            if (Messages && Messages.count > 0) {
                
                NSArray *sortedMessages = [Messages sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    NSNumber *num1 = obj1[@"Time"];
                    NSNumber *num2 = obj2[@"Time"];
                    return [num1 compare:num2];
                }];
                
                NSMutableArray *paths = [NSMutableArray array];
                for (int i = 0; i< sortedMessages.count; i++) {
                    Message *msg = [Message modelObjectWithDictionary:sortedMessages[i]];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"iD == %@",msg.iD];
                    NSArray *result = [_messages filteredArrayUsingPredicate:predicate];
                    
                    if (result.count == 0) {
                        [_messages addObject:msg];
                        
                        [DBHelper setCircleMessageWithMsgId:msg.iD Direction:[msg.direction intValue] CircleId:_circle.circleID UserId:msg.userID EuipId:msg.equipID Text:msg.text Time:[msg.time longLongValue]];
                        
                        NSIndexPath *ipath = [NSIndexPath indexPathForRow:_messages.count - 1 inSection:0];
                        [paths addObject:ipath];
                    }
                }
                
                if (paths.count > 0) {
                    [_tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
                    [_tableView scrollToRowAtIndexPath:paths[paths.count - 1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }
            }
        });
        
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(void)loadDetail{
    _equips = [NSMutableArray array];
    _users = [NSMutableArray array];
    _equipDic = [NSMutableDictionary dictionary];
    _eqImageDic = [NSMutableDictionary dictionary];
    _userImageDic = [NSMutableDictionary dictionary];
    
    [CloudBL GetCircleDetail_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] CircleID:_circle.circleID success:^(NSArray *EqInfo, NSArray *UserInfo) {
        
        for (NSDictionary *dic in EqInfo) {
            EqInfoModel *equip = [EqInfoModel modelObjectWithDictionary:dic];
            
            UIImage *img = [UIImage imageNamed:@"mysheb_icon_1"];
            
            if (![@"" isEqualToString:equip.eqAvatar] && equip.eqAvatar!=nil) {
                
                img = [Utils_UserDefaultInfo GetAvatarWithUrl:equip.eqAvatar image:nil];
                
                if (img == nil) {
                    img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:equip.eqAvatar]]];
                    [Utils_UserDefaultInfo SetAvatarWithUrl:equip.eqAvatar image:img];
                }
            }
            
            equip.image = img;
            
            [_eqImageDic setObject:img forKey:equip.uniCode];
            
            [_equips addObject:equip];
            [_equipDic setObject:equip.uniCode forKey:equip.eqName];
        }
        
        for (NSDictionary *dic in UserInfo) {
            UserInfoModel *user = [UserInfoModel modelObjectWithDictionary:dic];
            
            UIImage *img = [UIImage imageNamed:@"default"];
            
            if (![@"" isEqualToString:user.avatar] && user.avatar!=nil) {
                img = [Utils_UserDefaultInfo GetAvatarWithUrl:user.avatar image:nil];
                
                if (img == nil) {
                    img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.avatar]]];
                    [Utils_UserDefaultInfo SetAvatarWithUrl:user.avatar image:img];
                }
                
            }
            
            user.image = img;
            [_userImageDic setObject:img forKey:user.userID];
            [_users addObject:user];
        }
        
        
        [self loadOldMessage];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Message *message = _messages[indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.timeStyle = NSDateFormatterShortStyle;;
    
    NSDate *sendDate = [NSDate dateWithTimeIntervalSince1970:[message.time doubleValue]];
    NSDate *now = [NSDate date];
    
    NSString *sendTimeStr = [formatter stringFromDate:sendDate];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *sendComps = [cal components:kCFCalendarUnitDay|kCFCalendarUnitMonth|kCFCalendarUnitYear|kCFCalendarUnitWeekday|kCFCalendarUnitWeekOfMonth fromDate:sendDate];
    NSDateComponents *nowComps = [cal components:kCFCalendarUnitDay|kCFCalendarUnitMonth|kCFCalendarUnitYear|kCFCalendarUnitWeekday|kCFCalendarUnitWeekOfMonth fromDate:now];
    
    
    if (sendComps.day != nowComps.day && sendComps.weekOfMonth == nowComps.weekOfMonth && sendComps.month == nowComps.month && sendComps.year == nowComps.year) {
        NSString *weekDayStr = @"";
        switch (sendComps.weekday) {
            case 1:
                weekDayStr = @"星期日";
                break;
            case 2:
                weekDayStr = @"星期一";
                break;
            case 3:
                weekDayStr = @"星期二";
                break;
            case 4:
                weekDayStr = @"星期三";
                break;
            case 5:
                weekDayStr = @"星期四";
                break;
            case 6:
                weekDayStr = @"星期五";
                break;
            case 7:
                weekDayStr = @"星期六";
                break;
            default:
                break;
        }
        
        sendTimeStr = [NSString stringWithFormat:@"%@ %@",weekDayStr,sendTimeStr];
    }else if (!(sendComps.day == nowComps.day && sendComps.month == nowComps.month && sendComps.year == nowComps.year)){
        formatter.dateFormat = @"yyyy-MM-dd";
        sendTimeStr = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:sendDate],sendTimeStr];
    }
    
    if ([message.direction intValue] == 2) {   //设备发送向用户
        MessageTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"MessageTableViewCell_%ul",indexPath.row]];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        
        cell.messageColor = [UIColor colorWithRed:143.0/255.0 green:188.0/255.0 blue:139.0/255.0 alpha:1.0f];
        cell.fontColor = [UIColor whiteColor];
        
        cell.message = message.text;
        cell.time = sendTimeStr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.headImageView.image = _eqImageDic[message.equipID];
        return cell;
    }else{
        
        if ([message.userID isEqualToString:[Utils_UserDefaultInfo GetUserIdentifer:nil]]) {
            MessageReplyTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"MessageReplyTableViewCell_%ul",indexPath.row]];
            
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageReplyTableViewCell" owner:self options:nil] objectAtIndex:0];
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1.0f)];
                view.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:view];
            }
            
            cell.fontColor = [UIColor whiteColor];
            
            //本人发的
            cell.messageColor = [UIColor colorWithRed:110.0/255.0 green:165.0/255.0 blue:234.0/255.0 alpha:1.0f];
            
            cell.headImageView.image = _userImageDic[message.userID];
            cell.message = message.text;
            cell.time = sendTimeStr;
            
            return cell;
        }else{
            
            MessageTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"MessageTableViewCell_%ul",indexPath.row]];
            
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil] objectAtIndex:0];
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1.0f)];
                view.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:view];
            }
            
            cell.fontColor = [UIColor whiteColor];
            
            //非本人发的
            cell.messageColor = [UIColor colorWithRed:174.0/255.0 green:157.0/255.0 blue:70.0/255.0 alpha:1.0f];
            
            cell.headImageView.image = _userImageDic[message.userID];
            cell.message = message.text;
            cell.time = sendTimeStr;
            
            return cell;
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //消息框宽度（1/2cell宽）
    CGFloat msgBoxWidth = self.view.frame.size.width / 2.0;
    CGFloat msgInsetX = 10.0f;
    CGFloat msgInsetY = 10.0f;
    
    NSDictionary *textAttrDic = @{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]};
    
    Message *message = _messages[indexPath.row];
    CGSize messageSize = [message.text boundingRectWithSize:CGSizeMake(msgBoxWidth - msgInsetX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrDic context:nil].size;
    
    CGFloat height = messageSize.height + (msgInsetY * 2) + 20.0f;
    
    return height<70.0f?70.0f:height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

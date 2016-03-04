//
//  EquipMesssageViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/6.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "EquipMesssageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageReplyTableViewCell.h"
#import "MessageHeaderTableViewCell.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
#import "Command.h"
#import "CommandUser.h"
#import "DBHelper.h"

@interface EquipMesssageViewController ()
{
    NSMutableArray *_messages;
    NSDate *_updateTime;
    NSTimer *_timer;
    NSArray *_users;
    NSMutableDictionary *_userDic;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footerHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@end

@implementation EquipMesssageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"MessageReplyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageReplyTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"MessageHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageHeaderTableViewCell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.separatorColor = [UIColor clearColor];
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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = _equip.equipName;
    _messages = [NSMutableArray array];
    
    [self loadOldMessage];
//    _updateTime = [NSDate date];
//    [self loadMessageData];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(loadMessageData) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_timer) {
        [_timer invalidate];
    }
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
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
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    
}

-(void)textViewDidChange:(UITextView *)textView{
    [self resizeMessageTextView];
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

- (IBAction)sendButtonClick:(id)sender {
    _sendButton.enabled = NO;
    [CloudBL SendCommand_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] EqID:_equip.eqID Text:_messageTextView.text TS:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] success:^{
        _messageTextView.text = @"";
        [self resizeMessageTextView];
        [_messageTextView endEditing:YES];
        _updateTime = [NSDate date];
        [self loadMessageData];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
        _sendButton.enabled = YES;
    }];
}

-(void)loadOldMessage{
    
    _messages = [DBHelper getEQuipMessagesWithEquipId:_equip.eqID];
    
    _updateTime = [NSDate date];
    if (_messages.count > 0) {
        Command *msg = _messages[_messages.count - 1];
        _updateTime = [NSDate dateWithTimeIntervalSince1970:[msg.time doubleValue]];
        
        [_tableView reloadData];
    }
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(loadMessageData) userInfo:nil repeats:YES];
}

-(void)loadMessageData{
    
    NSNumber *timestamp = [NSNumber numberWithInt:0];
    
    if (_updateTime) {
        timestamp = [NSNumber numberWithDouble:[_updateTime timeIntervalSince1970] * 1000];
    }
    
    NSLog(@"%@",timestamp);
    
    [CloudBL GetTopCommands_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] EqID:_equip.eqID TS:timestamp PageSize:[NSNumber numberWithInt:10] success:^(NSNumber *RecentTS, NSNumber *OldTS, NSNumber *LeftNumber, NSArray *Commands, NSArray *Users) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            double timestamp = [[NSDate date] timeIntervalSince1970];
            
            if ([RecentTS intValue] != 0) {
                timestamp = [RecentTS doubleValue]/1000;
            }
            
            _updateTime = [NSDate dateWithTimeIntervalSince1970:timestamp];
            
            for (NSDictionary *dic in Users) {
                CommandUser *userInfo = [[CommandUser alloc] initWithDictionary:dic];
                
                UIImage *img = [UIImage imageNamed:@"default"];
                
                if (![@"" isEqualToString:userInfo.avatar] && userInfo.avatar!=nil) {
                    
                    img = [Utils_UserDefaultInfo GetAvatarWithUrl:userInfo.avatar image:nil];
                    
                    if (img == nil) {
                        img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userInfo.avatar]]];
                        [Utils_UserDefaultInfo SetAvatarWithUrl:userInfo.avatar image:img];
                    }
                }
                
                userInfo.image = img;
                [_userDic setObject:userInfo forKey:userInfo.userID];
            }
            
            if (Commands && Commands.count > 0) {
                NSMutableArray *paths = [NSMutableArray array];
                
                NSArray *sortedCommands = [Commands sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    NSNumber *num1 = obj1[@"Time"];
                    NSNumber *num2 = obj2[@"Time"];
                    return [num1 compare:num2];
                }];
                
                for (int i = 0; i< sortedCommands.count; i++) {
                    Command *cmd = [Command modelObjectWithDictionary:sortedCommands[i]];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"iD == %@",cmd.iD];
                    NSArray *result = [_messages filteredArrayUsingPredicate:predicate];
                    
                    if (result.count == 0) {
                        [_messages addObject:cmd];
                        
                        [DBHelper setEquipMessageWithMsgId:cmd.iD Direction:[cmd.direction intValue] UserId:[cmd.userID intValue] EuipId:_equip.eqID Text:cmd.text Time:[cmd.time longLongValue]];
                        
                        NSIndexPath *ipath = [NSIndexPath indexPathForRow:_messages.count - 1 inSection:1];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MessageHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageHeaderTableViewCell"];
        cell.msgButton.layer.borderColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0f].CGColor;
        cell.msgButton.layer.borderWidth = 5.0f;
        return cell;
    }
    
    Command *message = _messages[indexPath.row];
    NSString *userId = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.timeStyle = NSDateFormatterShortStyle;;
    
    NSDate *sendDate = [NSDate dateWithTimeIntervalSince1970:[message.time doubleValue]];
    NSDate *now = [NSDate date];
    
    NSString *sendTimeStr = [formatter stringFromDate:sendDate];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *sendComps = [cal components:kCFCalendarUnitDay|kCFCalendarUnitMonth|kCFCalendarUnitYear|kCFCalendarUnitWeekday fromDate:sendDate];
    NSDateComponents *nowComps = [cal components:kCFCalendarUnitDay|kCFCalendarUnitMonth|kCFCalendarUnitYear fromDate:now];
    
    
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
    
    if (message.userID) {
        userId = [NSString stringWithFormat:@"%@",message.userID];
    }
    
    
    if ([message.direction intValue] == 2) {   //设备发送向用户
        MessageTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"MessageTableViewCell_%ul",indexPath.row]];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil] objectAtIndex:0];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1.0f)];
            view.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:view];
        }
        
        cell.messageColor = [UIColor colorWithRed:143.0/255.0 green:188.0/255.0 blue:139.0/255.0 alpha:1.0f];
        cell.fontColor = [UIColor whiteColor];
        
        cell.message = message.text;
        cell.time = sendTimeStr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.headImageView.image = _equip.image;
        return cell;
    }else{
//        CommandUser *user = _userDic[message.userID];
        
//        if ([userId isEqualToString:[Utils_UserDefaultInfo GetUserIdentifer:nil]]) {
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
            
            cell.headImageView.image = [Utils_UserDefaultInfo GetUserLogo:[UIImage imageNamed:@"default"]];
            cell.message = message.text;
            cell.time = sendTimeStr;
        
        
        
            return cell;
//        }else{
//            
//            MessageTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"MessageTableViewCell_%ul",indexPath.row]];
//            
//            if (!cell) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil] objectAtIndex:0];
//            }
//            
//            cell.fontColor = [UIColor whiteColor];
//            
//            //非本人发的
//            cell.messageColor = [UIColor colorWithRed:174.0/255.0 green:157.0/255.0 blue:70.0/255.0 alpha:1.0f];
//            
//            cell.headImageView.image = user?user.image:[UIImage imageNamed:@"default"];
//            cell.message = message.text;
//            cell.time = sendTimeStr;
//            
//            return cell;
//        }
    }
}

-(void)detail:(id) sender
{
    [self performSegueWithIdentifier:@"detail" sender:self];
}

-(void)profile:(id) sender
{
    [self performSegueWithIdentifier:@"profile" sender:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    if (section == 0) {
//        MessageHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageHeaderTableViewCell"];
//        cell.msgButton.layer.borderColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0f].CGColor;
//        cell.msgButton.layer.borderWidth = 5.0f;
//        return cell;
//    }else{
//        UITableViewCell *header = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
//        
////        NSString *headerString = @"2015-12-12";
////        
////        CGSize textSize = [headerString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]}];
////        
////        CGRect textRect = CGRectMake((header.contentView.frame.size.width - textSize.width) / 2.0f, (header.contentView.frame.size.height - textSize.height) / 2.0f, textSize.width, textSize.height);
////        
////        UILabel *textLabel = [[UILabel alloc] initWithFrame:textRect];
////        [textLabel setTextColor:[UIColor lightGrayColor]];
////        [textLabel setFont:[UIFont systemFontOfSize:13.0f]];
////        textLabel.text = headerString;
////        [header.contentView addSubview:textLabel];
//        
//        return header;
//    }
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0?1:_messages.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 50.0f;
    }else{
        
        //消息框宽度（1/2cell宽）
        CGFloat msgBoxWidth = self.view.frame.size.width / 2.0f;
        CGFloat msgInsetX = 10.0f;
        CGFloat msgInsetY = 10.0f;
        
        NSDictionary *textAttrDic = @{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]};
        
        Message *message = _messages[indexPath.row];
        CGSize messageSize = [message.text boundingRectWithSize:CGSizeMake(msgBoxWidth - msgInsetX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrDic context:nil].size;
        
        CGFloat height = messageSize.height + (msgInsetY * 2.0f) + 20.0f;
        
        
        if (indexPath.row == _messages.count - 1) {
            
//            height = 100.74f;
        }
        
        return height<70.0f?70.0f:height;
    }
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

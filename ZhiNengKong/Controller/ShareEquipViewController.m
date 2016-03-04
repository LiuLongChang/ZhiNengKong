//
//  ShareEquipViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/5.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "ShareEquipViewController.h"
#import "ContactTableViewCell.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ContactsData.h"
#import "EquipViewController.h"
#import "ContactsViewController.h"

@interface ShareEquipViewController ()
{
    NSMutableArray *_allPerson;
    NSMutableArray *_displayPersonArr;
    NSString *_regex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ShareEquipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"ContactTableViewCell" bundle:nil] forCellReuseIdentifier:@"ContactTableViewCell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
    
    _allPerson = [self getAllContacts];
    
    _searchBar.delegate = self;
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    
    [self.view addGestureRecognizer:singleTap];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_searchBar resignFirstResponder];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self loadData:searchText];
}

-(void)loadData:(NSString *)keyword{
    
    if ([@"" isEqualToString:keyword]) {
        _displayPersonArr = [NSMutableArray array];
    }else{
        _regex = @"^";
        
        for (int i = 0 ; i< [keyword length]; i++) {
            _regex = [_regex stringByAppendingFormat:@"%c[-]?",[keyword characterAtIndex:i]];
        }
        
        _regex = [_regex stringByAppendingFormat:@".*"];
        
        NSPredicate * myPredicate = [NSPredicate predicateWithFormat:@"ANY %K MATCHES %@",@"numbers",_regex];
        _displayPersonArr = [NSMutableArray arrayWithArray:[_allPerson filteredArrayUsingPredicate:myPredicate]];
    }
    [_tableView reloadData];
}

-(BOOL)accessAddressBook{
    CFErrorRef *error = nil;
    
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL accessGranted = NO;
    if (&ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    return accessGranted;
}

-(NSMutableArray *)getAllContacts {
    
    if (![self accessAddressBook]) {
        return [NSMutableArray array];
    }
    
    CFErrorRef *error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    ABRecordRef source = ABAddressBookCopyDefaultSource(addressBook);
    CFArrayRef allPeople = (ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, kABPersonSortByFirstName));
    //CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    CFIndex nPeople = CFArrayGetCount(allPeople); // bugfix who synced contacts with facebook
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:nPeople];
    
    if (!allPeople || !nPeople) {
        NSLog(@"people nil");
    }
    
    
    for (int i = 0; i < nPeople; i++) {
        
        @autoreleasepool {
            
            //data model
            ContactsData *contacts = [ContactsData new];
            
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            
            //get First Name
            CFStringRef firstName = (CFStringRef)ABRecordCopyValue(person,kABPersonFirstNameProperty);
            contacts.firstNames = [(__bridge NSString*)firstName copy];
            
            if (firstName != NULL) {
                CFRelease(firstName);
            }
            
            
            //get Last Name
            CFStringRef lastName = (CFStringRef)ABRecordCopyValue(person,kABPersonLastNameProperty);
            contacts.lastNames = [(__bridge NSString*)lastName copy];
            
            if (lastName != NULL) {
                CFRelease(lastName);
            }
            
            
            if (!contacts.firstNames) {
                contacts.firstNames = @"";
            }
            
            if (!contacts.lastNames) {
                contacts.lastNames = @"";
            }
            
            
            
            contacts.contactId = ABRecordGetRecordID(person);
            //append first name and last name
            contacts.fullName = [NSString stringWithFormat:@"%@ %@", contacts.firstNames, contacts.lastNames];
            
            
            // get contacts picture, if pic doesn't exists, show standart one
            CFDataRef imgData = ABPersonCopyImageData(person);
            NSData *imageData = (__bridge NSData *)imgData;
            contacts.image = [UIImage imageWithData:imageData];
            
            if (imgData != NULL) {
                CFRelease(imgData);
            }
            
            if (!contacts.image) {
                contacts.image = [UIImage imageNamed:@"ziliao_tou"];
            }
            
            
            //get Phone Numbers
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
            ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            for(CFIndex i=0; i<ABMultiValueGetCount(multiPhones); i++) {
                @autoreleasepool {
                    CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
                    NSString *phoneNumber = CFBridgingRelease(phoneNumberRef);
                    if (phoneNumber != nil)[phoneNumbers addObject:phoneNumber];
                    //NSLog(@"All numbers %@", phoneNumbers);
                }
            }
            
            if (multiPhones != NULL) {
                CFRelease(multiPhones);
            }
            
            [contacts setNumbers:phoneNumbers];
            
            //get Contact email
            NSMutableArray *contactEmails = [NSMutableArray new];
            ABMultiValueRef multiEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            for (CFIndex i=0; i<ABMultiValueGetCount(multiEmails); i++) {
                @autoreleasepool {
                    CFStringRef contactEmailRef = ABMultiValueCopyValueAtIndex(multiEmails, i);
                    NSString *contactEmail = CFBridgingRelease(contactEmailRef);
                    if (contactEmail != nil)[contactEmails addObject:contactEmail];
                    // NSLog(@"All emails are:%@", contactEmails);
                }
            }
            
            if (multiPhones != NULL) {
                CFRelease(multiEmails);
            }
            
            [contacts setEmails:contactEmails];
            
            [items addObject:contacts];
            
#ifdef DEBUG
            //NSLog(@"Person is: %@", contacts.firstNames);
            //NSLog(@"Phones are: %@", contacts.numbers);
            //NSLog(@"Email is:%@", contacts.emails);
#endif
            
        }
    } //autoreleasepool
    CFRelease(allPeople);
    CFRelease(addressBook);
    CFRelease(source);
    return items;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addressButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"contacts" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ContactsViewController *vc = segue.destinationViewController;
    vc.selectedEqid = _selectedEqid;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactTableViewCell" forIndexPath:indexPath];
    
    ContactsData *person = _displayPersonArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",person.lastNames,person.firstNames];
    
    if (person.numbers.count > 0) {
        NSPredicate * myPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",_regex];
        NSString *phoneNumber = [person.numbers filteredArrayUsingPredicate:myPredicate][0];
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
        cell.phoneLabel.text = phoneNumber;
        person.numbers[0] = cell.phoneLabel.text;
    }
    
    cell.headerImageView.image = person.image;
    cell.headerImageView.layer.cornerRadius = 25.0f;
    cell.headerImageView.layer.masksToBounds = YES;
    [cell.addButton addTarget:self action:@selector(shareToPerson:) forControlEvents:UIControlEventTouchUpInside];
    cell.addButton.tag = indexPath.row;
    return cell;
}

-(void)shareToPerson:(UIButton *)button{
    EquipViewController *equipVC = (EquipViewController *)self.navigationController.viewControllers[0];
    equipVC.sharedPerson = _displayPersonArr[button.tag];
    equipVC.selectedEqid = _selectedEqid;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _displayPersonArr.count;
}

@end

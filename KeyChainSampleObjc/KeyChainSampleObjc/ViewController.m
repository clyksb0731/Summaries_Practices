//
//  ViewController.m
//  KeyChainSampleObjc
//
//  Created by Yongseok Choi on 2021/01/24.
//

#import "ViewController.h"
#import <Security/Security.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cUUIDLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputUUIDTextField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)saveUUID:(UIButton *)sender {
    NSData *data = [self.inputUUIDTextField.text dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    
    NSDictionary *query = @{
        (NSString *)kSecClass:(NSString *)kSecClassGenericPassword,
        (NSString *)kSecAttrService:@"KeyChainSamleObjc",
        (NSString *)kSecAttrAccount:@"idUUID",
        (NSString *)kSecValueData:data,
        (NSString *)kSecAttrAccessible:(NSString *)kSecAttrAccessibleAfterFirstUnlock
    };
    
    NSMutableDictionary *saveQuery = [[NSMutableDictionary alloc] initWithDictionary:query];
    [saveQuery setObject:data forKey:(NSString *)kSecValueData];
    
    SecItemDelete((CFDictionaryRef)saveQuery);
    
    OSStatus status = SecItemAdd((CFDictionaryRef)saveQuery, nil);
    
    if (status==errSecSuccess) {
        NSLog(@"Saving Succeeded");
    }
}

- (IBAction)loadUUID:(id)sender {
    NSDictionary *query = @{
        (NSString *)kSecClass:(NSString *)kSecClassGenericPassword,
        (NSString *)kSecAttrService:@"KeyChainSamleObjc",
        (NSString *)kSecReturnData:@YES,
        (NSString *)kSecMatchLimit:(NSString *)kSecMatchLimitOne,
        (NSString *)kSecAttrAccessible:(NSString *)kSecAttrAccessibleAfterFirstUnlock
    };
    
    NSMutableDictionary *loadQuery = [[NSMutableDictionary alloc] initWithDictionary:query];
    [loadQuery setObject:@"idUUID" forKey:(NSString *)kSecAttrAccount];
    
    NSData *returnData = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)loadQuery, (void *)&returnData);
    
    if (status == errSecSuccess &&
        returnData != nil) {
        NSString *text = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        [self.cUUIDLabel setText:text];
        
        NSLog(@"Loaded text: %@", text);
    }
}

@end

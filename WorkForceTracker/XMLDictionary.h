
#import <Foundation/Foundation.h>


typedef enum
{
    XMLDictionaryAttributesModePrefixed = 0, //default
    XMLDictionaryAttributesModeDictionary,
    XMLDictionaryAttributesModeUnprefixed,
    XMLDictionaryAttributesModeDiscard
}
XMLDictionaryAttributesMode;


typedef enum
{
    XMLDictionaryNodeNameModeRootOnly = 0, //default
    XMLDictionaryNodeNameModeAlways,
    XMLDictionaryNodeNameModeNever
}
XMLDictionaryNodeNameMode;


static NSString *const XMLDictionaryAttributesKey   = @"__attributes";
static NSString *const XMLDictionaryCommentsKey     = @"__comments";
static NSString *const XMLDictionaryTextKey         = @"__text";
static NSString *const XMLDictionaryNodeNameKey     = @"__name";
static NSString *const XMLDictionaryAttributePrefix = @"_";


@interface XMLDictionaryParser : NSObject <NSCopying>

+ (XMLDictionaryParser *)sharedInstance;

@property (nonatomic, assign) BOOL collapseTextNodes; // defaults to YES
@property (nonatomic, assign) BOOL stripEmptyNodes;   // defaults to YES
@property (nonatomic, assign) BOOL trimWhiteSpace;    // defaults to YES
@property (nonatomic, assign) BOOL alwaysUseArrays;   // defaults to NO
@property (nonatomic, assign) BOOL preserveComments;  // defaults to NO

@property (nonatomic, assign) XMLDictionaryAttributesMode attributesMode;
@property (nonatomic, assign) XMLDictionaryNodeNameMode nodeNameMode;

- (NSDictionary *)dictionaryWithData:(NSData *)data;
- (NSDictionary *)dictionaryWithString:(NSString *)string;
- (NSDictionary *)dictionaryWithFile:(NSString *)path;

@end


@interface NSDictionary (XMLDictionary)

+ (NSDictionary *)dictionaryWithXMLData:(NSData *)data;
+ (NSDictionary *)dictionaryWithXMLString:(NSString *)string;
+ (NSDictionary *)dictionaryWithXMLFile:(NSString *)path;

- (NSDictionary *)attributes;
- (NSDictionary *)childNodes;
- (NSArray *)comments;
- (NSString *)nodeName;
- (NSString *)innerText;
- (NSString *)innerXML;
- (NSString *)XMLString;

- (NSArray *)arrayValueForKeyPath:(NSString *)keyPath;
- (NSString *)stringValueForKeyPath:(NSString *)keyPath;
- (NSDictionary *)dictionaryValueForKeyPath:(NSString *)keyPath;

@end


@interface NSString (XMLDictionary)

- (NSString *)XMLEncodedString;

@end


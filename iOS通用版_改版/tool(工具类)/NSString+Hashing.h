

#import <Foundation/Foundation.h>


@interface NSString (NSString_Hashing)

- (NSString *)MD5Hash;

- (NSString *)MD5Digest;
/**
 *  获取当前时间戳
 */
+ (NSString *)timeIntervalGetFromNow;


/**
 *  根据格式将时间戳转换成时间
 *
 *  @param timestamp    时间戳
 *  @param dateFormtter 日期格式
 *
 *  @return 带格式的日期
 */
+ (NSString *)timeFromTimestamp:(NSInteger)timestamp formtter:(NSString *)formtter;

/**
 *  时间戳转成字符串
 *
 *  @param timestamp 时间戳
 *
 *  @return 格式化后的字符串 （例如：5分钟前，7天前）
 */
+ (NSString *)timeFromTimestamp:(NSString *)timestamp;
@end

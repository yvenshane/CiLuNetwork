#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    NSMutableString *nmString = [NSMutableString stringWithString:@"\n[\n"];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [nmString appendFormat:@"\t%@\n",obj];
        
    }];
    
    [nmString appendString:@"]\n"];
    
    return nmString.copy;
}

@end

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    
    NSMutableString *nmString = [NSMutableString stringWithString:@"\n{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [nmString appendFormat:@"\t%@ = %@\n",key,obj];
        
    }];
    
    [nmString appendString:@"\n}\n"];
    
    return nmString.copy;
}

@end

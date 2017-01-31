//
//  QMChatMediaItem.m
//  QMChatService
//
//  Created by Vitaliy Gurkovsky on 1/23/17.
//


#define QM_SERIALIZE_OBJECT(var_name, coder)		[coder encodeObject:var_name forKey:@#var_name]
#define QM_SERIALIZE_INTEGER(var_name, coder)	    [coder encodeInteger:var_name forKey:@#var_name]
#define QM_SERIALIZE_INT(var_name, coder)	        [coder encodeInt:var_name forKey:@#var_name]

#define QM_DESERIALIZE_OBJECT(var_name, decoder)	var_name = [decoder decodeObjectForKey:@#var_name]
#define QM_DESERIALIZE_INTEGER(var_name, decoder)	var_name = [decoder decodeIntegerForKey:@#var_name]
#define QM_DESERIALIZE_INT(var_name, decoder)	    var_name = [decoder decodeIntForKey:@#var_name]


#import "QMChatMediaItem.h"

@interface QMChatMediaItem()

@property (assign, nonatomic) QMMediaContentType contentType;

@end

@implementation QMChatMediaItem

//MARK: Class methods

+ (instancetype)videoItemWithURL:(NSURL *)itemURL {
    
    return [[QMChatMediaItem alloc] initWithName:@"video" localURL:itemURL remoteURL:nil contentType:QMMediaContentTypeVideo];
}

+ (instancetype)audioItemWithURL:(NSURL *)itemURL {
    
    return [[QMChatMediaItem alloc] initWithName:@"audio" localURL:itemURL remoteURL:nil contentType:QMMediaContentTypeAudio];
}

//MARK: Initialize
- (instancetype)initWithName:(NSString *)name
                    localURL:(NSURL *)localURL
                   remoteURL:(NSURL *)remoteURL
                 contentType:(QMMediaContentType)contentType {
    
    if (self = [super init]) {
        
        _name = [name copy];
        _localURL = [localURL copy];
        _remoteURL = [remoteURL copy];
        _contentType = contentType;
    }
    
    return self;
}

- (NSString *)stringMIMEType {
    
    NSString *stringMIMEType = nil;
    
    switch (self.contentType) {
        case QMMediaContentTypeAudio:
            stringMIMEType = @"audio/caf";
            break;
            
        case QMMediaContentTypeVideo:
            stringMIMEType = @"video/mp4";
            break;
            
        default:
            stringMIMEType = @"";
            break;
    }
    
    return stringMIMEType;
}

- (NSString *)stringMediaType {
    
    NSString *stringMediaType = nil;
    
    switch (self.contentType) {
        case QMMediaContentTypeAudio:
            stringMediaType = @"audio";
            break;
            
        case QMMediaContentTypeVideo:
            stringMediaType = @"video";
            break;
            
        default:
            stringMediaType = @"";
            break;
    }
    
    return stringMediaType;
}


//MARK: - NSObject

- (BOOL)isEqual:(id)object {
    
    if (self == object) {
        
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        
        return NO;
    }
    
    QMChatMediaItem *mediaItem = (QMChatMediaItem *)object;
    
    if (_mediaID != nil ? ![_mediaID isEqualToString:mediaItem.mediaID] : mediaItem.mediaID != nil) {
        
        return NO;
    }
    
    return [super isEqual:object];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"<%@: %p; name = %@; localURL = %@; remote = %@; mediaType = %@; mimeType = %@;>",
            NSStringFromClass([self class]),
            self,
            self.name,
            self.localURL,
            self.remoteURL,
            [self stringMediaType],
            [self stringMIMEType]
            ];
}

- (NSUInteger)hash {
    
    return [self.localURL hash];
}

//MARK: - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    
    QMChatMediaItem *copy = [[[self class] allocWithZone:zone] init];
    
    copy.mediaID  = [self.mediaID copyWithZone:zone];
    copy.localURL = [self.localURL copyWithZone:zone];
    copy.remoteURL = [self.localURL copyWithZone:zone];
    copy.name  = [self.name copyWithZone:zone];
    copy.contentType = self.contentType;
    copy.mediaDuration = self.mediaDuration;
    
    return copy;
}

//MARK: - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        
        QM_DESERIALIZE_OBJECT(_mediaID, aDecoder);
        QM_DESERIALIZE_OBJECT(_localURL, aDecoder);
        QM_DESERIALIZE_OBJECT(_remoteURL, aDecoder);
        QM_DESERIALIZE_OBJECT(_name, aDecoder);
        QM_DESERIALIZE_INT(_contentType, aDecoder);
        QM_DESERIALIZE_INTEGER(_mediaDuration, aDecoder);
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    QM_SERIALIZE_OBJECT(_mediaID, aCoder);
    QM_SERIALIZE_OBJECT(_localURL, aCoder);
    QM_SERIALIZE_OBJECT(_remoteURL, aCoder);
    QM_SERIALIZE_OBJECT(_name, aCoder);
    QM_SERIALIZE_INT(_contentType, aCoder);
    QM_SERIALIZE_INTEGER(_mediaDuration, aCoder);
}

@end
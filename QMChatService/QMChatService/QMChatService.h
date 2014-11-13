//
//  QMChatGroupService.h
//  Qmunicate
//
//  Created by Andrey Ivanov on 02.07.14.
//  Copyright (c) 2014 Quickblox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QMBaseService.h"
#import "QMDialogsMemoryStorage.h"

@protocol QMChatServiceDelegate;
/**
 *  Chat dialog service
 */
@interface QMChatService : QMBaseService

@property (strong, nonatomic, readonly) QMDialogsMemoryStorage *memoryStorage;
    
- (void)addDelegate:(id<QMChatServiceDelegate>)delegate;
- (void)addRemoveDelegate:(id<QMChatServiceDelegate>)delegate;

- (void)createGroupChatDialogWithName:(NSString *)name
                            occupants:(NSArray *)occupants
                           completion:(void(^)(QBResponse *response, QBChatDialog *createdDialog))completion;

- (void)createPrivateChatDialogIfNeededWithOpponent:(QBUUser *)opponent
                                         completion:(void(^)(QBResponse *response, QBChatDialog *createdDialo))completion;

- (void)changeChatName:(NSString *)dialogName
         forChatDialog:(QBChatDialog *)chatDialog
            completion:(void(^)(QBResponse *response, QBChatDialog *updatedDialog))completion;

- (void)joinOccupantsWithIDs:(NSArray *)ids
                toChatDialog:(QBChatDialog *)chatDialog
                  completion:(void(^)(QBResponse *response, QBChatDialog *updatedDialog))completion;

- (void)fetchAllDialogs:(void(^)(QBResponse *response, NSArray *dialogObjects, NSSet *dialogsUsersIDs))completion;

- (void)logIn:(void(^)(NSError *error))completion;

- (void)logoutChat;

- (void)fetchMessageWithDialogID:(NSString *)chatDialogId complete:(void(^)(BOOL success))completion;

- (void)sendText:(NSString *)text
        toDialog:(QBChatDialog *)dialog
      completion:(void(^)(QBChatMessage *message))completion;

- (void)sendAttachment:(NSString *)attachmentUrl
              toDialog:(QBChatDialog *)dialog
            completion:(void(^)(QBChatMessage *message))completion;

@end

@protocol QMChatServiceDelegate <NSObject>

@optional

- (void)chatServiceDidDialogsHistoryUpdated;
- (void)chatServiceDidMessagesHistoryUpdated;
- (void)chatServiceDidAddMessageToHistory:(QBChatMessage *)message forDialog:(QBChatDialog *)dialog;
- (void)chatServiceDidReceiveNotificationMessage:(QBChatMessage *)message createDialog:(QBChatDialog *)dialog;
- (void)chatServiceDidReceiveNotificationMessage:(QBChatMessage *)message updateDialog:(QBChatDialog *)dialog;

@end
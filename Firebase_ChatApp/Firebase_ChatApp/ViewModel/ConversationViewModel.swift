//
//  ConversationViewModel.swift
//  Firebase_ChatApp
//
//  Created by JinBae Jeong on 2020/08/31.
//  Copyright © 2020 pino. All rights reserved.
//

import Foundation

struct ConversationViewModel {
  
  private let conversation: Conversation
  
  var profileImageUrl: URL? {
    return URL(string: conversation.user.profileImageUrl)
  }
  
  var timestamp: String {
    let date = conversation.message.timestamp.dateValue()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
    
    return dateFormatter.string(from: date)
  }
  
  init(conversation: Conversation) {
    self.conversation = conversation
  }
  
}

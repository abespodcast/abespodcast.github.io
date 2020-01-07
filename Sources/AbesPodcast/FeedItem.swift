//
//  FeedItem.swift
//  
//
//  Created by Eralp Karaduman on 7.1.2020.
//

import Foundation

struct FeedItem {
  let title: String
  let link: String
  let description: String
  init(withDictionary dictionary: Dictionary<String, String>) {
    title = dictionary["title"]!
    link = dictionary["link"] ?? ""
    description = dictionary["description"]!
  }
}

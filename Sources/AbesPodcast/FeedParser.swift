import Foundation

class FeedParser: NSObject, XMLParserDelegate {
  var parser: XMLParser!

  var items:[FeedItem]! = Array()
  var itemDictionary: Dictionary<String, String>! = Dictionary<String, String>()

  var currentElement = ""

  var itemLink: String!
  var itemTitle: String!
  var itemDescription: String!
  var itemEpisode: String!
  var itemPubDate: String!
  var itemImage: String!

  var skip = true

  var foundCharacters = ""

  init(withData data: Data) {
    parser = XMLParser(data: data)
    super.init()
    parser.delegate = self
  }

  func parse() -> [FeedItem] {
    parser.parse()
    return items
  }

  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    switch elementName {
    case "item":
      skip = false
    case "title" where !skip:
      itemTitle = String()
    case "link" where !skip:
      itemLink = String()
    case "description" where !skip:
      itemDescription = String()
    case "itunes:episode" where !skip:
      itemEpisode = String()
    case "pubDate" where !skip:
      itemPubDate = String()
    case "itunes:image" where !skip:
      itemImage = attributeDict["href"]
    default:
      break
    }
    currentElement = elementName
  }

  func parser(_ parser: XMLParser, foundCharacters string: String) {
    switch currentElement {
    case "title" where !skip:
      itemTitle += string
    case "link" where !skip:
      itemLink += string
    case "description" where !skip:
      itemDescription += string
    case "itunes:episode" where !skip:
      itemEpisode += string
    case "pubDate" where !skip:
      itemPubDate += string
    default:
      break
    }
  }

  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    switch elementName {
    case "title" where !skip:
      itemDictionary[elementName] = itemTitle
    case "link" where !skip:
      itemDictionary[elementName] = itemLink
    case "description" where !skip:
      itemDictionary[elementName] = itemDescription
    case "itunes:episode" where !skip:
      itemDictionary[elementName] = itemEpisode
    case "pubDate" where !skip:
      itemDictionary[elementName] = itemPubDate
    case "itunes:image" where !skip:
      itemDictionary[elementName] = itemImage
    case "item" where !skip:
      items.append(FeedItem(withDictionary: itemDictionary))
    default:
      break
    }
  }

  func parserDidEndDocument(_ parser: XMLParser) { }
}

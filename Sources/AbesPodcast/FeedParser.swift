import Foundation

class FeedParser: NSObject, XMLParserDelegate {
  var parser: XMLParser!

  var items:[FeedItem]! = Array()
  var itemDictionary: Dictionary<String, String>! = Dictionary<String, String>()

  var itemLink: String!
  var itemTitle: String!
  var itemDescription: String!
  var currentElement = ""
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
      currentElement = elementName
    case "link" where !skip:
      itemLink = String()
      currentElement = elementName
    case "description" where !skip:
      itemDescription = String()
      currentElement = elementName
    default:
      break
    }
  }

  func parser(_ parser: XMLParser, foundCharacters string: String) {
    switch currentElement {
    case "title" where !skip:
      itemTitle += string
    case "link" where !skip:
      itemLink += string
    case "description" where !skip:
      itemDescription += string
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
    case "item" where !skip:
      items.append(FeedItem(withDictionary: itemDictionary))
    default:
      break
    }
  }

  func parserDidEndDocument(_ parser: XMLParser) { }
}

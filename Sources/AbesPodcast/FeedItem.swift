import Foundation

struct FeedItem {
  let title: String
  let link: String
  let description: String
  let episode: String
  let publishDate: Date
  let imageUrl: URL
  init(withDictionary dictionary: [String: String]) {
    title = dictionary["title"]!
    link = dictionary["link"] ?? ""
    description = dictionary["description"]!
    episode = dictionary["itunes:episode"]!
    imageUrl = URL(string: dictionary["itunes:image"]!)!

    let formatter = DateFormatter()
    formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss z"
    let pubDate = dictionary["pubDate"]!
    let date = formatter.date(from: pubDate)!
    publishDate = date
  }
}

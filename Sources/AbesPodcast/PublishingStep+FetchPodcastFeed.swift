import Foundation
import Publish

struct RssItem {
  let title: String
  let link: String
  let description: String
  init(withDictionary dictionary: Dictionary<String, String>) {
    title = dictionary["title"]!
    link = dictionary["link"] ?? ""
    description = dictionary["description"]!
  }
}

extension PublishingStep where Site == AbesPodcast {
  static func fetchPodcastFeed(url urlString: String) -> Self {
    .step(named: "Fetch Podcast Feed", body: { _ in
      let data = fetchUrlSync(url: URL(string: urlString)!)
      let items = parseFeedSync(data: data)
      print("parsed \(items.count) items")
    })
  }
}

func parseFeedSync(data: Data) -> [RssItem] {
  let semaphore = DispatchSemaphore(value: 0)
  var items: [RssItem]?
  FeedParser(withData: data).parse { (_items) in
    items = _items
    semaphore.signal()
  }
  semaphore.wait()
  return items!
}

func fetchUrlSync(url: URL) -> Data {
  let semaphore = DispatchSemaphore(value: 0)
  var result: Data? = nil
  let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
    // TODO: Handle error
    result = data!
    semaphore.signal()
  }
  task.resume()
  semaphore.wait()
  return result!
}

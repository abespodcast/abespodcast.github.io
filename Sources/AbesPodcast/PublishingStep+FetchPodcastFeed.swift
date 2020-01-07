import Foundation
import Publish

extension PublishingStep where Site == AbesPodcast {
  static func fetchPodcastFeed(url urlString: String) -> Self {
    .step(named: "Fetch Podcast Feed", body: { _ in
      let data = fetchUrlSync(url: URL(string: urlString)!)
      let items = parseFeedSync(data: data)
      print("Parsed \(items.count) feed items")
    })
  }
}

func parseFeedSync(data: Data) -> [FeedItem] {
  let semaphore = DispatchSemaphore(value: 0)
  var items: [FeedItem]?
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

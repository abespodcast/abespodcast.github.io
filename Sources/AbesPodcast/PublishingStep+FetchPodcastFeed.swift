import Foundation
import Publish

extension PublishingStep where Site == AbesPodcast {
  static func fetchPodcastFeed(url urlString: String) -> Self {
    .step(named: "Fetch Podcast Feed", body: { _ in
      let data = try! Data(contentsOf: URL(string: urlString)!)
      let items = FeedParser(withData: data).parse()
      print("Parsed \(items.count) feed items")
    })
  }
}

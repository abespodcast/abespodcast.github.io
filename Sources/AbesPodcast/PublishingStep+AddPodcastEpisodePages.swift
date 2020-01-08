import Foundation
import Plot
import Publish

extension PublishingStep where Site == AbesPodcast {
  static func addPodcastEpisodePages(url urlString: String) -> Self {
    .step(named: "Add Podcast Episode Pages", body: { context in
      let data = try! Data(contentsOf: URL(string: urlString)!)
      let items = FeedParser(withData: data).parse()
      for item in items {
        context.addItem(
          Item(
            path: "episode-\(item.episode)",
            sectionID: .episodes,
            metadata: AbesPodcast.ItemMetadata(),
            tags: ["episode"],
            content: Content(
              title: item.title,
              description: item.description,
              date: item.publishDate,
              lastModified: item.publishDate
            )
          )
        )
      }
    })
  }
}

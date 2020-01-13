import FeedKit
import Foundation
import Plot
import Publish

extension PublishingStep where Site == AbesPodcast {
  static func addPodcastEpisodePages(url urlString: String, locale localeIdentifier: String) -> Self {
    .step(named: "Add Podcast Episode Pages", body: { context in
      let result = FeedKit.FeedParser(URL: URL(string: urlString)!).parse()
      guard case let .success(feed) = result, case let .rss(rssFeed) = feed
      else { throw PublishingError(infoMessage: "Failed to load feed") }

      let formatter = DateFormatter()
      formatter.dateStyle = .long
      formatter.timeStyle = .medium
      formatter.locale = Locale(identifier: localeIdentifier)

      for item in rssFeed.items ?? [] {
        guard
          let title = item.title,
          let description = item.description,
          let episode = item.iTunes?.iTunesEpisode,
          let pubDate = item.pubDate,
          let link = item.link,
          let imageUrl = item.iTunes?.iTunesImage?.attributes?.href
        else { throw PublishingError(infoMessage: "Missing information in feed item") }

        context.addItem(
          Item(
            path: "episode-\(episode)",
            sectionID: .posts,
            metadata: AbesPodcast.ItemMetadata(),
            tags: ["episode"],
            content: Content(
              title: formatter.string(from: pubDate),
              description: description,
              body: Content.Body(node: .div(
                .h1(.text(title)),
                .p(.text(formatter.string(from: pubDate))),
                .p(.text(description)),
                .iframe(
                  .attribute(named: "width", value: "400px"),
                  .attribute(named: "height", value: "102px"),
                  .attribute(named: "scrolling", value: "no"),
                  .frameborder(false),
                  .allowfullscreen(false),
                  .src(link.replacingOccurrences(of: "/episodes/", with: "/embed/episodes/"))
                ),
                .br(),
                .img(.src(imageUrl), .attribute(named: "width", value: "400px")),
                .br(),
                .a(.href(link), .img(.src("/images/anchor.png")))
              )),
              date: pubDate,
              lastModified: pubDate
            )
          )
        )
      }
    })
  }
}

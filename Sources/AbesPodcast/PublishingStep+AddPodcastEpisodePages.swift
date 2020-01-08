import Foundation
import Plot
import Publish

extension PublishingStep where Site == AbesPodcast {
  static func addPodcastEpisodePages(url urlString: String) -> Self {
    .step(named: "Add Podcast Episode Pages", body: { context in
      let data = try! Data(contentsOf: URL(string: urlString)!)
      let items = FeedParser(withData: data).parse()
      let formatter = DateFormatter()
      formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss z"
      for item in items {
        context.addItem(
          Item(
            path: "episode-\(item.episode)",
            sectionID: .posts,
            metadata: AbesPodcast.ItemMetadata(),
            tags: ["episode"],
            content: Content(
              title: item.title,
              description: item.description,
              body: Content.Body(node: .div(
                .h1(.text(item.title)),
                .p(.text(formatter.string(from: item.publishDate))),
                .p(.text(item.description)),
                .iframe(
                  .attribute(named: "width", value: "400px"),
                  .attribute(named: "height", value: "102px"),
                  .attribute(named: "scrolling", value: "no"),
                  .frameborder(false),
                  .allowfullscreen(false),
                  .src(item.link.replacingOccurrences(of: "/episodes/", with: "/embed/episodes/"))
                ),
                .br(),
                .img(
                  .src(item.imageUrl),
                  .attribute(named: "width", value: "400px")
                ),
                .br(),
                .a(.href(item.link), .img(.src("/images/anchor.png")))
              )),
              date: item.publishDate,
              lastModified: item.publishDate
            )
          )
        )
      }
    })
  }
}

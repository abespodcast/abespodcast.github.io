import Foundation
import Plot
import Publish

struct AbesPodcast: Website {
  enum SectionID: String, WebsiteSectionID {
    // Add the sections that you want your website to contain here:
    case posts
  }

  struct ItemMetadata: WebsiteItemMetadata {
    // Add any site-specific metadata that you want to use here.
  }

  // Update these properties to configure your website:
  var url = URL(string: "https://abespodcast.github.io")!
  var name = "Abes Podcast"
  var description = "Mert, Can ve Cansın kafalarına estikçe, kafalarından geçenleri birbirlerine anlatıyorlar bazen de açıklıyorlar."
  var language: Language { .turkish }
  var imagePath: Path? { nil }
}

try AbesPodcast().publish(
  withTheme: .abes,
  additionalSteps: [
    .deploy(using: .gitHub("abespodcast/abespodcast.github.io")),
    .addPodcastEpisodePages(url: "https://anchor.fm/s/b70e800/podcast/rss"),
  ]
)

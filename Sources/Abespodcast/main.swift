import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
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
    var name = "AbesPodcast"
    var description = "A description of AbesPodcast"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try AbesPodcast().publish(
  withTheme: .foundation,
  additionalSteps: [
    .deploy(using:.gitHub("abespodcast/abespodcast.github.io"))
])

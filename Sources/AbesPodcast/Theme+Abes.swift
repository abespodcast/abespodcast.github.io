import Plot
import Publish
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public extension Theme {
    static var abes: Self {
        Theme(
            htmlFactory: AbesHTMLFactory(),
            resourcePaths: ["Resources/AbesTheme/styles.css"]
        )
    }
}

private struct AbesHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(
        for index: Index,
        context: PublishingContext<Site>
    ) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(.text(context.site.name)),
                    .p(
                        .class("description"),
                        .text(context.site.description)
                    ),
                    .div(
                        .class("listening-source-list"),
                        .a(
                            .class("listening-source"),
                            .href("https://podcasts.apple.com/us/podcast/abes/id1467674555?uo=4"),
                            .img(.src(Path("/images/apple_podcasts.png")),.class("listening-source-icon"))
                        ),
                        .a(
                            .class("listening-source"),
                            .href("https://www.breaker.audio/abes"),
                            .img(.src(Path("/images/breaker.png")),.class("listening-source-icon"))
                        ),
                        .a(
                            .class("listening-source"),
                            .href("https://www.google.com/podcasts?feed=aHR0cHM6Ly9hbmNob3IuZm0vcy9iNzBlODAwL3BvZGNhc3QvcnNz"),
                            .img(.src(Path("/images/google_podcasts.png")),.class("listening-source-icon"))
                        ),
                        .a(
                            .class("listening-source"),
                            .href("https://pca.st/01HZ"),
                            .img(.src(Path("/images/pocket_casts.png")),.class("listening-source-icon"))
                        ),
                        .a(
                            .class("listening-source"),
                            .href("https://radiopublic.com/abes-GEBA9b"),
                            .img(.src(Path("/images/radiopublic.png")),.class("listening-source-icon"))
                        ),
                        .a(
                            .class("listening-source"),
                            .href("https://open.spotify.com/show/4XgrpsMAsYgrdtph48HN3S"),
                            .img(.src(Path("/images/spotify.png")),.class("listening-source-icon"))
                        ),
                        
                        .a(
                            .class("listening-source"),
                            .href("https://overcast.fm/itunes1467674555/abes"),
                            .img(.src(Path("/images/overcast.svg")),.class("listening-source-icon"))
                        ),
                        .a(
                            .class("listening-source"),
                            .href("https://anchor.fm/s/b70e800/podcast/rss"),
                            .img(.src(Path("/images/rss.png")),.class("listening-source-icon"))
                        )
                    ),
                    .h2("Son Eklenenler"),
                    .itemList(
                        for: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeSectionHTML(
        for section: Section<Site>,
        context: PublishingContext<Site>
    ) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .wrapper(
                    .h1(.text(section.title)),
                    .itemList(for: section.items, on: context.site)
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeItemHTML(
        for item: Item<Site>,
        context: PublishingContext<Site>
    ) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .h2(.text(context.site.name)),
                    .article(
                        .div(
                            .class("content"),
                            .contentBody(item.body)
                        ),
                        .span("Etiket: "),
                        .tagList(for: item, on: context.site)
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makePageHTML(
        for page: Page,
        context: PublishingContext<Site>
    ) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makeTagListHTML(
        for page: TagListPage,
        context: PublishingContext<Site>
    ) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1("Tüm Etiketlere Bak"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makeTagDetailsHTML(
        for page: TagDetailsPage,
        context: PublishingContext<Site>
    ) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h2(.text(context.site.name)),
                    .h1(
                        "Etiket: ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Tüm Etiketlere Bak"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases
        
        return .header(
            .wrapper(
                .a(.href("/"), .div(.class("header-background"))),
                .if(
                    sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(.a(
                                .class(section == selectedSection ? "selected" : ""),
                                .href(context.sections[section].path),
                                .text(context.sections[section].title)
                                ))
                            })
                    )
                )
            )
        )
    }
    
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                        )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                    ))
            }
        )
    }
    
    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
                ))
            })
    }
    
    static func footer<T: Website>(for _: T) -> Node {
        return .footer(
            .p(
                .text("Open Source at "),
                .a(
                    .text("GitHub"),
                    .href("https://github.com/abespodcast/abespodcast.github.io")
                )
            ),
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
                )),
            .script(.src(URL(string: "https://www.gstatic.com/firebasejs/7.8.1/firebase-app.js")!)),
            .script(.src(URL(string: "https://www.gstatic.com/firebasejs/7.8.1/firebase-analytics.js")!)),
            .script("""
        // Your web app's Firebase configuration
        var firebaseConfig = {
          apiKey: "AIzaSyB9FtUufaUqCIp27Mb7aPF42ovAbggyrZE",
          authDomain: "abespodcast-b5308.firebaseapp.com",
          databaseURL: "https://abespodcast-b5308.firebaseio.com",
          projectId: "abespodcast-b5308",
          storageBucket: "abespodcast-b5308.appspot.com",
          messagingSenderId: "758058129881",
          appId: "1:758058129881:web:3137bf59793662d431a1c8",
          measurementId: "G-WHES6K4K9M"
        };
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);
        firebase.analytics();
      """)
        )
    }
}


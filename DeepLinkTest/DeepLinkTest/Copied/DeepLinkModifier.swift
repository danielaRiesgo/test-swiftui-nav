//
//  DeepLinkModifier.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import Foundation
import SwiftUI

extension View {

    func deepLinkable() -> some View {
        self.modifier(DeepLinkOpenerModifier())
    }

}

private struct DeepLinkKey: EnvironmentKey {
    static let defaultValue: DeepLinkViewModel = DeepLinkViewModel()
}

extension EnvironmentValues {
    var deepLink: DeepLinkViewModel {
        get { self[DeepLinkKey.self] }
        set { self[DeepLinkKey.self] = newValue }
    }
}

class DeepLinkViewModel: ObservableObject {

    @Published var showCollectionProfile: Bool = false
    private(set) var collectionTitle: String?
    @Published var showPlayableProfile: Bool = false
    private(set) var playableTitle: String?

    private(set) var originalRoute: InternalRoute?
    private var nestedDeepLink: DeepLinkViewModel?

    init() {
        self.originalRoute = nil
    }

    init(_ routes: [InternalRoute]) {
        guard !routes.isEmpty else {
            self.originalRoute = nil
            return
        }
        var pendingRoutes = routes
        let route = pendingRoutes.removeFirst()
        self.originalRoute = route
        self.nestedDeepLink = DeepLinkViewModel(pendingRoutes)
        self.open(route)
    }

    func reset() {
        if let link = nestedDeepLink {
            link.reset()
        }
        if showCollectionProfile {
            showCollectionProfile = false
        }
        if showPlayableProfile {
            showPlayableProfile = false
        }
    }

    func open(_ route: InternalRoute) {
        reset()
        switch route {
        case .collection(let collection):
            collectionTitle = collection
            showCollectionProfile = true
        case .playable(let playable):
            playableTitle = playable
            showPlayableProfile = true
        }
    }

    func open(_ routes: [InternalRoute]) {
        if routes.isEmpty {
            self.originalRoute = nil
            self.nestedDeepLink = nil
            return
        }
        var pendingRoutes = routes
        let route = pendingRoutes.removeFirst()
        self.originalRoute = route
        self.nestedDeepLink = DeepLinkViewModel(pendingRoutes)
        self.open(route)
    }

    func getNestedDeepLink() -> DeepLinkViewModel {
        if let link = nestedDeepLink {
            return link
        }
        let link = DeepLinkViewModel()
        nestedDeepLink = link
        return link
    }

    func getRoutes() -> [InternalRoute] {
        var routes: [InternalRoute] = []
        if let route = originalRoute, isActive() {
            routes.append(route)
        }
        if let link = nestedDeepLink {
            routes.append(contentsOf: link.getRoutes())
        }
        return routes
    }

    func appending(routes: [InternalRoute]) -> DeepLinkViewModel {
        DeepLinkViewModel(getRoutes() + routes)
    }

    func isActive() -> Bool {
        return showCollectionProfile || showPlayableProfile
    }

}

extension DeepLinkViewModel: Equatable {
    static func == (lhs: DeepLinkViewModel, rhs: DeepLinkViewModel) -> Bool {
        return lhs === rhs
        // This one causes an infinite loop
//        return lhs.getRoutes() == rhs.getRoutes()
        // This ones causes links to close.
//        return lhs.originalRoute == rhs.originalRoute
//            && lhs.isActive() == rhs.isActive()
    }
}

private struct DeepLinkOpenerModifier: ViewModifier {

    @EnvironmentObject var viewModel: DeepLinkViewModel

    func body(content: Content) -> some View {
        ZStack {
            content
                .environmentObject(viewModel)
            NavigationLink(destination: LazyView(CollectionProfile(title: viewModel.collectionTitle!)
                .environmentObject(viewModel.getNestedDeepLink())),
                           isActive: $viewModel.showCollectionProfile) { EmptyView() }
                .isDetailLink(false)
            NavigationLink(destination: LazyView(PlayableProfile(title: viewModel.playableTitle!)
                .environmentObject(viewModel.getNestedDeepLink())),
                           isActive: $viewModel.showPlayableProfile) { EmptyView() }
                .isDetailLink(false)
        }
    }

}

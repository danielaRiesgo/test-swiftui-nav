//
//  AppView.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import SwiftUI

struct AppView: View {

    @ObservedObject private var viewModel: ViewModel
    @State var deepLink = DeepLinkViewModel()
    var onLoading: () -> Void
    var onOnboarding: () -> Void

    init(viewModel: ViewModel,
         onLoading: @escaping () -> Void,
         onOnboarding: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onLoading = onLoading
        self.onOnboarding = onOnboarding
    }

    var body: some View {
        VStack {
            Text("Welcome to our app!")
            Button("Simulate DL") {
                deepLink = DeepLinkViewModel([.collection("Podcast DL"), .playable("Episode DL")])
            }
            Group {
                switch viewModel.state {
                case .main:
                    MainView()
                        .environmentObject(viewModel.mainVM)
                case .loading:
                    VStack {
                        Text("Loading")
                        Button("Go to onboarding", action: onLoading)
                    }
                case .onboarding:
                    VStack {
                        Text("Onboarding")
                        Button("Go to main", action: onOnboarding)
                    }
                }
            }.environmentObject(deepLink)
        }
    }
}

extension AppView {

    class ViewModel: ObservableObject {
        enum State {
            case loading, onboarding
            case main
        }

        @Published var state: State {
            didSet {
                refreshViewModel(for: state, from: oldValue)
            }
        }

        init(state: State) {
            self.state = state
        }

        private(set) lazy var mainVM: MainView.ViewModel = getMainVM()

        private func refreshViewModel(for newState: State, from oldState: State) {
            switch (oldState, newState) {
            case (.onboarding, .main), (.loading, .main):
                mainVM = getMainVM()
            default: break
            }
        }

        private func getMainVM() -> MainView.ViewModel {
            return MainView.ViewModel()
        }

    }

}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(viewModel: AppView.ViewModel(state: .loading),
                onLoading: {},
                onOnboarding: {})
    }
}

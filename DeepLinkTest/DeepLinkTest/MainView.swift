//
//  MainView.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import SwiftUI

struct MainView: View {

    @EnvironmentObject var deepLink: DeepLinkViewModel
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        TabView(selection: $viewModel.currentTab) {
            NavigationView {
                Tab1View().environmentObject(viewModel.dp1)
            }.tabItem { Text("Tab1") }.tag(0)
            NavigationView {
                Tab2View().environmentObject(viewModel.dp2)
            }.tabItem { Text("Tab2") }.tag(1)
        }.onChange(of: deepLink) { newValue in
            viewModel.generalDeepLink = newValue
        }
    }
}

extension MainView {

    class ViewModel: ObservableObject {

        @Published var currentTab: Int = 0
        @Published var dp1 = DeepLinkViewModel()
        @Published var dp2 = DeepLinkViewModel()

        var generalDeepLink: DeepLinkViewModel {
            didSet {
                switch currentTab {
                case 0: dp1 = generalDeepLink
                case 1: dp2 = generalDeepLink
                default: break
                }
            }
        }

        init() {
            generalDeepLink = DeepLinkViewModel()
        }

    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

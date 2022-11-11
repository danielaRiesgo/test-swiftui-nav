//
//  MainView.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import SwiftUI

struct MainView: View {

    @EnvironmentObject var deepLink: DeepLinkViewModel
    @State private var currentTab: Int = 0
    @State private var dp1 = DeepLinkViewModel()
    @State private var dp2 = DeepLinkViewModel()

    var body: some View {
        TabView(selection: $currentTab) {
            NavigationView {
                Tab1View().environmentObject(dp1)
            }.tabItem { Text("Tab1") }.tag(0)
            NavigationView {
                Tab2View().environmentObject(dp2)
            }.tabItem { Text("Tab2") }.tag(1)
        }.onChange(of: deepLink) { newValue in
            switch currentTab {
            case 0: dp1 = newValue
            case 1: dp2 = newValue
            default: break
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

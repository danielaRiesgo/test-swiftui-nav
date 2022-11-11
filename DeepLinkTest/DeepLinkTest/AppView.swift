//
//  AppView.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import SwiftUI

struct AppView: View {

    @State var deepLink = DeepLinkViewModel()

    var body: some View {
        Text("Welcome to our app!")
        Button("Simulate DL") {
            deepLink = DeepLinkViewModel([.collection("Podcast DL"), .playable("Episode DL")])
        }
        MainView().environmentObject(deepLink)

    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

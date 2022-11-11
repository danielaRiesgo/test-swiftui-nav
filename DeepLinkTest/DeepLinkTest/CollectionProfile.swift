//
//  CollectionProfile.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import SwiftUI

struct CollectionProfile: View {

    @EnvironmentObject var deepLink: DeepLinkViewModel

    var title: String

    var body: some View {
        VStack {
            Text(title)
            Button("Episode") { deepLink.open(.playable("Episode A")) }
        }.deepLinkable()
    }
}

struct CollectionProfile_Previews: PreviewProvider {
    static var previews: some View {
        CollectionProfile(title: "Podcast")
    }
}

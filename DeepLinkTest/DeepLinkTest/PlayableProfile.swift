//
//  PlayableProfile.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import SwiftUI

struct PlayableProfile: View {

    var title: String

    var body: some View {
        Text(title)
            .deepLinkable()
    }
}

struct PlayableProfile_Previews: PreviewProvider {
    static var previews: some View {
        PlayableProfile(title: "Episode")
    }
}

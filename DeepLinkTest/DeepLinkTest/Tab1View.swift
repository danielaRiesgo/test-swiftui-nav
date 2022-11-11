//
//  Tab1View.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import SwiftUI

struct Tab1View: View {

    @EnvironmentObject var deepLink: DeepLinkViewModel

    var body: some View {
        VStack {
            Text("Tab 1")
            Button("DeepLink") {
                deepLink.open(.collection("Podcast 1"))
            }
        }.deepLinkable()
    }
}

struct Tab1View_Previews: PreviewProvider {
    static var previews: some View {
        Tab1View()
    }
}

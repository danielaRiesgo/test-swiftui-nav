//
//  Tab2View.swift
//  DeepLinkTest
//
//  Created by Dani on 11/10/22.
//

import SwiftUI

struct Tab2View: View {

    @EnvironmentObject var deepLink: DeepLinkViewModel

    var body: some View {
        VStack {
            Text("Tab 2")
            Button("DeepLink") {
                deepLink.open(.collection("Podcast 2"))
            }
        }.deepLinkable()
    }
}

struct Tab2View_Previews: PreviewProvider {
    static var previews: some View {
        Tab2View()
    }
}

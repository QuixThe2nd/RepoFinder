//
//  AppView.swift
//  RepoFinder 2.0
//
//  Created by Jacob Singer on 12/10/19.
//  Copyright © 2019 Jacob Singer. All rights reserved.
//

import SwiftUI


struct AppView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
            }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
            
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

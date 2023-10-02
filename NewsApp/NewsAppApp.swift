//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Erva Hatun Tekeoğlu on 26.09.2023.
//

import SwiftUI

@main
struct NewsAppApp: App {
   
    var body: some Scene {
        WindowGroup {
            TabView {
                ArticleListView()
                    .tabItem {
                        Image(systemName: "house.circle.fill")
                    }
                    .tag(0)
                ZStack{
                    Text(" profiles")
                }
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                    }
                    .tag(1)
            }
        }
    }
}

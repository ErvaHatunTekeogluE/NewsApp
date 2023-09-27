//
//  ContentView.swift
//  NewsApp
//
//  Created by Erva Hatun Tekeoğlu on 26.09.2023.
//

import SwiftUI

struct ArticleListView: View {
    @StateObject var viewModel = ArticleListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.articles, id: \.self) { article in
                VStack {
                    Text(article.title ?? "")
                }
            }
        }
        .padding()
    }
}

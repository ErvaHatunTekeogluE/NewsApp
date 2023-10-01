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
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack {
                        SearchView(text: $viewModel.searchText)
                        List {
                            ForEach(viewModel.filteredArticles, id: \.self) { article in
                                VStack {
                                    if let urlToImage = article.urlToImage{
                                        AsyncImage(url: URL(string: urlToImage)!){ phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .cornerRadius(10)
                                            case .failure, .empty:
                                                Color.gray
                                            @unknown default:
                                                Color.gray
                                            }
                                        }
                                    }
                                    
                                    Text(article.title ?? "")
                                        .font(.body)
                                        .lineLimit(2)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(article.description ?? "")
                                        .font(.body)
                                        .lineLimit(3)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }.listStyle(PlainListStyle())
                    }.alert(viewModel.errorMessage, isPresented: $viewModel.showAlert) {}
                }
            }
            .padding(.zero)
            .task {
                await viewModel.getArticles()
            }
        }.padding(.zero)
    }
}


struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}

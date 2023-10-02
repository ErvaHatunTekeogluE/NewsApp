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
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack {
                        SearchView(text: $viewModel.searchText)
                        List {
                            ForEach(viewModel.filteredArticles, id: \.self) { article in
                                ZStack {
                                    NavigationLink(destination: ArticleDetailView(article: article)) {
                                    }.opacity(0.0)
                                    VStack {
                                        if let urlToImage = article.urlToImage,
                                           let url = URL(string: urlToImage) {
                                            AsyncImage(url: url) {image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .cornerRadius(10)
                                            } placeholder: {
                                                Image(systemName: "photo.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundColor(Color.gray.opacity(0.5))
                                                    .frame(width: 100, height: 100)
                                            }
                                        }
                                        
                                        Text(article.title ?? "")
                                            .font(.body)
                                            .lineLimit(2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding([.bottom,.top], 2)
                                        Text(article.description ?? "")
                                            .font(.body)
                                            .lineLimit(3)
                                            .foregroundColor(.gray)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
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

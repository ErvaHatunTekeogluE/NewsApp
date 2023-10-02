//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Erva Hatun Tekeoğlu on 2.10.2023.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: Article
    var body: some View {
        ScrollView {
            if let urlToImage = article.urlToImage,
               let url = URL(string: urlToImage) {
                AsyncImage(url: url) {image in
                    image
                        .resizable()
                        .scaledToFit()
                        //.cornerRadius(10)
                } placeholder: {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.gray.opacity(0.5))
                        .frame(width: 100, height: 100)
                }.padding([.leading,.trailing], 20)
            }
            
            Text(article.title ?? "")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.all)
            Text(article.description ?? "")
                .font(.body)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding([.leading,.trailing], 20)
        }.padding(.zero)
    }
}


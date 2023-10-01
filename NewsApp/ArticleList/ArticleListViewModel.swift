//
//  ArticleListViewModel.swift
//  NewsApp
//
//  Created by Erva Hatun Tekeoğlu on 27.09.2023.
//

import Foundation
import Combine
import UIKit

class ArticleListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = true
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var searchText = ""
    
    var cancellables = Set<AnyCancellable>()
    
    var filteredArticles: [Article] {
        if searchText.isEmpty {
            return articles // Return all articles if searchText is empty
        } else {
            return articles.filter { $0.title?.localizedCaseInsensitiveContains(searchText) == true }
        }
    }

    func getArticles() async {
        NetworkManager.shared.getArticles()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.isLoading = false
                    self?.showAlert = true
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { [weak self] news in
                self?.articles = news.articles.filter({$0.title != "[Removed]"})
                self?.isLoading = false
            } .store(in: &cancellables)
    }
    
//    func getArticles2() {
//        guard let url = NetworkManager.shared.getUrl() else {
//            return
//        }
//        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background)) // run subscriber background thread
//            .receive(on: DispatchQueue.main) // recive on main thread to be ensure UI updates are on the main thread
//            .tryMap { (data,response) -> Data in
//                guard let response = response as? HTTPURLResponse,
//                      response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(URLError.badServerResponse)
//                }
//                return data
//            }
//            .decode(type: News.self, decoder: JSONDecoder())
//            .sink {completion in
//                print("Completion: \(completion)")
//            } receiveValue: { [weak self] news in
//                self?.articles = news.articles
//            }.store(in: &cancellables)
//    }
}

//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Erva Hatun Tekeoğlu on 26.09.2023.
//

import Foundation
import Combine

public enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse(Data?, URLResponse?)
    case unknown
}

public enum Categories: String {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}

public enum EndpointType: String {
    case topHeadlines = "top-headlines"
    case everything = "everything"
}



class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = Config.apiKey
    private let baseURL = "https://newsapi.org/v2/"
    
    func getUrl(_ endpoint: EndpointType) -> URL? {
        guard let url = URL(string: baseURL.appending(endpoint.rawValue)) else {return nil}
        var queryItems: [URLQueryItem] = []
        switch endpoint {  
        case .everything:
            queryItems = [
                        URLQueryItem(name: "q", value: "tesla"),
                        URLQueryItem(name: "from", value: getDate()),
                        URLQueryItem(name: "sortBy", value: "publishedAt"),
                        URLQueryItem(name: "apiKey", value: apiKey)
                    ]
        case .topHeadlines:
            queryItems = [
                        //URLQueryItem(name: "sources", value: "bbc-news"),
                        URLQueryItem(name: "country", value: "us"),
                        URLQueryItem(name: "category", value: Categories.general.rawValue),
                        URLQueryItem(name: "apiKey", value: apiKey)
                    ]
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = queryItems
        return components.url
    }
    
    func getDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current
        if let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: Date()) {
            return dateFormatter.string(from: oneMonthAgo)
        }
        return dateFormatter.string(from: Date())
    }
    
    func getArticles() -> AnyPublisher<News, Error> {
        guard let url = NetworkManager.shared.getUrl(EndpointType.everything) else {
            return Fail<News, Error>(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main) // recive on main thread
            .map(\.data)
            .decode(type: News.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

//extension NetworkManager {
//    func fetchData(completionHandler: @escaping (_ news: News?, Error?) -> ()) {
//        guard let url = getUrl() else {
//            completionHandler(nil,NetworkError.invalidURL)
//            return
//        }
//        downloadData(fromURL: url) { data, error in
//            if let data = data {
//                let news = try? JSONDecoder().decode(News.self, from: data)
//                completionHandler(news, nil)
//            }
//            if let error = error {
//                completionHandler(nil, error)
//            }
//        }
//    }
//
//    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?, _ error: Error?) -> ()) {
//        URLSession.shared.dataTask(with: url) {data,response,error in
//            guard let data = data,
//                  error == nil,
//                  let response = response as? HTTPURLResponse,
//                  response.statusCode >= 200 && response.statusCode < 300 else {
//                completionHandler(nil, NetworkError.invalidResponse(nil, response))
//                    return
//            }
//            completionHandler(data, nil)
//        }.resume()
//    }
//}

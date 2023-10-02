//
//  SearchView.swift
//  NewsApp
//
//  Created by Erva Hatun Tekeoğlu on 1.10.2023.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    @State private var isSearching: Bool = false

    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(.leading, 5)
                .onChange(of: text) { _ in
                    // Handle text changes here
                    isSearching = true
                }
                .onSubmit {
                    // Handle search action here
                    isSearching = false
                }

            if isSearching {
                Button(action: {
                    text = ""
                    isSearching = false
                    // Clear the search text and dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .padding(.trailing, 8)
                        .transition(.move(edge: .trailing))
                }
            }
        }
        .frame(height: 40)
        .padding(.horizontal)
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .padding(.horizontal)
        .onTapGesture {
            isSearching = true
        }
    }
}


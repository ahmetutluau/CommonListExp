//
//  ContentView.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 29.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel(service: Networking())
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                Text(movie.title ?? "")
            }
            .onAppear {
                Task {
                    await viewModel.getNowPlaying()
                }
            }
            .navigationTitle("Now Playing")
        }
    }
}

#Preview {
    ContentView()
}

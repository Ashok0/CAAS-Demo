//
//  ContentView.swift
//  CATAAS API Demo
//
//  Created by Andrew Moore on 11/10/22.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 320, height: 240)
                .background(Color.gray)
        }
        else {
            Image(systemName: "applelogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 320, height: 240)
                .background(Color.gray)
                .onAppear {
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url  = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data,
            _, _ in
            self.data = data
        }
        
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.myimages, id: \.self) { myimage in
                     HStack {
                         URLImage(urlString: "https://cataas.com/cat/" + myimage._id)
                     }
                     .padding(3)
                }
            }
            .navigationTitle("My Cat Images")
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

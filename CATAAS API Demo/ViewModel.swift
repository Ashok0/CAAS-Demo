//
//  ViewModel.swift
//  CATAAS API Demo
//
//  Created by Andrew Moore on 11/10/22.
//

import Foundation
import SwiftUI

struct MyImage: Hashable, Codable {
    let _id: String
}

class ViewModel: ObservableObject {
    
    @Published var myimages: [MyImage] = []
    
    func fetch(){
        guard let url = URL(string: "https://cataas.com/api/cats?tags=#christmascat") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let myimages = try JSONDecoder().decode([MyImage].self, from:data)
                DispatchQueue.main.async {
                    self?.myimages = myimages
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

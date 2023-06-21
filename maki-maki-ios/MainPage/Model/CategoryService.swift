//
//  CategoryService.swift
//  maki-maki-ios
//
//  Created by Ravil on 21.06.2023.
//

import Foundation

class CategoryService {
    
    private var urlSession = URLSession.shared
    var category: [CategoryModel] = []
    
    func fetchCategory() {
        let urlString = "https://app.makimaki.kz/api/v1/client/categories"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let task = urlSession.dataTask(with: request, completionHandler: { data, _, error in
            guard let data = data else {
                fatalError("Data not found")
            }
            
            do {
                let category = try JSONDecoder().decode([CategoryModel].self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.category = category
                }
            } catch let error {
                print("Error:\(error.localizedDescription)")
            }
        }
        )
        task.resume()
    }
}

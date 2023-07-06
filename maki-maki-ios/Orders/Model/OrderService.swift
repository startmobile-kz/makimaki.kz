//
//  OrderService.swift
//  maki-maki-ios
//
//  Created by Нұрмұхан Дәукес on 05.07.2023.
//

import Foundation

// MARK: - Network request for products

 class OrderService {
    
    private var urlSession = URLSession.shared
    
//    var backendOrders: [OrdersModel] = []
//
//    var ordersVC = OrdersViewController()

    // MARK: - Load Data
    // swiftlint:disable all
     func getOrders(completion: @escaping ([OrdersModel]) -> Void) {
        let urlString = "https://app.makimaki.kz/api/v1/client/orders?uuid=151eb4a0-ff99-4482-90d2-c4e7c77810dc"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request, completionHandler: { data, _, error in
            guard let data = data else {
                    fatalError("Data not found")
            }
                
//                let decoder = JSONDecoder()
//
//                if let orders = try? decoder.decode([OrdersModel].self, from: data) {
//                    DispatchQueue.main.async { [weak self] in
//                        self?.backendOrders = orders
//                        self?.ordersVC.ordersTableView.reloadData()
//                    }
//                }
            
            do {
                let order = try JSONDecoder().decode([OrdersModel].self, from: data)
                completion(order)
                print(order)
            } catch let error {
                print("Error:\(error.localizedDescription)")
                completion([])
            }
        }
        )
        
        task.resume()
    }
    // swiftlint:enable all
 }

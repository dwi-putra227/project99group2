//
//  EstateViewModel.swift
//  project99group2
//
//  Created by Putra  on 05/11/24.
//

import Foundation

class EstateViewModel {
    var estates: [Estate] = []
    
    func fetchProperties() async {
        let urlString = "https://ninetyninedotco-b7299.asia-southeast1.firebasedatabase.app/listings.json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        do {
            print("Fetching data from URL: \(urlString)")
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let estates = try decoder.decode([Estate].self, from: data)
            self.estates = estates
            print("Data fetched successfully: \(estates)")
        } catch {
            print("Failed to fetch properties: \(error)")
        }
    }
}

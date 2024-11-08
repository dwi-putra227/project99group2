import Foundation

class EstateDetailViewModel {
    var estateDetail: EstateDetail?
    
    func fetchEstateDetail(for id: Int) async {
        let urlString = "https://ninetyninedotco-b7299.asia-southeast1.firebasedatabase.app/details/0.json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        do {
            print("Fetching data from URL: \(urlString)")
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Fetched JSON data: \(jsonString)")
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let estate = try decoder.decode(EstateDetail.self, from: data)
            self.estateDetail = estate
            print("Data fetched successfully: \(estate)")
        } catch {
            print("Failed to fetch properties: \(error)")
        }
    }
}



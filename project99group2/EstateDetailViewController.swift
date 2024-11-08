//
//  EstateDetailViewController.swift
//  project99group2
//
//  Created by Putra  on 08/11/24.
//

import UIKit

class EstateDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var priceDetail: UILabel!
    @IBOutlet weak var projectDetail: UILabel!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var subtitleDetail: UILabel!
    @IBOutlet weak var bedroomsDetail: UILabel!
    @IBOutlet weak var bathroomsDetail: UILabel!
    @IBOutlet weak var areaSizeDetail: UILabel!
    @IBOutlet weak var descriptionDetaik: UILabel!
    @IBOutlet weak var mapCoordinateDetail: UILabel!
    
    
    var estateId: Int?
    var estateDetail: EstateDetail?

        // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        tableView.delegate = self
        tableView.dataSource = self
        
        Task {
            await fetchEstateDetail(id: 0)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openInMaps))
        mapCoordinateDetail.isUserInteractionEnabled = true
        mapCoordinateDetail.addGestureRecognizer(tapGesture)
    }
    
    private func configureView() {
        guard let estateDetail = estateDetail else { return }
        guard estateDetail.address.mapCoordinates != nil else { return }
        projectDetail.text = estateDetail.projectName
        titleDetail.text = estateDetail.address.title
        subtitleDetail.text = estateDetail.address.subtitle
        descriptionDetaik.text = estateDetail.description
        
        if let descriptionText = estateDetail.description {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            paragraphStyle.hyphenationFactor = 1.0
            paragraphStyle.lineSpacing = 6
            paragraphStyle.paragraphSpacing = 10
            
            let attributedString = NSAttributedString(
                string: descriptionText,
                attributes: [.paragraphStyle: paragraphStyle,]
            )
            
            descriptionDetaik.attributedText = attributedString
        }
        
        priceDetail.text = (estateDetail.attributes.price != nil) ? "$\(estateDetail.attributes.price!)" : "kosong"
        bedroomsDetail.text = (estateDetail.attributes.bedrooms != nil) ? "\(estateDetail.attributes.bedrooms!) Beds" : "kosong"
        bathroomsDetail.text = (estateDetail.attributes.bathrooms != nil) ? "\(estateDetail.attributes.bathrooms!) Baths" : "kosong"
        areaSizeDetail.text = (estateDetail.attributes.areaSize != nil) ? "\(estateDetail.attributes.areaSize!) sqft" : "kosong"
        mapCoordinateDetail.text = "View on map"
        
        loadImage(from: estateDetail.photo)
    }
    
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.imageDetail.image = UIImage(data: data)
                }
            }
        }
    }
    
    @objc private func openInMaps() {
        guard let coordinates = estateDetail?.address.mapCoordinates else { return }
        
        let latitude = coordinates.lat
        let longitude = coordinates.lng
        let urlString = "http://maps.apple.com/?ll=\(String(describing: latitude)),\(String(describing: longitude))"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let propertyDetails = estateDetail?.propertyDetails else { return 0 }
        let rowCount = estateDetail?.propertyDetails?.count ?? 0
        return propertyDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EstateDetailTableViewCell", for: indexPath) as! EstateDetailTableViewCell
        
        cell.selectionStyle = .none
        
        if let propertyDetail = estateDetail?.propertyDetails {
            let detail = propertyDetail[indexPath.row]
            cell.configure(with: detail)
        }
        
        return cell
    }
    
    private func fetchEstateDetail(id: Int) async {
        
        guard let url = URL(string: "https://ninetyninedotco-b7299.asia-southeast1.firebasedatabase.app/details/0.json") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            estateDetail = try decoder.decode(EstateDetail.self, from: data)
            
            DispatchQueue.main.async {
                self.configureView()
                self.tableView.reloadData()
            }
        } catch {
            print("Failed to load data: \(error)")
        }
    }
}

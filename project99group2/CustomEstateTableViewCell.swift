//
//  CustomEstateTableViewCell.swift
//  project99group2
//
//  Created by Putra  on 05/11/24.
//

import UIKit

class CustomEstateTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImgView: UIImageView!
    @IBOutlet weak var projectNameLbl: UILabel!
    @IBOutlet weak var streetNameLbl: UILabel!
    @IBOutlet weak var districtLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var completedAtLbl: UILabel!
    @IBOutlet weak var tenureLbl: UILabel!
    @IBOutlet weak var bedroomsLbl: UILabel!
    @IBOutlet weak var bathroomsLbl: UILabel!
    @IBOutlet weak var areaSizeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundedImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func roundedImageView() {
        photoImgView.layer.cornerRadius = 5
        photoImgView.clipsToBounds = true
    }
    
    func configure(with estate: Estate) {
        projectNameLbl.text = "\(estate.projectName ?? "Project name")"
        streetNameLbl.text = estate.address.streetName ?? "No Street Name"
        districtLbl.text = estate.address.district ?? "No District"
        categoryLbl.text = estate.category ?? "No Category"
        completedAtLbl.text = estate.completedAt ?? "Unknown Year"
        tenureLbl.text = "\(estate.tenure ?? 0) Years"
        bedroomsLbl.text = "\(estate.attributes.bedrooms ?? 0) Beds"
        bathroomsLbl.text = "\(estate.attributes.bathrooms ?? 0) Baths"
        areaSizeLbl.text = "\(estate.attributes.areaSize ?? 0) sqft"
        priceLbl.text = "$\(estate.attributes.price ?? 0)/mo"
        
        if let url = URL(string: estate.photo) {
            DispatchQueue.global().async{
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async{
                        self.photoImgView.image = UIImage(data: data)
                    }
                }
            }
        }
    }

}

//
//  EstateDetailTableViewCell.swift
//  project99group2
//
//  Created by Putra on 08/11/24.
//

import UIKit

class EstateDetailTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var textDetail: UILabel!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        // MARK: - Configuration
    func configure(with propertyDetail: EstateDetail.PropertyDetail) {
        labelDetail.text = propertyDetail.label ?? "kosong"
        textDetail.text = propertyDetail.text ?? "kosong"
    }
    
    
}

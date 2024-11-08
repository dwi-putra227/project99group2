//
//  EstateViewController.swift
//  project99group2
//
//  Created by Putra  on 05/11/24.
//

import UIKit

class EstateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var estateViewModel = EstateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        Task {
            await fetchData()
        }
    }
    
    private func fetchData() async {
        await estateViewModel.fetchProperties()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return estateViewModel.estates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomEstateTableViewCell", for: indexPath) as! CustomEstateTableViewCell
        
        let estate = estateViewModel.estates[indexPath.row]
        cell.configure(with: estate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "ThroughSegue", sender: indexPath)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ThroughSegue" {
            if let indexPath = sender as? IndexPath {
                let selectedEstate = estateViewModel.estates[indexPath.row]
                
                // Mengirimkan ID dari Estate
                if let detailVC = segue.destination as? EstateDetailViewController {
                    detailVC.estateId = selectedEstate.id
                }
            }
        }
    }


}



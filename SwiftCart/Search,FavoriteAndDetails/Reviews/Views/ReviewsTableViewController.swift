//
//  ReviewsTableViewController.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 13/06/2024.
//

import UIKit

class ReviewsTableViewController: UITableViewController {
    
    let viewModel = ReviewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader()
        viewModel.getReviewsForProduct()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as! ReviewsTableViewCell
        cell.userName.text = viewModel.reviews[indexPath.row].userName
        cell.message.text = viewModel.reviews[indexPath.row].message
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func setHeader() {
        let settingsLabel = UILabel()
        settingsLabel.text = "Reviews"
        settingsLabel.textColor = .systemPink
        settingsLabel.font = .boldSystemFont(ofSize: 25)
        settingsLabel.sizeToFit()
        self.navigationItem.titleView = settingsLabel
    }
}

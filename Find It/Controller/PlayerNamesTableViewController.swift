//
//  PlayerNamesTableViewController.swift
//  Find It
//
//  Created by Xcho on 16.01.22.
//

import UIKit

class PlayerNamesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

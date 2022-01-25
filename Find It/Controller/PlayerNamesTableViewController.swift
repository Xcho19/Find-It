//
//  PlayerNamesTableViewController.swift
//  Find It
//
//  Created by Xcho on 16.01.22.
//

import UIKit

protocol PlayerNamesDelegate: AnyObject {
    func didTapSave(playernames: [String])
}

class PlayerNamesTableViewController: UITableViewController {
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    let numberOfPlayers: Int
    
    init?(coder: NSCoder, numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int { numberOfPlayers }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         tableView.dequeueReusableCell(withIdentifier: "AddPlayerTableViewCell", for: indexPath)
     }
    @IBAction func playerNameEdited(_ sender: UITextField) {
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

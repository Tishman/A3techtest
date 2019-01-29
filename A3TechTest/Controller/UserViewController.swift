//
//  UserViewController.swift
//  A3TechTest
//
//  Created by Роман Тищенко on 22/01/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import UIKit

class UserViewController: UITableViewController {

    private var usersDataList = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsersData()
    }
    
    private func getUsersData() {
        DataService.getUsers { (result) in
            switch result {
            case .SuсcesGetUsersRequest(let users):
                self.usersDataList = users
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .LocalFailure(let message):
                DispatchQueue.main.async {
                    self.showAlertMessage(message: message)
                }
            default:
                print("User: Switch default detected")
                break
            }
        }
    }
    
    private func showAlertMessage(message: String) {
        let infoAlert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        infoAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(infoAlert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let photoViewController = segue.destination as! PhotoViewController
            photoViewController.userId = usersDataList[selectedRow].id
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersDataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell_ID") as! UserTableViewCell
        userTableViewCell.setUpCellStyle()
        userTableViewCell.updateCell(user: usersDataList[indexPath.row])
        return userTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowPhoto", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

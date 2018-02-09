//
//  SchoolsTableViewController.swift
//  NYC Schools
//
//  Created by Jason Lu on 2/7/18.
//  Copyright © 2018 Jason Lu. All rights reserved.
//

import UIKit

class SchoolsTableViewController: UITableViewController {
    let schoolCellIdentifier = "schoolIdentifier"
    let schoolDetailSegue = "ShowDetailSegue"
    var schoolsArray: [School] = []
    
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        if (schoolsArray.count == 0) {
            tableView.separatorStyle = .none
            activityIndicator.startAnimating()
        }
        tableView.backgroundView = activityIndicator
        getAllSchools()
    }
    
    /// Function to get all an array of all the school names in the database. Then reloads the tableview upon completion.
    func getAllSchools() {
        School.allSchools { [weak self] (schools, error) in
            if let error = error {
                print(error)
                return
            }
            guard let schools = schools else {
                print("error getting schools")
                return
            }
            self?.schoolsArray = schools
            DispatchQueue.main.async {
                self?.tableView.separatorStyle = .singleLine
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return schoolsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: schoolCellIdentifier, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = schoolsArray[indexPath.row].school_name

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == schoolDetailSegue, let destination = segue.destination as? SchoolDetailViewController, let index = tableView.indexPathForSelectedRow?.row {
            destination.schoolName = schoolsArray[index].school_name
            destination.dbn = schoolsArray[index].dbn
            destination.summary = schoolsArray[index].overview_paragraph
            print(schoolsArray[index].school_name)
        }
    }
    

}

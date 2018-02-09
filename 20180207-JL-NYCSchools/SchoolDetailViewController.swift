//
//  SchoolDetailViewController.swift
//  NYC Schools
//
//  Created by Jason Lu on 2/7/18.
//  Copyright © 2018 Jason Lu. All rights reserved.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var numTakersLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    var dbn: String?
    var schoolName: String?
    var summary: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dbn = dbn, let schoolName = schoolName {
            schoolNameLabel.text = schoolName + "'s SAT Scores"
            getSchoolDetail(dbn)
            summaryTextView.text = summary
        }
        // Do any additional setup after loading the view.
    }

    /// Grabs the school detail and asynchronously updates the UI with the parsed data. Because the data is an array of one object,
    /// we access the 0 element. Given more time, I would have constructed a better model to parse the data as a single object so I don't have
    /// to access the 0 element.
    /// - Parameter name: name of the school to grab details from.
    func getSchoolDetail(_ dbn: String) {
        SchoolDetail.schoolByName(dbn, completionHandler: { [unowned self] (schoolDetail, error) in
            if let error = error {
                print(error)
                return
            }
            guard let schoolDetail = schoolDetail else {
                print("error getting school detail")
                return
            }
            print(schoolDetail)
            guard schoolDetail.count > 0 else { return }
            DispatchQueue.main.async {
                self.mathLabel.text = schoolDetail[0].sat_math_avg_score
                self.readingLabel.text = schoolDetail[0].sat_critical_reading_avg_score
                self.writingLabel.text = schoolDetail[0].sat_writing_avg_score
                self.numTakersLabel.text = schoolDetail[0].num_of_sat_test_takers
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

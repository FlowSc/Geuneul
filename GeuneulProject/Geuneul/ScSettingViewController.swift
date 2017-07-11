//
//  ScSettingViewController.swift
//  Geuneul
//
//  Created by Kang Seongchan on 2017. 7. 11..
//  Copyright © 2017년 Kang Seongchan. All rights reserved.
//

import UIKit

class ScSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingSwitchDelegate {

    @IBOutlet weak var scTableView: UITableView!
    override func viewDidLoad() {
        
    
        super.viewDidLoad()
        
        scTableView.reloadData()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCenter.shared.rowCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celltype = DataCenter.shared.cellTypeFor(indexPath: indexPath)
        
        switch celltype {
        case .basic:
            let cell = tableView.dequeueReusableCell(withIdentifier: celltype.rawValue, for: indexPath)
            cell.textLabel?.text = DataCenter.shared.titleFor(rowAtIndexPath: indexPath)
            return cell

        case .switchCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: celltype.rawValue, for: indexPath) as! SwitchTableViewCell
            
            cell.delegate = self
            
            return cell
        }
        
    }
    func loginValueChanged(_ cell: SwitchTableViewCell, value: Bool) {
        if value == true {
            UserDefaults.standard.set(true, forKey: "autoLogin")
            print(UserDefaults.standard.bool(forKey: "autoLogin"))
        }else{
            UserDefaults.standard.set(false, forKey: "autoLogin")
            print(UserDefaults.standard.bool(forKey: "autoLogin"))

        }
    }

    
    @IBAction func backButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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

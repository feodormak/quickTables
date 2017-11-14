//
//  ViewController.swift
//  quickTables
//
//  Created by feodor on 13/11/17.
//  Copyright © 2017 feodor. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UITableViewController {

    let text = "<table><tr><td>11</td><td>12</td><td>13</td></tr><tr><td>21</td><td>22</td><td>23</td></tr></table>"
    var tableData = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.identifier)
        
        do {
            let doc = try HTML(html: text, encoding: .utf8)
            if let body = doc.body {
                for row in body.css("tr") {
                    var subArray = [String]()
                    for cell in row.css("td") {
                        if cell.content != nil { subArray.append(cell.content!) }
                    }
                    tableData.append(subArray)
                }
            }
        }
        catch {}
     
        self.tableView.tableFooterView = UIView()
        self.view.backgroundColor = .gray
        print(tableData)
        

    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath)
        return cell
        
    }
    


}


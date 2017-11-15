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
    
    //let text = "<table><tr><td>11</td><td>12</td><td>13</td></tr><tr><td>21</td><td>22</td><td>23</td></tr></table>"
    
    let text = "<table><tr><td><b>Airport</b></td><td><b>Airport Code (ICAO / IATA)</b></td></tr><tr><td>Bangalore</td><td>VOBG / BLR</td></tr><tr><td>Bangkok</td><td>VTBS / BKK</td></tr><tr><td>Broome</td><td>YBRM / BME</td></tr><tr><td><b>Chennai</b></td><td><b>VOMM / MAA</b></td></tr><tr><td>Chiang Mai</td><td>VTCC / CNX</td></tr><tr><td>Colombo</td><td>VCBI / CMB</td></tr><tr><td>Curtin</td><td>YCIN / DCN</td></tr><tr><td><b>Darwin</b></td><td><b>YPDN / DRW</b></td></tr><tr><td>Denpasar (Bali)</td><td>WADD / DPS</td></tr><tr><td><b>Hyderabad</b></td><td><b>VOHS / HYD</b></td></tr><tr><td><b>Kochi</b></td><td><b>VOCI / COK</b></td></tr><tr><td><b>Kuala Lumpur</b></td><td><b>WMKK / KUL</b></td></tr><tr><td>Kupang</td><td>WATT / KOE</td></tr><tr><td>Langkawi</td><td>WMKL / LGK</td></tr><tr><td>Lombok</td><td>WADL / LOP</td></tr><tr><td>Male</td><td>VRMM / MLE</td></tr><tr><td><b>Medan</b></td><td><b>WIMM / KNO</b></td></tr><tr><td>Penang</td><td>WMKP / PEN</td></tr><tr><td><b>Phuket</b></td><td><b>VTSP / HKT</b></td></tr><tr><td>Port Hedland</td><td>YPPD / PHE</td></tr><tr><td>Singapore</td><td>WSSS / SIN</td></tr><tr><td>Surabaya</td><td>WARR / SUB</td></tr><tr><td>Tindal</td><td>YPTN / KTR</td></tr><tr><td><b>Trivandrum</b></td><td><b>VOTV / TRV</b></td></tr><tr><td><b>Ujung Pandang (Makassar)</b></td><td><b>WAAA / UPG</b></td></tr><tr><td>Vishakhapatnam</td><td>VOVZ / VTZ</td></tr><tr><td>Yangon</td><td>VYYY / RGN</td></tr></table>"
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
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.view.backgroundColor = .gray
        
        print(self.view.frame.width)
        //print(tableData)
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell{
            cell.data = self.tableData
            print(cell.frame.width)
            return cell
        }
        else { return UITableViewCell() }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}

extension UILabel {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</span>" as NSString, htmlText) as String
        
        
        //process collection values
        let attrStr = try! NSMutableAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        if attrStr.string.hasSuffix("\n") {
            attrStr.mutableString.deleteCharacters(in: attrStr.mutableString.rangeOfComposedCharacterSequence(at: attrStr.mutableString.length - 1))
            //attrStr.mutableString.setString(attrStr.string.substring(to: attrStr.string.index(attrStr.string.endIndex, offsetBy: -1)))
        }
        
        self.attributedText = attrStr
        
    }
}

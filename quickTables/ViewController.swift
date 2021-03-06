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
    
    let text2 = "<table><tr><td style= \"background-color:  #bdc3c7  \"><p style=color:white><b>Airport</b></td><td style=background-color:#bdc3c7><p style=color:white><b>Airport Code (ICAO / IATA)</b></td></tr><tr><td>Bangalore</td><td>VOBG / BLR</td></tr><tr><td>Bangkok</td><td>VTBS / BKK</td></tr><tr><td>Broome</td><td>YBRM / BME</td></tr><tr><td><b>Chennai</b></td><td><b>VOMM / MAA</b></td></tr><tr><td>Chiang Mai</td><td>VTCC / CNX</td></tr><tr><td>Colombo</td><td>VCBI / CMB</td></tr><tr><td>Curtin</td><td>YCIN / DCN</td></tr><tr><td><b>Darwin</b></td><td><b>YPDN / DRW</b></td></tr><tr><td>Denpasar (Bali)</td><td>WADD / DPS</td></tr><tr><td><b>Hyderabad</b></td><td><b>VOHS / HYD</b></td></tr><tr><td><b>Kochi</b></td><td><b>VOCI / COK</b></td></tr><tr><td><b>Kuala Lumpur</b></td><td><b>WMKK / KUL</b></td></tr><tr><td>Kupang</td><td>WATT / KOE</td></tr><tr><td>Langkawi</td><td>WMKL / LGK</td></tr><tr><td>Lombok</td><td>WADL / LOP</td></tr><tr><td>Male</td><td>VRMM / MLE</td></tr><tr><td><b>Medan</b></td><td><b>WIMM / KNO</b></td></tr><tr><td>Penang</td><td>WMKP / PEN</td></tr><tr><td><b>Phuket</b></td><td><b>VTSP / HKT</b></td></tr><tr><td>Port Hedland</td><td>YPPD / PHE</td></tr><tr><td>Singapore</td><td>WSSS / SIN</td></tr><tr><td>Surabaya</td><td>WARR / SUB</td></tr><tr><td>Tindal</td><td>YPTN / KTR</td></tr><tr><td><b>Trivandrum</b></td><td><b>VOTV / TRV</b></td></tr><tr><td><b>Ujung Pandang (Makassar)</b></td><td><b>WAAA / UPG</b></td></tr><tr><td>Vishakhapatnam</td><td>VOVZ / VTZ</td></tr><tr><td>Yangon</td><td>VYYY / RGN</td></tr></table>"
    
    //let text3 = "<table><tr><td>1111111111111</td><td>12</td><td>13</td></tr><tr><td>21</td><td>22</td><td>23133213231231</td></tr></table>"
    //let text4 = "<table><tr><td><b>AIRSPACE RNP</b></td><td><b>Requirement</b></td></tr><tr><td>Australia</td><td>10</td></tr><tr><td>Australia Eastern Oceanic Area</td><td>4</td></tr><tr><td>Bay of Bengal</td><td>10</td></tr><tr><td>China (only within Sanya AOR)</td><td>10</td></tr><tr><td>Hong Kong</td><td>4 or 10*</td></tr><tr><td>India</td><td>10**</td></tr><tr><td>Indonesia</td><td>10</td></tr><tr><td>Malaysia</td><td>10</td></tr><tr><td>South China Sea</td><td>10</td></tr><tr><td>Thailand &amp; Vietnam</td><td>10</td></tr></tbody></table>"
    
    //let text5 = "<table><tr><td>ATS DATALINK PROVIDER</td><td>LOGON ADDRESS</td><td>AREA OF OPERATION</td><td>DATALINK POSITION REPORT</td><td>DATALINK SERVICE AVAILABLE</td></tr><tr><td>SINGAPORE</td><td>WSJC</td><td>SIN FIR over South China Sea</td><td>At Compulsory* Reporting Points</td><td>CPDLC ADS</td></tr><tr><td>YANGON</td><td>VYYF</td><td>Within YANGON FIR</td><td>At Compulsory* Reporting Points</td><td>CPDLC ADS</td></tr><tr><td>COLOMBO</td><td>VCCF</td><td>Within COLOMBO FIR</td><td>At Compulsory* Reporting Points</td><td>CPDLC ADS</td></tr><tr><td>CHENNAI</td><td>VOMF</td><td>Within CHENNAI FIR</td><td>At Compulsory* Reporting Points</td><td>CPDLC ADS</td></tr><tr><td>KOLKATA</td><td>VECF</td><td>Within KOLKATA FIR</td><td>At Compulsory* Reporting Points</td><td>CPDLC ADS</td></tr><tr><td>FUKUOKA</td><td>RJJJ</td><td>Within FUKUOKA FIR</td><td>At Compulsory* Reporting Points</td><td>CPDLC ADS</td></tr><tr><td>HONG KONG</td><td>VHHH</td><td>Within HONG KONG FIR</td><td>At Compulsory* Reporting Points</td><td>CPDLC ADS</td></tr><tr><td>UJUNG PANDANG</td><td>WAAF</td><td>Within UJUNG PANDANG FIR</td><td>At Compulsory* Reporting Points</td><td>CPDLC ADS</td></tr><tr><td>HO CHI MINH</td><td>WAAF</td><td>Within HO CHI MINH FIR</td><td>At Compulsory* Reporting Points</td><td>CPDLC ADS</td></tr></table>"
    
    /*
    let text = [["11231231", "dshsdfg" ,"2" ,"fhdshdh"],
                ["ncvbjd","44ghj","wertwetw43t3","gsdgg"],
                ["rtu46 u6rhtr u","cdyk gst se ","sgdf","8 ds fd f"],
                ["i6r7 es5yr","s ftrueb", "5se64","453e"],
                [" a5y35y4","a yaye"," d8ut yert ","7 5ysdr"],
                ["s 45y4 s4","s e5yse"," sey s45y","s 53ys"]]
    let text2 = [["342","32452","fgdhfu"],
                 ["aaaaaaaaaaaaaaa","dddddddd","d"],
                 ["a","b","c"],
                 ["asdf","adfa","adfa"],
                 ["atvegav","avtawtv","a4ta34tva"],
                 ["z34v3","z z 4t34 3","vzv grd yey"],
                 ["fgfdhd","zvgsdvgz","sdfgsdfvgsd"],
                 ["sgvfdsvgd","sdgsvdvd","dsgsvf"],
                 ["sfsddfs","svdgf","sdfsfdvs"],
                 ["sdfgsd d","sdfgs d","svfgvdfv"],
                 ["vsdfvgsd","svfsddv","sdvfgvdfv"],
                 ["sdgfdgs","sdvfdvgdv","svfsdgvd"],
                 ["sdgds","dgfsd","sdgdfsg"],
                 ["g","sgfdsd","sdfgsd"],
                 ["g","fgsg","dsfgfds"],
                 ["sdg","segsd  sgfs","664356345"]]
       */
    
    var tableData = [[[NSAttributedString]]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(QuickTable.nib, forCellReuseIdentifier: QuickTable.identifier)
        /*
        let path = Bundle.main.url(forResource: "test", withExtension: "css")
        let css = SwiftCSS(CssFileURL: path!)
        let table = css.double(selector: "#tableborder", key: "width")
        print(table)
        */
        
        for textToProcess in [text, text2]{
            var subArray = [[NSAttributedString]]()
            /*
            for row in textToProcess {
                var subsubArrary = [NSMutableAttributedString]()
                for cell in row { subsubArrary.append(NSMutableAttributedString.init(string: cell)) }
                subArray.append(subsubArrary)
            }
            */
            
            do {
                let doc = try HTML(html: textToProcess, encoding: .utf8)
                
                if let body = doc.body {
                    
                    for row in body.css("tr") {
                        var subsubArray = [NSAttributedString]()
                        for cell in row.css("td") {
                            if let cellStyle = cell["style"] {
                                print(cellStyle, cellStyle.count)
                            }
                            
                            if let cellData = cell.innerHTML { subsubArray.append(cellData.attributedStringFromHTMLString()) }
                        }
                        subArray.append(subsubArray)
                    }
                }
            }
            catch {}
            tableData.append(subArray)
        }
        
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.view.backgroundColor = .gray
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: QuickTable.identifier, for: indexPath) as? QuickTable{
            cell.setupTable(width: tableView.frame.width, data: self.tableData[indexPath.row%2])
            return cell
        }
        else { return UITableViewCell() }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}

extension String {
    func attributedStringFromHTMLString() ->NSAttributedString {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'\">%@</span>" as NSString, self) as String
        let attrStr = try! NSMutableAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        if attrStr.string.hasSuffix("\n") {
            attrStr.mutableString.deleteCharacters(in: attrStr.mutableString.rangeOfComposedCharacterSequence(at: attrStr.mutableString.length - 1))
         }
        return attrStr
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

//
//  TableCell.swift
//  testPad
//
//  Created by feodor on 13/8/17.
//  Copyright © 2017 feodor. All rights reserved.
//

import UIKit

class TableCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var changeLine: UIView!
    @IBOutlet weak var cellLabelWidth: NSLayoutConstraint!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    class func fromNib() -> TableCell? {
        var cell: TableCell?
        let nibViews = Bundle.main.loadNibNamed(TableCell.identifier, owner: nil, options: nil)
        for nibView in nibViews! {
            if let cellView = nibView as? TableCell { cell = cellView }
        }
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellLabel.text = nil
        changeLine.backgroundColor = .clear
    }
}


//
//  File.swift
//  quickTables
//
//  Created by feodor on 14/11/17.
//  Copyright © 2017 feodor. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet private weak var tableCollectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    
    //constants
    private let leftSpacing: CGFloat = 1.0
    
    var data: [[String]]? {
        didSet {
            if data != nil {
                self.tableSizing()
                self.collectionViewHeight.constant = 1.0 + CGFloat(data!.count) * (30.0 + 1.0)
            }
            
        }
    }
    private var cellMaxWidths = [CGFloat]()
    private var actualWidths = [CGFloat]()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableCollectionView.register(TableCell.nib, forCellWithReuseIdentifier: TableCell.identifier)
        tableCollectionView.dataSource = self
        tableCollectionView.delegate = self
        tableCollectionView.backgroundColor = UIColor.black
        tableCollectionView.isUserInteractionEnabled = false
        
        print(self.frame.width)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellMaxWidths.removeAll()
        self.leadingConstraint.constant = 2.0
        self.trailingConstraint.constant = 2.0
        
        
    }
    
    
    
    //this is ROWS
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if data != nil { return self.data!.count }
        else { return 0 }
    }
    
    //this is COLUMNS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        if data != nil {
            cell.cellLabel.text = data![indexPath.section][indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellMaxWidths[indexPath.row], height: 30)
    }
    
    
    
    private func tableSizing() {
        guard data != nil else {
            return
        }
        for row  in data! {
            for (index, cell) in row.enumerated() {
                let width = self.maximumLabelWidth(text: cell)
                if cellMaxWidths.count < data![0].count { cellMaxWidths.append(width) }
                else if width > cellMaxWidths[index]{ cellMaxWidths[index] = width }
            }
        }

        print(self.frame.width, tableCollectionView.frame.width, cellMaxWidths.reduce(0, +))
        if cellMaxWidths.reduce(0, +) <= tableCollectionView.frame.width - (CGFloat(cellMaxWidths.count + 1) * leftSpacing) {
            let totalSpacing = CGFloat(cellMaxWidths.count+1) * leftSpacing
            //print(tableCollectionView.frame.width, cellMaxWidths.reduce(0, +), newConstraintConstant)
            self.leadingConstraint.constant = (self.tableCollectionView.frame.width -  totalSpacing - cellMaxWidths.reduce(0, +)) / 2
            self.trailingConstraint.constant = (self.tableCollectionView.frame.width -  totalSpacing - cellMaxWidths.reduce(0, +)) / 2
        }
        
    }
    
    private func maximumLabelWidth(text: String)-> CGFloat {
        let label = UILabel()
        label.text = text
        return label.textRect(forBounds: CGRect(x: 0, y:0, width:self.frame.width, height: 50), limitedToNumberOfLines: 1).width
    }
}

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
    @IBOutlet weak var tableCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    
    //constants
    private let leftSpacing: CGFloat = 1.0
    private let defaultSpacing: CGFloat = 2.0
    private let tabellCellLabelSpacing:CGFloat = 4.0
    private let minRowHeight:CGFloat = 30
    
    var data: [[NSAttributedString]]? {
        didSet { if data != nil { tableCollectionView.reloadData() } }
    }
    var parentWidth: CGFloat? {
        didSet{
            if parentWidth != nil { self.tableSizing(parentWidth: parentWidth!) }
        }
    }
    private var cellMaxWidths = [CGFloat]()
    private var rowHeights = [CGFloat]()
    private var tableHeight:CGFloat = 1
    
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
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellMaxWidths.removeAll()
        self.rowHeights.removeAll()
        self.tableHeight = 1
        self.data = nil
        
        self.leadingConstraint.constant = defaultSpacing
        self.trailingConstraint.constant = defaultSpacing
    }
    
    //this is ROWS
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if data != nil { return self.data!.count }
        else { return 0 }
    }
    
    //this is COLUMNS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if data != nil {
            if data!.first != nil { return self.data!.first!.count }
            else { return 0 }
        }
        else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCell.identifier, for: indexPath) as? TableCell {
            if data != nil {
                cell.cellLabel.attributedText = data![indexPath.section][indexPath.row]
                return cell
            }
            return UICollectionViewCell()
        }
        else { return UICollectionViewCell() }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellMaxWidths[indexPath.row], height: rowHeights[indexPath.section])
    }
    
    private func tableSizing(parentWidth: CGFloat) {
        //print("before", self.frame.width, tableCollectionView.frame.width, cellMaxWidths.reduce(0, +))
        self.getCellMaxWidths()
        
        if cellMaxWidths.reduce(0, +) <= parentWidth - (2 * defaultSpacing) - (CGFloat(cellMaxWidths.count + 1) * leftSpacing) {
            let totalSpacing = CGFloat(cellMaxWidths.count+1) * leftSpacing
            let newConstraintConstant = (parentWidth -  totalSpacing - cellMaxWidths.reduce(0, +)) / 2
            self.leadingConstraint.constant = newConstraintConstant
            self.trailingConstraint.constant = newConstraintConstant
            //print("contraint: \(newConstraintConstant)")
        }
        else{
            let totalRequiredWidth = self.cellMaxWidths.reduce(0, +)
            let useableWidthForCells = parentWidth - (2 * defaultSpacing) - CGFloat(self.cellMaxWidths.count + 1) * leftSpacing
            for (index, cell) in cellMaxWidths.enumerated() { self.cellMaxWidths[index] = round((cell / totalRequiredWidth * useableWidthForCells) * 10)/10 }
            //print(cellMaxWidths)
        }
        //print("after", self.frame.width, tableCollectionView.frame.width, cellMaxWidths.reduce(0, +))
        self.getRowHeights()
        //print("frame height", self.frame.height)
        self.tableCollectionViewHeightConstraint.constant = self.tableHeight
    }
    
    private func getCellMaxWidths() {
        guard data != nil else { return }
        for row  in data! {
            for (index, cell) in row.enumerated() {
                let width = self.maximumLabelWidth(text: cell)
                if cellMaxWidths.count < data![0].count { cellMaxWidths.append(width) }
                else if width > cellMaxWidths[index]{ cellMaxWidths[index] = width }
            }
        }
    }
    
    private func maximumLabelWidth(text: NSAttributedString)-> CGFloat {
        let label = UILabel()
        label.attributedText = text
        return label.textRect(forBounds: CGRect(x: 0, y:0, width:UIScreen.main.bounds.width, height: 50), limitedToNumberOfLines: 1).width + 2*tabellCellLabelSpacing
    }
    
    private func getRowHeights() {
        guard data != nil && rowHeights.isEmpty else { return }
        for row in data! {
            var rowHeightArray = [CGFloat]()
            for (index,cell) in row.enumerated() {
                if let nibCell = TableCell.fromNib() {
                    nibCell.cellLabel.preferredMaxLayoutWidth = cellMaxWidths[index] - 2 * tabellCellLabelSpacing * CGFloat(cellMaxWidths.count)
                    nibCell.cellLabelWidth.constant = nibCell.cellLabel.preferredMaxLayoutWidth + 2*tabellCellLabelSpacing
                    nibCell.cellLabel.attributedText = cell
                    
                    let cellHeight = nibCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height > minRowHeight ? nibCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height : minRowHeight
                    rowHeightArray.append(cellHeight)
                }
            }
            if let maximumHeightInRow = rowHeightArray.max() {
                tableHeight += maximumHeightInRow + 1.0
                rowHeights.append(maximumHeightInRow)
            }
        }
        //print(cellMaxWidths, rowHeights, tableHeight)
    }
}

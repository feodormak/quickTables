//
//  File.swift
//  quickTables
//
//  Created by feodor on 14/11/17.
//  Copyright © 2017 feodor. All rights reserved.
//

import UIKit

enum QuickTableConstants {
    static let leftSpacing: CGFloat = 1.0
    static let defaultSpacing: CGFloat = 2.0
    static let tabellCellLabelSpacing:CGFloat = 4.0
    static let minRowHeight:CGFloat = 30
}

class QuickTableOptions {
    let tableBorderWidth: CGFloat
    let tableBorderColor: UIColor
    let cellColors: [[IndexPath: UIColor]]
    
    init(tableBorderWidth: CGFloat = 1.0, tableBorderColor: UIColor = .black, cellColors:[[IndexPath: UIColor]]) {
        self.tableBorderWidth = tableBorderWidth
        self.tableBorderColor = tableBorderColor
        self.cellColors = cellColors
    }
}

class QuickTable: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet private weak var tableCollectionView: UICollectionView!
    @IBOutlet private weak var tableCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingConstraint: NSLayoutConstraint!
    
    //constants
    private var data: [[NSAttributedString]]? { didSet { if data != nil { tableCollectionView.reloadData() } } }
    private var parentWidth: CGFloat? { didSet{ if parentWidth != nil { self.tableSizing(width: parentWidth!) } } }
    
    private var cellMaxWidths = [CGFloat]()
    private var rowHeights = [CGFloat]()
    private var tableHeight:CGFloat = 1
    
    static var identifier: String { return String(describing: self) }
    static var nib:UINib { return UINib(nibName: identifier, bundle: nil) }
    
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
        self.parentWidth = nil
        
        self.leadingConstraint.constant = QuickTableConstants.defaultSpacing
        self.trailingConstraint.constant = QuickTableConstants.defaultSpacing
    }
    
    //this is ROWS
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if data != nil { return self.data!.count }
        else { return 0 }
    }
    
    //this is COLUMNS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.data != nil {
            if self.data!.first != nil { return self.data!.first!.count }
            else { return 0 }
        }
        else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCell.identifier, for: indexPath) as? TableCell {
            if self.data != nil {
                cell.cellLabel.attributedText = self.data![indexPath.section][indexPath.row]
                return cell
            }
            return UICollectionViewCell()
        }
        else { return UICollectionViewCell() }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellMaxWidths[indexPath.row], height: rowHeights[indexPath.section])
    }
    
    func setupTable(width: CGFloat, data: [[NSAttributedString]]) {
        self.data = data
        self.parentWidth = width
    }
    
    private func tableSizing(width: CGFloat) {
        self.getCellMaxWidths()
        
        guard self.cellMaxWidths.isEmpty != true else { return }
        
        if self.cellMaxWidths.reduce(0, +) <= width - (2 * QuickTableConstants.defaultSpacing) - (CGFloat(self.cellMaxWidths.count + 1) * QuickTableConstants.leftSpacing) {
            let totalSpacing = CGFloat(self.cellMaxWidths.count+1) * QuickTableConstants.leftSpacing
            let newConstraintConstant = (width -  totalSpacing - self.cellMaxWidths.reduce(0, +)) / 2
            self.leadingConstraint.constant = newConstraintConstant
            self.trailingConstraint.constant = newConstraintConstant
        }
        else{
            let totalRequiredWidth = self.cellMaxWidths.reduce(0, +)
            let useableWidthForCells = width - (2 * QuickTableConstants.defaultSpacing) - CGFloat(self.cellMaxWidths.count + 1) * QuickTableConstants.leftSpacing
            var useableWidthLeft = useableWidthForCells
            for (index, cell) in self.cellMaxWidths.enumerated() {
                self.cellMaxWidths[index] = (index + 1) == self.cellMaxWidths.count ? useableWidthLeft : round((cell / totalRequiredWidth * useableWidthForCells))
                useableWidthLeft -= self.cellMaxWidths[index]
            }
        }
        self.getRowHeights()
        self.tableCollectionViewHeightConstraint.constant = self.tableHeight
    }
    
    private func getCellMaxWidths() {
        guard self.data != nil else { return }
        for row in self.data! {
            for (index, cell) in row.enumerated() {
                let width = self.maximumLabelWidth(text: cell)
                if self.cellMaxWidths.count < self.data![0].count { self.cellMaxWidths.append(width) }
                else if width > self.cellMaxWidths[index]{ self.cellMaxWidths[index] = width }
            }
        }
    }
    
    private func maximumLabelWidth(text: NSAttributedString)-> CGFloat {
        let label = UILabel()
        label.attributedText = text
        return label.textRect(forBounds: CGRect(x: 0, y:0, width:UIScreen.main.bounds.width, height: 50), limitedToNumberOfLines: 1).width + 2*QuickTableConstants.tabellCellLabelSpacing
    }
    
    private func getRowHeights() {
        guard data != nil && rowHeights.isEmpty else { return }
        for row in data! {
            var rowHeightArray = [CGFloat]()
            for (index,cell) in row.enumerated() {
                if let nibCell = TableCell.fromNib() {
                    nibCell.cellLabel.preferredMaxLayoutWidth = self.cellMaxWidths[index] - 2 * QuickTableConstants.tabellCellLabelSpacing * CGFloat(cellMaxWidths.count)
                    nibCell.cellLabelWidth.constant = nibCell.cellLabel.preferredMaxLayoutWidth + 2*QuickTableConstants.tabellCellLabelSpacing
                    nibCell.cellLabel.attributedText = cell
                    
                    let cellHeight = nibCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height > QuickTableConstants.minRowHeight ? nibCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height : QuickTableConstants.minRowHeight
                    rowHeightArray.append(cellHeight)
                }
            }
            if let maximumHeightInRow = rowHeightArray.max() {
                self.tableHeight += maximumHeightInRow + 1.0
                self.rowHeights.append(maximumHeightInRow)
            }
        }
    }
}

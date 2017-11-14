//
//  File.swift
//  quickTables
//
//  Created by feodor on 14/11/17.
//  Copyright © 2017 feodor. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var tableCollectionView: UICollectionView!
    
    
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
        tableCollectionView.backgroundColor = UIColor.red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    //this is ROWS
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //this is COLUMNS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    
}

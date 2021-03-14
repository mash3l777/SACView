//
//  DataSource.swift
//
//  Created by Mashal Ibrahim on 08/03/2021.
//  Copyright © 2021 Mashal. All rights reserved.
//

import UIKit

class DataSource: NSObject, UICollectionViewDataSource {
    
    var arrSentence: [PredefindSentence]? = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSentence?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"SAVCCell" , for: indexPath) as! SAVCCell
        cell.lblSentence.text = arrSentence?[indexPath.row].sentence
        
        return cell
    }
    
    
    
    

}

//
//  DragDelegate.swift
//
//  Created by Mashal Ibrahim on 08/03/2021.
//  Copyright © 2021 Mashal. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class DragDelegate: NSObject, UICollectionViewDragDelegate {
    
    public var arrSentence:[PredefindSentence]? = []
    
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        guard let arrSentence = arrSentence, !arrSentence.isEmpty else {
          return []
        }
        let text = arrSentence[indexPath.item].sentence

        let itemProvider = NSItemProvider(object: text as NSItemProviderWriting)
        let dragItem = UIDragItem.init(itemProvider: itemProvider )
        return [dragItem]
    }
    

}

//
//  SAVCView.swift
//
//  Created by Mashal Ibrahim on 07/03/2021.
//  Copyright © 2021 Mashal. All rights reserved.
//
#if canImport(UIKit)
import UIKit
public protocol SACVDalegate {
     func btnAddAction(_ sender: Any)
}

@IBDesignable
@available(iOS 13.0, *)
open class SAVCView: UIView, UITextViewDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var btnAdd: UIButton!

    public var delegate: SACVDalegate?
    
    var collectionDelegate:Delegate!
    var collectionDataSource:DataSource!
    var collectionDragDelegate:DragDelegate!
    
    public var arrSentence: [PredefindSentence] = []
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    

    
    private func commonInit() {
        Bundle.main.loadNibNamed("SAVCView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        

        collectionDelegate = Delegate().self
        collectionDataSource = DataSource().self
        collectionDragDelegate = DragDelegate().self
        
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
        collectionView.dragDelegate = collectionDragDelegate
        collectionView.register(UINib.init(nibName: "SACVCell", bundle: nil), forCellWithReuseIdentifier: "SACVCell")
        self.isHidden = true
        self.setNeedsDisplay()
    }
    
    open func append(sentences: [PredefindSentence]){
        arrSentence = sentences
        collectionDataSource.arrSentence = arrSentence
        collectionDragDelegate.arrSentence = arrSentence
        self.collectionView.reloadData()
    }
    
    @IBAction func btnAddAction(_ sender: Any) {
        delegate?.btnAddAction(self)
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        
         self.isHidden = false
    }
    public func textViewDidChange(_ textView: UITextView) {
        let lastSentence = textView.text.split(separator: " ").last ?? ""
        arrSentence.sort(by: { ($0.sentence.lowercased().contains(lastSentence.lowercased()) ? 0 : 1) < ($1.sentence.lowercased().contains(lastSentence.lowercased()) ? 0 : 1) })
        arrSentence.sort(by: { ($0.sentence.lowercased().contains(textView.text.lowercased()) ? 0 : 1) < ($1.sentence.lowercased().contains(textView.text.lowercased()) ? 0 : 1) })
        
        collectionDataSource.arrSentence = arrSentence
        collectionDragDelegate.arrSentence = arrSentence
        
        
        self.collectionView.reloadData()
        
    }
    
    // MARK: - Properties
    
    @IBInspectable
    var addButton: Bool = false {
        didSet {
            if addButton {
                self.btnAdd.isHidden  = false
            }else{
                self.btnAdd.isHidden  = false
            }
        }
    }
    
    
//    @IBInspectable
//    var textColor: UIColor = .label {
//        didSet {
//
//            CellDelegat = textColor
//
//        }
//    }
    
}
#endif

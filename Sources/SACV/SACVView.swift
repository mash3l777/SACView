//
//  SACVView.swift
//
//  Created by Mashal Ibrahim on 07/03/2021.
//  Copyright © 2021 Mashal. All rights reserved.
//
#if os(iOS)
import UIKit
public protocol SACVDalegate {
    func btnAddAction(_ sender: Any)
}

//@IBDesignable
@available(iOS 13.0, *)
open class SACVView: UIView, UITextViewDelegate {

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
        Bundle.module.loadNibNamed("SACVView", owner: self, options: nil)
//        Bundle.main.loadNibNamed("SACVView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        

        collectionDelegate = Delegate().self
        collectionDataSource = DataSource().self
        collectionDragDelegate = DragDelegate().self
        
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
        collectionView.dragDelegate = collectionDragDelegate
//        collectionView.register(UINib(nibName: "SACVCell", bundle: Bundle.init(for: SACVCell.self)), forCellWithReuseIdentifier: "SACVCell")
        collectionView.register(UINib.init(nibName: "SACVCell", bundle: Bundle.module), forCellWithReuseIdentifier: "SACVCell")
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
        self.collectionView.scrollToItem(at:[0,0], at:.left, animated: true)

    }
    
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        let lastSentence = textView.text.split(separator: " ").last ?? ""
        for code in arrSentence {
            if code.shortCut == lastSentence {
                textView.text.replaceSubrange(lastSentence.startIndex..<lastSentence.endIndex, with: code.sentence)
            }
        }
    }
    
    // MARK: - Properties
    
    @IBInspectable
    var addButton: Bool = false {
        didSet {
            if addButton {
                self.btnAdd.isHidden  = true
            }else{
                self.btnAdd.isHidden  = false
            }
        }
    }
    
}
#endif

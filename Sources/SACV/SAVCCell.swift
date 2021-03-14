//
//  SAVCCell.swift
//
//  Created by Mashal Ibrahim on 08/03/2021.
//  Copyright © 2021 Mashal. All rights reserved.
//

import UIKit
protocol CellDelegate {
    var textColor:UIColor { get set}
}
class SAVCCell: UICollectionViewCell {

    @IBOutlet var lblSentence: UILabel!
    
    var delegate: CellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        delegate?.textColor = .label
        self.layer.cornerRadius = self.layer.bounds.height/2
        self.backgroundColor = .white
        self.lblSentence.textColor = .label
    }

}

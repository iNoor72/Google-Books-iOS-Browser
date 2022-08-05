//
//  BookCollectionViewCell.swift
//  TheChefzTask
//
//  Created by Noor Walid on 31/07/2022.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var bookThumbnail: UIImageView!
    @IBOutlet private weak var bookTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(bookImage: String, bookTitle: String) {
        self.bookTitle.text = bookTitle
        guard let imageURL = URL(string: bookImage) else { return }
        self.bookThumbnail.kf.setImage(with: imageURL)
    }

}

//
//  BookDetailsViewController.swift
//  TheChefzTask
//
//  Created by Noor Walid on 30/07/2022.
//

import UIKit
import SafariServices
import RxCocoa
import RxSwift
import Kingfisher

class BookDetailsViewController: UIViewController {
    @IBOutlet private weak var bookThumbnail: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var pagesLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    private let disposeBag = DisposeBag()
    var detailsViewModel: BookDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUIComponents()
    }
    
    private func bindUIComponents() {
        detailsViewModel?.bookDescriptionBehavior.asObservable().map { $0 }.bind(to: descriptionTextView.rx.text).disposed(by: disposeBag)
        
        detailsViewModel?.bookNameBehavior.asObservable().map { $0 }.bind(to: titleLabel.rx.text).disposed(by: disposeBag)

        detailsViewModel?.bookPriceBehavior.asObservable().map { "Price: " + String($0) + " \(self.detailsViewModel?.priceCurrencyBehavior.value ?? "EGP")"}.bind(to: priceLabel.rx.text).disposed(by: disposeBag)
        
        detailsViewModel?.bookPagesBehavior.asObservable().map { String($0) + " pages" }.bind(to: pagesLabel.rx.text).disposed(by: disposeBag)

        guard let url = detailsViewModel?.bookThumbnailBehavior.value else { return }
        guard let imageURL = URL(string: url) else { return }
        bookThumbnail.kf.setImage(with: imageURL)
    }

    @IBAction private func openBookButtonTapped(_ sender: UIButton) {
        guard let url = detailsViewModel?.getBookURL() else { return }
        guard let bookURL = URL(string: url) else { return }
        UIApplication.shared.open(bookURL)
    }
}

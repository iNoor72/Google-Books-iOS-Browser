//
//  ViewController.swift
//  TheChefzTask
//
//  Created by Noor Walid on 29/07/2022.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet private weak var lastSearchTextLabel: UILabel!
    @IBOutlet private weak var booksCollectionView: UICollectionView!
    
    private var mainViewModel: MainViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainViewModel = MainViewModel()
        setupCollectionView()
        updateCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        updateLabel()
    }
    
    private func fetchData() {
        mainViewModel.fetchLastSearch()
        mainViewModel.fetchBooksFromDatabase()
    }
    
    private func updateLabel() {
        lastSearchTextLabel.rx.text.onNext(mainViewModel.lastSearchBehavior.value)
    }
    
    private func setupCollectionView() {
        booksCollectionView.register(UINib(nibName: Constants.XIBs.BookCollectionViewCellXIB, bundle: nil), forCellWithReuseIdentifier: Constants.CollectionViewCells.BookCollectionViewCellID)
        
        booksCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        booksCollectionView.rx.modelSelected(Book.self).bind { book in
            let route = MainScreenNavigationRoutes.DetailsScreen(book)
            self.navigate(to: route)
        }.disposed(by: disposeBag)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: self.booksCollectionView.frame.width/2, height: (self.booksCollectionView.frame.height/2)-2)
        flowLayout.minimumLineSpacing = 8.0
        flowLayout.minimumInteritemSpacing = 8.0
        self.booksCollectionView.semanticContentAttribute = .unspecified
        self.booksCollectionView.collectionViewLayout = flowLayout
        self.booksCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func updateCollectionView() {
        booksCollectionView.delegate = nil
        booksCollectionView.dataSource = nil
        
        mainViewModel.booksObservable.bind(to: booksCollectionView.rx.items(cellIdentifier: Constants.CollectionViewCells.BookCollectionViewCellID, cellType: BookCollectionViewCell.self))
        { _, book, cell in
            cell.setupCell(bookImage: book.volumeInfo?.imageLinks?.thumbnail ?? Constants.defaultImage, bookTitle: book.volumeInfo?.title ?? "Noor was here")
        }.disposed(by: disposeBag)
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let route = MainScreenNavigationRoutes.SearchScreen
        self.navigate(to: route)
    }
}

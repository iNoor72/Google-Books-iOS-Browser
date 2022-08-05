//
//  SearchViewController.swift
//  TheChefzTask
//
//  Created by Noor Walid on 30/07/2022.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var booksCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private var searchViewModel: SearchViewModel!
    private let disposeBag = DisposeBag()
    private var pageCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel = SearchViewModel()
        searchBar.rx.setDelegate(self).disposed(by: disposeBag)
        setupCollectionView()
        bindUIComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveSearch()
    }
    
    private func saveSearch() {
        guard let books = searchViewModel.books?.items else { return }
        let booksArray = Array(books)
        self.searchViewModel.saveSearchToDatabase(books: booksArray)
    }
    
    private func bindUIComponents() {
        searchBar.rx.text.orEmpty.bind(to: searchViewModel.bookNameBehavior).disposed(by: disposeBag)
        searchViewModel.isIndicatorHiddenSubject.bind(to: loadingIndicator.rx.isHidden).disposed(by: disposeBag)
        searchViewModel.isIndicatorOffSubject.bind(to: loadingIndicator.rx.isAnimating).disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        booksCollectionView.register(UINib(nibName: Constants.XIBs.BookCollectionViewCellXIB, bundle: nil), forCellWithReuseIdentifier: Constants.CollectionViewCells.BookCollectionViewCellID)
        
        booksCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        booksCollectionView.rx.modelSelected(Book.self).bind { book in
            let route = SearchScreenNavigationRoutes.DetailsScreen(book)
            self.navigate(to: route)
        }.disposed(by: disposeBag)
        
        booksCollectionView.rx.didEndDragging.subscribe { [weak self] _ in
            guard let self = self else { return }
            
            let offSetY = self.booksCollectionView.contentOffset.y
            let contentHeight = self.booksCollectionView.contentSize.height
            
            if offSetY > (contentHeight - self.booksCollectionView.frame.size.height - 50) {
                self.searchViewModel.deleteLastSearchResult()
                self.searchViewModel.loadMoreBooks(page: (Constants.defaultMaxNumber * self.pageCount) + 1)
                self.pageCount += 1
            }
        }.disposed(by: disposeBag)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2)-28, height: 230)
        flowLayout.minimumLineSpacing = 8.0
        flowLayout.minimumInteritemSpacing = 8.0
        self.booksCollectionView.semanticContentAttribute = .unspecified
        self.booksCollectionView.collectionViewLayout = flowLayout
        self.booksCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func updateCollectionView() {
        booksCollectionView.delegate = nil
        booksCollectionView.dataSource = nil
        
        searchViewModel.booksModelObservable.bind(to: booksCollectionView.rx.items(cellIdentifier: Constants.CollectionViewCells.BookCollectionViewCellID, cellType: BookCollectionViewCell.self))
        { _, book, cell in
            cell.setupCell(bookImage: book.volumeInfo?.imageLinks?.thumbnail ?? Constants.defaultImage, bookTitle: book.volumeInfo?.title ?? "No Title")
        }.disposed(by: disposeBag)
    }
    
    private func loadData(page: Int = 0) {
        searchViewModel.searchForBook(page: page)
        
        DispatchQueue.main.async {
            self.updateCollectionView()
        }
    }
}

//MARK: UISearchBar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        searchBar.resignFirstResponder()
        searchViewModel.deleteLastSearchKeyword()
        searchViewModel.deleteLastSearchResult()
        self.loadData()
        searchViewModel.saveLastSearch(keyword: keyword)
    }
}

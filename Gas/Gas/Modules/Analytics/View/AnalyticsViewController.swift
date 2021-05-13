//
//  AnalyticsViewController.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import UIKit

fileprivate enum Constants {
    static let cellIdentifier = "cell"
}

class AnalyticsViewController: BaseViewController, AnalyticsViewInput {
    
    var output: AnalyticsViewOutput?
    
    var objects: [(String, String)] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let textLabel = UILabel().with(font: .systemFont(ofSize: 18, weight: .semibold)).with(textColor: Color.darkGray).with(text: "Показания и расходы")
    
    private lazy var collectionView: UICollectionView = {
        let carouselLayout = UICollectionViewFlowLayout()
        let cellPadding = (view.frame.width - 325) / 2
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 325, height: 175)
        carouselLayout.sectionInset = .zero
        carouselLayout.minimumLineSpacing = view.frame.width - 325
        carouselLayout.sectionInset = .init(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
        let view = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        view.register(AnalyticsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        view.dataSource = self
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.backgroundColor = .none
        return view
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = Color.lineGray2
        pageControl.currentPageIndicatorTintColor = Color.main
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.backgroundColor
        setupViews()
        output?.didLoad()
    }
    
    private func setupViews() {
        [textLabel, collectionView, pageControl].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        collectionView.roundCorners(radius: 14)
        pageControl.numberOfPages = objects.count
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuidance.offsetAndHalf),
            textLabel.topAnchor.constraint(equalTo: view.topAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: textLabel.topAnchor, constant: LayoutGuidance.offset),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: LayoutGuidance.offsetQuarter),
            pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func display(adapter: AnalyticsViewAdapter) {
        objects.append(("Средний расход", "\(adapter.median) \(UnitVolume.cubicMeters.symbol)"))
    }
    
}

extension AnalyticsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? AnalyticsCollectionViewCell else { return UICollectionViewCell() }
        let title = objects[indexPath.row].0
        let value = objects[indexPath.row].1
        cell.configure(title: title, value: value)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    
}

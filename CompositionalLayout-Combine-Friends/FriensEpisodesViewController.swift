//
//  ViewController.swift
//  CompositionalLayout-Combine-Friends
//
//  Created by Liubov Kaper  on 8/25/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import Kingfisher
import Combine


class FriensEpisodesViewController: UIViewController {
    
    enum SectionKind: Int, CaseIterable {
        case seasonOne
        case seasonTwo
        case seasonThree
        case seasonFour
        case seasonFive
        case seasonSix
        case seasonSeven
        case seasonEight
        case seasonNine
        case seasonTen
    }
    
  //  private var episode = Episode!
    
   private var collectionView: UICollectionView!
    
    //TODO: change Int to Episode
    typealias DataSource = UICollectionViewDiffableDataSource<SectionKind, Episode>
    
    private var dataSource: DataSource!
    
    // store subscriptions
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Friends"
        
        configureCollectionView()
        configureDataSource()
        
        getEpisodes()
    }
    
    private func getEpisodes() {
        APIClient().getEpisodes()
            .sink(receiveCompletion: { (completion) in
                print(completion)
            }) { [weak self](episodes) in
                self?.updateSnapshot(with: episodes)
        }
    .store(in: &subscriptions)
    }
    
    private func updateSnapshot(with episodes: [Episode]) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.seasonOne, .seasonTwo, .seasonThree, .seasonFour, .seasonFive, .seasonSix, .seasonSeven, .seasonEight, .seasonNine, .seasonTen ])
        snapshot.appendItems(episodes)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(EpisodeCell.self, forCellWithReuseIdentifier: EpisodeCell.reuseIdentifier)
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            //item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let itemSpacing: CGFloat = 5 // points
            item.contentInsets = NSDirectionalEdgeInsets(top: itemSpacing, leading: itemSpacing, bottom: itemSpacing, trailing: itemSpacing)
            //group
            let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitem: item, count: 1)
            let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.7))
            let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [innerGroup])
            
            //section
            let section = NSCollectionLayoutSection(group: nestedGroup)
            section.orthogonalScrollingBehavior = .continuous
            
            //headerView
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
            
        }
        
        return layout
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPAth, episode) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.reuseIdentifier, for: indexPAth) as? EpisodeCell else {
                fatalError("could not dequeue EpisodeCell")
            }
//            guard let sectionKind = SectionKind(rawValue: indexPAth.section) else {
//                fatalError("could not dequeue sections")
//            }
            
            cell.backgroundColor = .systemTeal
            cell.layer.cornerRadius = 10
            cell.summaryTextView.text = episode.summary
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView, let sectionKind = SectionKind(rawValue: indexPath.section) else {
                fatalError("could not dequeue HeaderView")
            }
            return headerView
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Episode>()
        snapshot.appendSections([.seasonOne, .seasonTwo, .seasonThree, .seasonFour, .seasonFive, .seasonSix, .seasonSeven, .seasonEight, .seasonNine, .seasonTen])
        
//        snapshot.appendItems(, toSection: <#T##SectionKind?#>)
//        snapshot.appendItems(Array(6...10), toSection: .seasonTwo)
//        snapshot.appendItems(Array(11...15), toSection: .seasonThree)
//        snapshot.appendItems(Array(16...20), toSection: .seasonFour)
//        snapshot.appendItems(Array(21...25), toSection: .seasonFive)
//        snapshot.appendItems(Array(26...30), toSection: .seasonSix)
//        snapshot.appendItems(Array(31...35), toSection: .seasonSeven)
//        snapshot.appendItems(Array(40...45), toSection: .seasonEight)
//        snapshot.appendItems(Array(46...50), toSection: .seasonNine)
//        snapshot.appendItems(Array(51...55), toSection: .seasonTen)
        dataSource.apply(snapshot,animatingDifferences: false)
    }

}


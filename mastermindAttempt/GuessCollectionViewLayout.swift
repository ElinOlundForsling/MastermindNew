//
//  GuessCollectionViewLayout.swift
//  mastermindAttempt
//
//  Created by Elin Ölund Forsling on 2020-01-31.
//  Copyright © 2020 Elin Ölund Forsling. All rights reserved.
//

import UIKit

class GuessCollectionViewLayout {
    
    func generateLayout() -> UICollectionViewLayout {
        
        // MARK: GUESS ITEM
        let guessItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/11),
                heightDimension: .fractionalHeight(1.0)))

        guessItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
      
        // MARK: GUESS GROUP
        let guessGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(8/11),
                heightDimension: .fractionalHeight(1.0)),
            subitem: guessItem,
            count: 4)

        // MARK: EMPTY ITEM
        let emptyItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))

        emptyItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 0,
            bottom: 2,
            trailing: 0)

        // MARK: EMPTY GROUP
        let emptyGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/11),
                heightDimension: .fractionalHeight(1.0)),
            subitem: emptyItem,
            count: 1)

        // MARK: DOT ITEM
        let dotItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))

        dotItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)

        // MARK: DOT GROUP
        let dotGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/11),
                heightDimension: .fractionalHeight(1.0)),
            subitem: dotItem,
            count: 1)

        // MARK: ROW GROUP
        let guessRowGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)),
            subitems: [ guessGroup, emptyGroup, dotGroup ])

        // MARK: NESTED GROUP
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1/10)),
            subitems: [ guessRowGroup ])
        
        
        let section = NSCollectionLayoutSection(group: nestedGroup)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}

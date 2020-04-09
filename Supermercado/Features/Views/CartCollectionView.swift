//
//  CartCollectionView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 09/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import UIKit

struct CartCollectionView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<CartCollectionView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let collectionView = UICollectionView(
                frame: .zero,
                collectionViewLayout: makeDefaultLayout()
        )
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "myCell"
        )
        
        
        let dataSource = UICollectionViewDiffableDataSource<CartSection, Cart>(
                collectionView: collectionView
        ) { collectionView, indexPath, cart in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
            cell.backgroundColor = .red
            // ...
            // Do whatever customization you want with your cell here!
            // ...
            return cell
        }
        populate(dataSource: dataSource)
        view.addSubview(collectionView)
        return view
    }
    
    
    fileprivate func makeDefaultLayout() -> UICollectionViewFlowLayout {
        let l = UICollectionViewFlowLayout()
        let margin = CGFloat(16)

        l.scrollDirection = .vertical
        l.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        l.minimumLineSpacing = 4
        l.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: 0, right: 0)

        return l
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<CartCollectionView>) {
        // We'll leave this empty for now!
    }

    func populate(dataSource: UICollectionViewDiffableDataSource<CartSection, Cart>) {
        var snapshot = NSDiffableDataSourceSnapshot<CartSection, Cart>()
        snapshot.appendSections([.main])
        snapshot.appendItems([
            Cart(name: "Churrasco do\nbeto", iconName: "churras"),
            Cart(name: "Churrasco do\nbeto", iconName: "churras"),
            Cart(name: "Churrasco do\nbeto", iconName: "churras"),
            Cart(name: "Churrasco do\nbeto", iconName: "churras")
        ])
        dataSource.apply(snapshot)
    }

}

struct CartCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CartCollectionView()
    }
}


// This represents the different sections in our UICollectionView. When using UICollectionViewDiffableDataSource, the model must be Hashable (which enums already are)
enum CartSection {
    case main
}

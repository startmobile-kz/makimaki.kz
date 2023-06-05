//
//  ViewController.swift
//  maki-maki-ios
//
//  Created by Shyngys on 16.05.2023.
//

import UIKit
import FirebaseCore

//final class DemoTableViewCell: UITableViewCell, ReusableView {
// .....
//}

//final class DemoCollectionViewCell: UICollectionViewCell, ReusableView {
// .....
//}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColor.background.uiColor
//        Examples
//        labelView.font = AppFont.medium.s12()
//        labelView.layer.borderColor = AppColor.background.cgColor
//        imageView.image = AppImage.burger.uiImage
        
        
        
        
//        Examples for table view
        
//        first register cell for tableView
//        tableView.register(DemoTableViewCell.self)
        
//        then you can use like that
//        func tableView(_ tableView: UITableView, cellForRowAt: IndexPath) -> UITableViewCell {
//             let cell: DemoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
//             return cell
//        }
        
        
        
//        Examples for collection view
        
//        first register cell for collectionView
//        collectionView.register(DemoCollectionViewCell.self)
        
//        then you can use like that
//        func collectionView(_ collectionView: UITableView, cellForRowAt: IndexPath) -> UICollectionViewCell {
//             let cell: DemoCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
//             return cell
//        }
    }
}


//
//  SecondMainViewController.swift
//  maki-maki-ios
//
//  Created by Damir Aliyev on 30.06.2023.
//

import UIKit
import SnapKit

class SecondMainViewController: UIViewController {
    
    // MARK: - State
    
    let sections: [NewMainPageSectionTypes] = [.promos, .products]
    
    // MARK: - UI
    
    private lazy var deliveryHeaderView: DeliveryHeaderView = {
        let view = DeliveryHeaderView()
        view.delegate = self
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.border.uiColor
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseID
        )
        collectionView.register(
            PromoBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: PromoBannerCollectionViewCell.reuseID
        )
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - SetupView
    
    private func setupViews() {
        view.backgroundColor = AppColor.background.uiColor
        view.addSubviews([deliveryHeaderView, separatorView])
    }
    
    // MARK: - SetupLayout
    
    private func setupConstraints() {
        deliveryHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(deliveryHeaderView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .promos
            switch section {
            case .promos:
                return self?.promoSectionLayout()
            case .products:
                return self?.restaurantSectionLayout()
            }
        }
    }
}

extension SecondMainViewController: DeliveryHeaderViewDelegate {
    func viewWasTapped() {
        print("Tapped")
    }
}

// MARK: - UICollectionView Delegate methods

extension SecondMainViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionView DataSource methods

extension SecondMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}



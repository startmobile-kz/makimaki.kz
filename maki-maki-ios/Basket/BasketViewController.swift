//
//  OrderViewController.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 30.05.2023.
//

import UIKit
import SnapKit
import ProgressHUD

protocol BasketViewProtocol: AnyObject {
    func showSelectedDishes(_ dishes: [RestaurantProduct])
    func showTotalPrice(_ price: Int)
    func showOrderSuccess()
    func showOrderFailure()
}

class BasketViewController: UIViewController {
    var presenter: BasketPresenterProtocol?
    var cellView: BasketTableViewCellProtocol?
    var router: BasketRouterProtocol?
    var selectedDishes: [RestaurantProduct] = []
    
    private lazy var orderTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(BasketTableViewCell.self,
            forCellReuseIdentifier: BasketTableViewCell.reuseIdentifier
        )
        tableView.rowHeight = 119
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var checkoutContainerView: ContainerView = {
        let view = ContainerView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        presenter?.getSelectedDishes()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        let footerViewSize = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 119)
        orderTableView.tableFooterView = DeliveryFooterView(frame: footerViewSize)
        
        [orderTableView, checkoutContainerView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        orderTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(checkoutContainerView.snp.top)
        }
        
        checkoutContainerView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(120)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of selected dishes
        return selectedDishes.count // Replace with your implementation
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BasketTableViewCell.reuseIdentifier,
            for: indexPath) as? BasketTableViewCell else {
            fatalError("Failed to dequeue BasketTableViewCell")
        }
        let dish = selectedDishes[indexPath.row]
            cell.setupData(dish: dish)
        presenter?.getSelectedDishes()
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteSelectedDish(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle row selection if needed
    }
}

extension BasketViewController: BasketViewProtocol {
    func showSelectedDishes(_ dishes: [RestaurantProduct]) {
        selectedDishes = dishes
        orderTableView.reloadData()
    }
    
    func showTotalPrice(_ price: Int) {
        checkoutContainerView.setup(with: price)
    }
    
    func showOrderSuccess() {
        // Show success message
    }
    
    func showOrderFailure() {
        // Show failure message
    }
}

extension BasketViewController: BasketTableViewCellDelegate {
    func deleteButtonTapped(at indexPath: IndexPath) {
        presenter?.deleteSelectedDish(at: indexPath)
    }
}

extension BasketViewController: CheckoutButtonDelegate {
    func checkoutPressed() {
        presenter?.createOrder()
    }
}

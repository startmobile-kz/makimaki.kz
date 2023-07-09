//
//  OrderViewController.swift
//  maki-maki-ios
//
//  Created by Александр Козлов on 30.05.2023.
//

import UIKit
import SnapKit
import ProgressHUD

final class BasketViewController: UIViewController {
    
    // MARK: - State
    
    public var selectedDishes: [RestaurantProduct] = []
    
    // MARK: - UI
    
    private lazy var orderTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(BasketTableViewCell.self,
                           forCellReuseIdentifier: BasketTableViewCell.reuseIdentifier)
        tableView.register(DeliveryFooterView.self,
                           forHeaderFooterViewReuseIdentifier: DeliveryFooterView.reuseIdentifier)

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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrains()
        setupNavigationBar()
        configureContainerView()
    }

    // MARK: - Setup Navigation Bar

    private func setupNavigationBar() {
        self.navigationItem.title = "Order"
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        let footerViewSize = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 119)
        orderTableView.tableFooterView = DeliveryFooterView(frame: footerViewSize)
        
        [orderTableView, checkoutContainerView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constrains
    
    private func setupConstrains() {
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

    // MARK: - Network
    
    @objc
    private func createOrder() {
        ProgressHUD.show("Loading...", interaction: false)
        let service = BasketService()
        let basket = Basket(uuid: "151eb4a0-ff99-4482-90d2-c4e7c77810dc",
                            fullName: "Разработчик тестирует заказ",
                            phone: "77082020155",
                            address: "Разработчик тестирует заказ",
                            promoCode: "BURGER",
                            comment: "Разработчик тестирует заказ",
                            basket: [ "6": 1, "17": 2, "23": 4],
                            code: "8146")
        service.createOrder(with: basket) { isSucess in
            if isSucess {
                ProgressHUD.dismiss()
            } else {
                ProgressHUD.showFailed("Please retry...")
            }
        }
    }

    private func configureContainerView() {
        let totalPrice = selectedDishes.reduce(0) { partialResult, product in
            return partialResult + (product.count * product.price)
        }
        checkoutContainerView.setup(with: totalPrice)
    }
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.reuseIdentifier,
                                                       for: indexPath)
                as? BasketTableViewCell else {
            fatalError("basketCell not found")
        }
        let dish = selectedDishes[indexPath.row]
        cell.setupData(dish: dish)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                CoreDataManager.shared.deleteSelectedProduct(product: selectedDishes[indexPath.row])
                selectedDishes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                configureContainerView()
            }
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
}

// MARK: - Checkout Delegate

extension BasketViewController: CheckoutButtonDelegate {
    func checkoutPressed() {
        createOrder()
        print("done")
    }
}

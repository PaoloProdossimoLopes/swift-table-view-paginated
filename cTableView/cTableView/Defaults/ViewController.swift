//
//  ViewController.swift
//  cTableView
//
//  Created by Paolo Prodossimo Lopes on 10/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    private let cTableViewDelegate: CustomTableViewDelegate = .init()
    private let cTableViewDataSource: CustomTableViewDataSource = .init()
    
    private var viewData: [String] = [] //Modify
    
    private let numberOfPages: Int = 3 // only example in project create a model
    private var currentPage: Int = 0 // only example in project create a model
    
    //MARK: - UI Components
    
    private(set) lazy var customTableView: CustomTableView = {
        let table = CustomTableView(
            delegate: cTableViewDelegate,
            dataSource: cTableViewDataSource
        )
        table.customDelegate = self
        return table
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        
        appendData() //Simulate api populate
        
        customTableView.updateDataSource(viewData)
        
    }
    
    //MARK: - Helpers
    
    private func commonInit() {
        setupStyle()
        setupHierarcy()
        setupConstaints()
    }
    
    private func setupHierarcy() {
        view.addSubview(customTableView)
    }
    
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            customTableView.topAnchor.constraint(equalTo: view.topAnchor),
            customTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupStyle() {
        
    }
    
    private func appendData() {
        let vds: [String] = [
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
            "11", "12", "13", "14", "15"
        ]
        vds.forEach { viewData.append($0) }
    }
}

//MARK: - CustomTableViewDelegateToView
extension ViewController: CustomTableViewDelegateToView {
    func fetchNextAPIPage() {
        appendData() //Simulate call service that append new datas in model
        
        guard currentPage <= numberOfPages else {
            customTableView.completed()
            return
        }
        
        currentPage += 1
        customTableView.updateDataSource(viewData)
        return
    }
}

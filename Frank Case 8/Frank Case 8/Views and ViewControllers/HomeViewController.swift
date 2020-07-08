//
//  HomeViewController.swift
//  Frank Case 8
//
//  Created by Chenguo Yan on 2020-07-07.
//  Copyright © 2020 Chenguo Yan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    lazy var viewModel: Case8ViewModel = Case8ViewModel(api: API.shared)
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        viewModel.getData()

//        viewModel.getAnalyticData()
//        viewModel.getBuildingData()
    }

}

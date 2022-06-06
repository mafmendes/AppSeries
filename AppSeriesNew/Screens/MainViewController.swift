//
//  ViewController.swift
//  APPSeriesNew
//
//  Created by Mendes, Mafalda Joana on 11/05/2022.
//

import Foundation
import UIKit
#warning("Ver se as variaveis publicas precisam mesmo de ser publicas :D")
#warning("Perguntar tarefas a fazer")
class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.pushViewController(MovieListViewController(), animated: true)

    }
}

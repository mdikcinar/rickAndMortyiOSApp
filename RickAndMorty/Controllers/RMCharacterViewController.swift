//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 7.06.2023.
//

import UIKit

final class RMCharacterViewController: UIViewController {
    private let characterListView = RMCharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
    }

    private func setUpView() {
        view.addSubview(characterListView)

        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.topAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

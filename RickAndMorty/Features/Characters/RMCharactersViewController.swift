//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 7.06.2023.
//

import UIKit

final class RMCharactersViewController: UIViewController, RMCharactersViewDelegate {
    private let characterListView = RMCharactersView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
    }

    private func setUpView() {
        characterListView.delegate = self
        view.addSubview(characterListView)

        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.topAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    func rmCharacterListView(_ chracterListView: RMCharactersView, didSelectCharacter character: RMCharacter) {
        let detailViewModel = RMCharacterDetailViewViewModel(character: character)
        let detailViewController = RMCharacterDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

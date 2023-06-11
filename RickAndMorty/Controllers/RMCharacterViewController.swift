//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 7.06.2023.
//

import UIKit

final class RMCharacterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"

        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMPaginatedResponse<RMCharacter>.self)
        { result in
            switch result {
                case .success(let paginatedCharacters):
                    print(String(describing: paginatedCharacters))
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
}

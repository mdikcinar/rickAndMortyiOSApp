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

        let request = RMRequest(endpoint: .character)

        RMService.shared.excecute(
            request,
            expectedType: RMCharacter.self,
            completor: { result in
                switch result {
                    case .success(let character):
                        print(character)
                    case .failure(let error):
                        print(error)
                }
            })
    }
}

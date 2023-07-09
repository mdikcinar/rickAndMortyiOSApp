//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 11.06.2023.
//

import UIKit

protocol RMCharactersViewViewModelDelegate: AnyObject {
    func didFetchCharacters()
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharactersViewViewModel: NSObject {
    public weak var delegate: RMCharactersViewViewModelDelegate?

    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewmodel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatusText: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                cellViewModels.append(viewmodel)
            }
        }
    }

    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []

    public var shouldShowLoadMoreIndicator: Bool {
        if paginatedInfo?.next != nil {
            return true
        }
        return false
    }

    private var isFetchingMoreCharacters = false

    private var paginatedInfo: RMPaginatedInfo?

    public func fetchCharcters() {
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMPaginatedResponse<RMCharacter>.self
        ) { [weak self] result in
            switch result {
                case .success(let paginatedCharacters):
                    let results = paginatedCharacters.results
                    let info = paginatedCharacters.info
                    self?.characters = results
                    self?.paginatedInfo = info
                    DispatchQueue.main.async {
                        self?.delegate?.didFetchCharacters()
                    }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }

    public func fetchAdditionalCharacters() {
        isFetchingMoreCharacters = true
        print("fetching additional characters")
    }
}

extension RMCharactersViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.identifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: FooterLoadingCollectionReusableView.identifier,
                  for: indexPath
              ) as? FooterLoadingCollectionReusableView
        else {
            fatalError("Unsupported reuseable footer view")
        }
        footer.startAnimating()
        return footer
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension RMCharactersViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator, !isFetchingMoreCharacters else { return }

        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height

        if offset >= (totalContentHeight - totalScrollViewFixedHeight) * 0.9 {
            fetchAdditionalCharacters()
        }
    }
}

//
//  UICollectionView+.swift
//  CoreList
//
//  Created by Robert on 4/5/20.
//

import UIKit

extension UICollectionView {
    @inlinable
    public func register(cell: CellRegisterable) {
        switch cell.type {
        case .default:
            register(UICollectionView.self, forCellWithReuseIdentifier: cell.reuseIdentifier)
        case .nib(let nibName, let bundle):
            register(UINib(nibName: nibName, bundle: bundle), forCellWithReuseIdentifier: cell.reuseIdentifier)
        case .class(let `class`):
            register(`class`, forCellWithReuseIdentifier: cell.reuseIdentifier)
        }
    }

    @inlinable
    public func register(headerFooter: HeaderFooterRegisterable) {
        let position = headerFooter.position
        switch headerFooter.type {
        case .default:
            switch position {
            case .header:
                register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerFooter.reuseIdentifier)
            case .footer:
                register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: headerFooter.reuseIdentifier)
            }
        case .nib(let nibName, let bundle):
            switch position {
            case .header:
                register(UINib(nibName: nibName, bundle: bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerFooter.reuseIdentifier)
            case .footer:
                register(UINib(nibName: nibName, bundle: bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: headerFooter.reuseIdentifier)
            }
        case .class(let `class`):
            switch position {
            case .header:
                register(`class`, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerFooter.reuseIdentifier)
            case .footer:
                register(`class`, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: headerFooter.reuseIdentifier)
            }
        }
    }

    // swiftlint:disable force_cast
    @inlinable
    public func dequeue<T>(of type: T.Type, cell: CellRegisterable, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        switch cell.type {
        case .nib(let nibName, _):
            precondition(String(describing: T.self) != nibName, "Cell nib was not registered")
        case .class(let `class`):
            precondition(T.self != `class`.self, "Cell class was not registered")
        case .default:
            precondition(T.self != UICollectionViewCell.self, "Cell class must be equal to UICollectionViewCell")
        }
        return self.dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }
    // swiftlint:enable force_cast

    @inlinable
    public func dequeue(cell: CellRegisterable, for indexPath: IndexPath) -> UICollectionViewCell {
        dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath)
    }

    // swiftlint:disable force_cast
    @inlinable
    public func dequeue<T>(of type: T.Type, headerFooter: HeaderFooterRegisterable, for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        switch headerFooter.type {
        case .nib(let nibName, _):
            precondition(String(describing: T.self) != nibName, "Header footer nib was not registered")
        case .class(let `class`):
            precondition(T.self != `class`.self, "Header footer class was not registered")
        case .default:
            precondition(T.self != UICollectionViewCell.self, "Header footer class must be equal to UICollectionReusableView")
        }
        switch headerFooter.position {
        case .header:
            return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerFooter.reuseIdentifier, for: indexPath) as! T
        case .footer:
            return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: headerFooter.reuseIdentifier, for: indexPath) as! T
        }
    }
    // swiftlint:enable force_cast

    @inlinable
    public func dequeue(headerFooter: HeaderFooterRegisterable, for indexPath: IndexPath) -> UICollectionReusableView {
        switch headerFooter.position {
        case .header:
            return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerFooter.reuseIdentifier, for: indexPath)
        case .footer:
            return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: headerFooter.reuseIdentifier, for: indexPath)
        }
    }
}

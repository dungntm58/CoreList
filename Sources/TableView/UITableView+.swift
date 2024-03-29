//
//  UITableView+.swift
//  CoreList
//
//  Created by Robert on 4/5/20.
//

import UIKit

extension UITableView {
    @inlinable
    public func register(cell: CellRegisterable)  {
        switch cell.type {
        case .default:
            register(UITableViewCell.self, forCellReuseIdentifier: cell.reuseIdentifier)
        case .nib(let nibName, let bundle):
            register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: cell.reuseIdentifier)
        case .class(let `class`):
            register(`class`, forCellReuseIdentifier: cell.reuseIdentifier)
        }
    }

    @inlinable
    public func register(headerFooter: HeaderFooterRegisterable) {
        switch headerFooter.type {
        case .default:
            register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerFooter.reuseIdentifier)
        case .nib(let nibName, let bundle):
            register(UINib(nibName: nibName, bundle: bundle), forHeaderFooterViewReuseIdentifier: headerFooter.reuseIdentifier)
        case .class(let `class`):
            register(`class`, forHeaderFooterViewReuseIdentifier: headerFooter.reuseIdentifier)
        }
    }

    // swiftlint:disable force_cast
    @inlinable
    public func dequeue<T>(of type: T.Type, cell: CellRegisterable, for indexPath: IndexPath) -> T where T: UITableViewCell {
        switch cell.type {
        case .nib(let nibName, _):
            precondition(String(describing: T.self) != nibName, "Cell nib was not registered")
        case .class(let `class`):
            precondition(T.self != `class`.self, "Cell class was not registered")
        case .default:
            precondition(T.self != UICollectionViewCell.self, "Cell class must be equal to UITableViewCell")
        }
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }
    // swiftlint:enable force_cast

    @inlinable
    public func dequeue(cell: CellRegisterable, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath)
    }

    @inlinable
    func dequeue(cell: CellRegisterable) -> UITableViewCell? {
        dequeueReusableCell(withIdentifier: cell.reuseIdentifier)
    }

    @inlinable
    public func dequeue<T>(of type: T.Type, headerFooter: HeaderFooterRegisterable) -> T? where T: UITableViewHeaderFooterView {
        switch headerFooter.type {
        case .nib(let nibName, _):
            precondition(String(describing: T.self) != nibName, "Header footer nib was not registered")
        case .class(let `class`):
            precondition(T.self != `class`.self, "Header footer class was not registered")
        case .default:
            precondition(T.self != UICollectionViewCell.self, "Header footer class must be equal to UITableViewHeaderFooterView")
        }
        return dequeueReusableHeaderFooterView(withIdentifier: headerFooter.reuseIdentifier) as? T
    }

    @inlinable
    public func dequeue(headerFooter: HeaderFooterRegisterable) -> UITableViewHeaderFooterView? {
        dequeueReusableHeaderFooterView(withIdentifier: headerFooter.reuseIdentifier)
    }

    @inlinable
    static public var leastNonzeroOfGroupedHeaderFooterHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return 0.01
        } else {
            return 1.01
        }
    }

    @inlinable
    public var leastOfHeaderFooterHeight: CGFloat {
        style == .plain ? 0 : UITableView.leastNonzeroOfGroupedHeaderFooterHeight
    }
}

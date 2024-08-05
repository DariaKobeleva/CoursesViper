//
//  CourseCell.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 03.08.2024.
//

import UIKit

protocol CellModelRepresentable {
    var viewModel: CourseCellViewModelProtocol? { get }
}

class CourseCell: UITableViewCell, CellModelRepresentable {
    var viewModel: CourseCellViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        guard let viewModel = viewModel as? CourseCellViewModel else { return }
        var content = defaultContentConfiguration()
        content.text = viewModel.courseName
        if let imageData = viewModel.imageData {
            content.image = UIImage(data: imageData)
        }
        contentConfiguration = content
    }
}

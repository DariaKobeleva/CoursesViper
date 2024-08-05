//
//  CourseCellViewModel.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 03.08.2024.
//

import Foundation

protocol CourseCellViewModelProtocol {
    var cellIdentifier: String { get }
    var cellHeight: Double { get }
    var courseName: String { get }
    var imageData: Data? { get }
    init(course: Course)
}

protocol CourseSectionViewModelProtocol {
    var rows: [CourseCellViewModelProtocol] { get }
    var numberOfRows: Int { get }
}

class CourseCellViewModel: CourseCellViewModelProtocol {
    var cellIdentifier: String {
        "CourseCell"
    }
    
    var cellHeight: Double {
        100
    }
    
    var courseName: String {
        course.name
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: course.imageUrl)
    }
    
    private let course: Course
    
    required init(course: Course) {
        self.course = course
    }
    
}

class CourseSectionViewModel: CourseSectionViewModelProtocol {
    var rows: [any CourseCellViewModelProtocol] = []
    var numberOfRows: Int {
        rows.count
    }
}

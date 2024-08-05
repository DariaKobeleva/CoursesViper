//
//  CourseListRouter.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 03.08.2024.
//

import Foundation

protocol CourseListRouterInputProtocol {
    init(view: CourseListViewController)
    func openCourseDetailsViewController(with course: Course)
}

class CourseListRouter: CourseListRouterInputProtocol {
    private unowned let view: CourseListViewController
    
    required init(view: CourseListViewController) {
        self.view = view
    }
    
    func openCourseDetailsViewController(with course: Course) {
        view.performSegue(withIdentifier: "showDetails", sender: course)
    }
}

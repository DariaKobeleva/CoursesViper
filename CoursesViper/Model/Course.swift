//
//  Course.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 02.08.2024.
//

import Foundation

struct Course: Decodable {
    let name: String
    let imageUrl: URL
    let numberOfLessons: Int
    let numberOfTests: Int
}

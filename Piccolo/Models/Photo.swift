import Foundation
import SwiftUI

struct Photo: Codable {
    let id: String
    let userId: String
    let filename: String
    let fileSize: Int32
    let contentType: String
    let createdAt: String
    let url: String
}

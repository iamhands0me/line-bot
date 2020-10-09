public struct Message: Decodable {
    public let id: String
    public let type: String
    public let text: String?
}

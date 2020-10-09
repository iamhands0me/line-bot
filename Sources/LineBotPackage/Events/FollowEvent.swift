public struct FollowEvent: Decodable {
    public let replyToken: String
    public let type: String
    public let mode: String
    public let timestamp: Int
    public let source: Source
}

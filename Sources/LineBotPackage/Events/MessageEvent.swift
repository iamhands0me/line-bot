public struct MessageEvent: Decodable {
    public let replyToken: String
    public let type: String
    public let mode: String
    public let timestamp: Int
    public let source: Source
    public let message: Message
}

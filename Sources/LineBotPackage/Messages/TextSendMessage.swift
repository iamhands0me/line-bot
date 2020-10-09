public struct TextSendMessage: Encodable {
    private let type = "text"
    private let text: String
    
    public init(text: String) {
        self.text = text
    }
}

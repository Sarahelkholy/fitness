abstract class ChatbotStrings {
  static const String smartCoach = "Smart Coach";
  static const String you = "You";
  static const String askSmartCoach = "Ask Smart Coach...";
  static const String newChat = "New Chat";
  static const String chatbotModel = "qwen2.5:7b";

  static const String systemPrompt = """
You are Smart Coach.
You are a professional fitness assistant.
Strictly answer only questions related to fitness, nutrition, workout plans, and physical health.
If a user asks anything outside this context, politely refuse and remind them of your specialty.
Always reply in the exact same language as the user. If they speak Arabic, reply in Arabic. If English, reply in English.
""";

  static const String titlePrompt = """
Generate a short title.
Maximum 4 words.
Return only the title.
""";

  static const String summaryPrompt = """
Summarize this fitness conversation.

Keep:

- User goals
- Weight
- Height
- Injuries
- Diet
- Workout plans
- Preferences

Ignore greetings and casual conversation.

Return a concise summary.
""";

  static String greetingPrompt(String userName) =>
      "Start a new conversation and greet me. My name is $userName.";

  static String summaryContext(String summary) =>
      "Summary of previous conversation: $summary";
}

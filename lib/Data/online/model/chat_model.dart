class PartsModel {
  String text;

  PartsModel({required this.text});

  factory PartsModel.fromMap(Map<String, dynamic> json) {
    return PartsModel(text: json['text']);
  }
}

class ContentModel {
  List<PartsModel> parts;
  String role;

  ContentModel({required this.parts, required this.role});

  factory ContentModel.fromMap(Map<String, dynamic> json) {
    List<PartsModel> parts = [];
    for (Map<String, dynamic> eachParts in json["parts"]) {
      parts.add(PartsModel.fromMap(eachParts));
    }
    return ContentModel(parts: parts, role: json["role"]);
  }
}

class CandidatesModel {
  List<ContentModel> content;
  String finishReason;
  double avgLogprobs;

  CandidatesModel({
    required this.content,
    required this.avgLogprobs,
    required this.finishReason,
  });

  factory CandidatesModel.fromMap(Map<String, dynamic> json) {
    List<ContentModel> content = [];
    for (Map<String, dynamic> eachContent in json["content"]) {
      content.add(ContentModel.fromMap(eachContent));
    }
    return CandidatesModel(
      content: content,
      avgLogprobs: json["avgLogprobs"],
      finishReason: json['finishReason'],
    );
  }
}

class PromptTokensDetailsModel {
  String modality;
  int tokenCount;

  PromptTokensDetailsModel({required this.modality, required this.tokenCount});

  factory PromptTokensDetailsModel.fromMap(Map<String, dynamic> json) {
    return PromptTokensDetailsModel(
      modality: json['modality'],
      tokenCount: json['tokenCount'],
    );
  }
}

class CandidatesTokenDetails {
  String modality;
  int tokenCount;

  CandidatesTokenDetails({required this.modality, required this.tokenCount});

  factory CandidatesTokenDetails.fromMap(Map<String, dynamic> json) {
    return CandidatesTokenDetails(
      modality: json['modality'],
      tokenCount: json['tokenCount'],
    );
  }
}

class UsageMetaDataModel {
  int promptTokenCount;
  int candidatesTokenCount;
  int totalTokenCount;
  List<PromptTokensDetailsModel> promptTokenDetails;
  List<CandidatesTokenDetails> candidatesTokensDetails;

  UsageMetaDataModel({
    required this.promptTokenDetails,
    required this.candidatesTokenCount,
    required this.totalTokenCount,
    required this.promptTokenCount,
    required this.candidatesTokensDetails,
  });

  factory UsageMetaDataModel.fromMap(Map<String, dynamic> json) {
    List<PromptTokensDetailsModel> promptTokenDetails = [];
    List<CandidatesTokenDetails> candidatesTokenDetails = [];

    for (Map<String, dynamic> eachPrompt in json['promptTokenDetails']) {
      promptTokenDetails.add(PromptTokensDetailsModel.fromMap(eachPrompt));
    }
    for (Map<String, dynamic> json in json['candidatesTokenDetails']) {
      candidatesTokenDetails.add(CandidatesTokenDetails.fromMap(json));
    }
    return UsageMetaDataModel(
      promptTokenDetails: promptTokenDetails,
      candidatesTokenCount: json['candidatesTokenCount'],
      totalTokenCount: json['totalTokenCount'],
      promptTokenCount: json['promptTokenCount'],
      candidatesTokensDetails: json['candidatesTokensDetails'],
    );
  }
}

class ResponseDataModel {
  List<CandidatesModel> candidates;
  List<UsageMetaDataModel> usageMetadata;
  String modelVersion;
  String responseld;

  ResponseDataModel({
    required this.candidates,
    required this.modelVersion,
    required this.responseld,
    required this.usageMetadata,
  });

  factory ResponseDataModel.fromMap(Map<String, dynamic> json) {
    List<CandidatesModel> candidates = [];
    List<UsageMetaDataModel> usageMetadata = [];
    for (Map<String, dynamic> json in json['candidates']) {
      candidates.add(CandidatesModel.fromMap(json));
    }
    for (Map<String, dynamic> json in json['usageMetadata']) {
      usageMetadata.add(UsageMetaDataModel.fromMap(json));
    }
    return ResponseDataModel(
      candidates: candidates,
      modelVersion: json['modelVersion'],
      responseld: json['responseld'],
      usageMetadata: usageMetadata,
    );
  }
}

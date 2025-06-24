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
  ContentModel content;
  String finishReason;
  double avgLogprobs;

  CandidatesModel({
    required this.content,
    required this.avgLogprobs,
    required this.finishReason,
  });

  factory CandidatesModel.fromMap(Map<String, dynamic> json) {

    return CandidatesModel(
      content: ContentModel.fromMap(json["content"]),
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

class CandidatesTokensDetails {
  String modality;
  int tokenCount;

  CandidatesTokensDetails({required this.modality, required this.tokenCount});

  factory CandidatesTokensDetails.fromMap(Map<String, dynamic> json) {
    return CandidatesTokensDetails(
      modality: json['modality'],
      tokenCount: json['tokenCount'],
    );
  }
}

class UsageMetaDataModel {
  int promptTokenCount;
  int candidatesTokenCount;
  int totalTokenCount;
  List<PromptTokensDetailsModel> promptTokensDetails;
  List<CandidatesTokensDetails> candidatesTokensDetails;

  UsageMetaDataModel({
    required this.promptTokensDetails,
    required this.candidatesTokenCount,
    required this.totalTokenCount,
    required this.promptTokenCount,
    required this.candidatesTokensDetails,
  });

  factory UsageMetaDataModel.fromMap(Map<String, dynamic> json) {
    List<PromptTokensDetailsModel> promptTokensDetails = [];
    List<CandidatesTokensDetails> candidatesTokenDetails = [];

    for (Map<String, dynamic> eachPrompt in json['promptTokensDetails']) {
      promptTokensDetails.add(PromptTokensDetailsModel.fromMap(eachPrompt));
    }
    for (Map<String, dynamic> json in json['candidatesTokensDetails']) {
      candidatesTokenDetails.add(CandidatesTokensDetails.fromMap(json));
    }
    return UsageMetaDataModel(
      promptTokensDetails: promptTokensDetails,
      candidatesTokenCount: json['candidatesTokenCount'],
      totalTokenCount: json['totalTokenCount'],
      promptTokenCount: json['promptTokenCount'],
      candidatesTokensDetails: candidatesTokenDetails,
    );
  }
}

class ResponseDataModel {
  List<CandidatesModel> candidates;
  UsageMetaDataModel usageMetadata;
  String modelVersion;
  String responseId;

  ResponseDataModel({
    required this.candidates,
    required this.modelVersion,
    required this.responseId,
    required this.usageMetadata,
  });

  factory ResponseDataModel.fromMap(Map<String, dynamic> json) {
    List<CandidatesModel> candidates = [];

    for (Map<String, dynamic> json in json['candidates']) {
      candidates.add(CandidatesModel.fromMap(json));
    }

    return ResponseDataModel(
      candidates: candidates,
      modelVersion: json['modelVersion'],
      responseId: json['responseId'],
      usageMetadata: UsageMetaDataModel.fromMap(json['usageMetadata']),
    );
  }
}

class MessageSendContentProviderModel {
  String contentTypeName;
  String text;
  String leadingIconPath;
  Function onHandle;
  MessageSendContentProviderModel(
      {this.contentTypeName, this.text, this.leadingIconPath, this.onHandle});
}

enum OptionsType { NONE, SOME, LOADING }

class Options<T>{
  OptionsType _type = OptionsType.NONE;
  late T _value;

  bool get isLoading => _type == OptionsType.LOADING;
  bool get isNone => _type == OptionsType.NONE;
  bool get isSome => _type == OptionsType.SOME;

  void setLoading(){
    _type = OptionsType.LOADING;
  }

  void setNone(){
    _type = OptionsType.NONE;
  }

  void setSome(T value){
    _value = value;
    _type = OptionsType.SOME;
  }

  T getValue(){
    if(isSome){
      return _value;
    }

    throw Exception("The type $_type do not have a value...");
  }

  U match<U>({
    required U Function() onLoading,
    required U Function() onNone,
    required U Function(T) onSome
  }) {
    switch(_type) {
      case OptionsType.LOADING:
        return onLoading();
      case OptionsType.NONE:
        return onNone();
      case OptionsType.SOME:
        return onSome(_value);
    }
  }
}
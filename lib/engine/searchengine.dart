/// A package that performs Full Text Search on List of Strings
class FullTextSearcher {
  ///[query] is the text you're searching for in [terms]
  final String query;

  ///[terms] is the list of Strings which will searched
  final List<String> terms;

  FullTextSearcher({
    required this.query,
    required this.terms,
  });

  List<String> _splitQuery(String query) {
    List<String> arrList = [];
    //Split query sentence into words
    List<String> qSplit = query.toLowerCase().split(" ");
//Each word store combination in a list
    for (var q in qSplit) {
      for (var i = 0; i < q.length; i++) {
        String _temp = q.substring(q.length - (i + 1));
        if (_temp.length > 2) {
          arrList.add(_temp);
        }
      }
      //Each word store combination in reverse in a list
      String _q = String.fromCharCodes(q.trim().runes.toList().reversed);
      for (var i = 0; i < _q.length; i++) {
        String _temp = _q.substring(_q.length - (i + 1));
        var res = String.fromCharCodes(_temp.runes.toList().reversed);
        if (res.length > 2) {
          arrList.insert(0, res);
        }
      }
    }
    //Return list
    return arrList;
  }

  ///[search]
  List<String> search({String? query, List<String>? terms}) {
    List<String> _sList = [];
    var queryList = _splitQuery(query ?? this.query);
    for (var i = 0; i < queryList.length; i++) {
      for (var n in terms ?? this.terms) {
        String _temp = n.toLowerCase().trim();
        if (_temp.startsWith(queryList[i])) {
          _sList.insert(0, n);
        } else if (_temp.contains(queryList[i])) {
          _sList.add(n);
        }
      }
    }
    // print({..._sList}.toList());
    return {..._sList}.toList();
  }
}

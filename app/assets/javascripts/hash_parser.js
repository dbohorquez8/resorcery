var HashParser = (function(){
  function getHashTerms(){
    var hash = window.location.hash;
    if (!hash || !hash.length){
      return [];
    }

    if(hash[0] === '#'){
      hash = hash.slice(1);
    }

    return hash.split("&");
  }

  function getParsedHash() {
    var terms = getHashTerms();
    return _.reduce(terms, function(parsedHash, term) {
      var termTokens = term.split("=");
      if(termTokens.length === 2){
        parsedHash[termTokens[0]] = termTokens[1];
      }
      return parsedHash;
    }, {});
  }

  return {
    getParsedHash: getParsedHash
  }
})();

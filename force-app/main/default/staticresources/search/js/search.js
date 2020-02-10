
var SearchPrototype = 
{ 
    delimeters: ['.',',',':',' '] ,
    addTerm: function(inputString) 
    {    
        var terms = this.tokenize(inputString);
        for (var i =0; i < terms.length; i++)
        {
          this.terms.push(terms[i]);
        }
        
    }, 
    hasTerm: function(term)
    {
         return this.terms.contains(term);
    },
    // Return an array of one or more terms based on a token splitting algorithm. 
    tokenize: function(inputString)
    {
        for (var i = 0; i < this.delimeters.length; i++)
        {
             inputString = inputString.replace(this.delimeters[i], " ");
        }
        return inputString.split(" ");
    }, 
    removeTerm: function(term)
    {
         this.terms.locate(term).removeMe();
    }, 
    clear: function()
    {
         this.terms = [];
    },
    getTerms: function()
    {
         return this.terms;
    },
    getParameters:function()
    {
         return this.terms;
    }
};
var Search = function(inputString)
{
     this.terms = [];
     this.addTerm(inputString);

};
Search.prototype = SearchPrototype;
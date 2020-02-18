var FilterPrototype = {
    getFilter: function() {
        return this.filter;
    },

    clearFilter: function() {
        this.filter = null;
    }
}
var Filter = function(filterString) {
    this.filter = filterString;
    
};
Filter.prototype = FilterPrototype;
public with sharing class QueryBuilder {

		/**
		 * @var table
		 *
		 * @description The name of the SObject/table 
		 *  that will be queried; will be used in the FROM
		 *  portion of the SOQL query.
		 */
    private String table;
    
    /**
     * @var columns
     *
     * @description A list of object fields/columns
     *  to be queried from objects in the SOQL.
     *
     * @type String Array
     */
    private String[] columns = new String[]{};

		/**
		 * @var groups
		 *
		 * @description Conditions that will be applied to 
		 *  the SOQL query.
		 *
		 * @type SqlCondition Array
		 */
    private List<SqlCondition[]> groups = new List<SqlCondition[]>{};
    
    
		/**
		 * @var options
		 *
		 * @description - An array of options to be 
		 *  passed at the end of the SOQL query.
		 *  Example: ORDER BY PRICE DESC (for ordering Products 
		 *  from most-expensive to least-expensive.
		 *
		 *  @type String[]
		 */
		private List<String[]> options = new List<String[]>{};
		
		


		/**
		 * @var query
		 *
		 * @description - The compiled query, for debugging.
		 *  Can be passed to a Database.query statement.
		 *
		 * @type String
		 */
    private String query;


 		/**
 		 * @constructor
 		 */
    public QueryBuilder() {
        groups.add(new SqlCondition[]{});
    }

    public static QueryBuilder NewFromSettings(String table, String[] columns, List<SqlCondition> conditions) {
        QueryBuilder qb = new QueryBuilder();
        qb.SetTable(table);
        qb.SetColumns(columns);
        for(SqlCondition condition : conditions) {
            qb.AddCondition(condition);
        }

        return qb;
    }

    public static QueryBuilder NewFromSettings(String table, String[] columns) {
        return NewFromSettings(table, columns, new List<SqlCondition>{});
    }

    public void SetTable(String table) {
        this.table = table;
    }

    public void SetColumns(String[] columns) {
        this.columns = columns;
    }

    public void AddCondition(SqlCondition condition) {
        SqlCondition[] defaultGroup = groups[0];
        defaultGroup.Add(condition);
    }

    public String Compile() {

        // query += BuildSelect();
        String[] temp = new String[]{
            'SELECT',
            String.join(columns, Sql.FIELD_SEPERATOR),
            'FROM',
            table
        };


        if(groups[0].size() > 0) {
            temp.addAll(new String[]{
                'WHERE',
                BuildWhere()
            });
            // query += 'WHERE ' + BuildWhere();
        }
        
        for(String[] opt : options) {
        	temp.add(String.join(opt, Sql.TOKEN_SEPERATOR));
        }
        
        query = String.join(temp, Sql.TOKEN_SEPERATOR);

        system.debug(query);

        return query;
    }
    
    
    public QueryBuilder setLimit(Integer theLimit) {
    	this.options.add(new String[]{'LIMIT',String.valueOf(theLimit)});
    	
    	return this;
    }
    public QueryBuilder orderBy(String fname) {
    	return this.orderBy(fname,Sql.ORDER_BY_ASC);
    }
    public QueryBuilder orderBy(String fname, String ascDesc) {
    	this.options.add(new String[]{'ORDER BY',fname,ascDesc});
    	
    	return this;
    }

    // private static String BuildSelect() {

    //     // // add each field to the select
    //     // for(Integer i = 0; i < settings.returnFields.size(); i++) {
    //     //     selectStatement += settings.targetObject + '.' + settings.returnFields[i];

    //     //     if(i != settings.returnFields.size() - 1) {
    //     //         selectStatement += ', ';
    //     //     }
    //     // }

    //     // return 'SELECT ' + String.join(SQL.FIELD_SEPERATOR, columns) + ' FROM ' + table;
    // }



    public String BuildWhere() {
        // String[] groups = new String[]{};
        // Sql.CONDITION_GROUP_START = '(';
        // Sql.CONDITION_GROUP_END = ')';



        // String[] group2 = new String[]{
        //     String.format(theFormat, new Object[]{'Name', Sql.OPERATOR_LIKE, 'samplestring2'}),
        //     String.format(theFormat, new Object[]{'Description', Sql.OPERATOR_LIKE, 'samplestring2'})
        // };

        List<String> stringWheres = new List<String>{};
        for(SqlCondition[] theGroup : groups) {
            
            stringWheres.add(FormatGroup(theGroup, Sql.OPERATOR_OR));
        }

        // groups.Add(AddGroup(group2, Sql.OPERATOR_OR));

        return String.join(stringWheres, Sql.OPERATOR_OR);
    }

    public String FormatGroup(SqlCondition[] theGroup, String operator) {
        String[] temp = new String[]{};
        for(SqlCondition condition : theGroup) {
            temp.add(condition.toString());
        }
        return Sql.CONDITION_GROUP_START + String.join(temp, operator) + Sql.CONDITION_GROUP_END + Sql.TOKEN_SEPERATOR;
    }

    // private static String BuildWhere(String[] searchTerms, String filter) {
    //     String wear = ' WHERE ';

    //     // search for every 'term' in every 'searchField'
    //     for(Integer i = 0; i < searchTerms.size(); i++) {
            
    //         // each search term should be wraped in () and seperated by 'OR'
    //         wear += '(';
            
    //         for(Integer j = 0; j < settings.searchFields.size(); j++) {
    //             wear += settings.targetObject + '.' + settings.searchFields[j] + ' LIKE \'%' + searchTerms[i] + '%\'';
                
    //             // as long as it is not the last time through the loop, add an 'OR'
    //             if(i != searchTerms.size() && j != settings.searchFields.size() - 1) {
    //                 wear += ' OR ';
    //             }
    //         }

    //         wear += ')';

    //         // seperate each search term by 'AND' not 'OR'
    //         if(i != searchTerms.size() - 1) {
    //             wear += ' AND ';
    //         }
    //     }

    //     // if there is a filter, add it to the where statement
    //     if(filter != null) {
    //         wear += ' AND (';
    //         for(Integer i = 0; i < settings.filterFields.size(); i++) {
    //             wear += settings.targetObject + '.' + settings.filterFields[i] + ' LIKE \'%' + filter + '%\'';

    //             // as long as it is not the last time through the loop, add an 'AND'
    //             if(i != settings.filterFields.size() - 1) {
    //                 wear += ' AND ';
    //             }
    //         }
    //         wear += ')';
    //     }

    //     // add the limit
    //     wear += ' LIMIT ' + String.valueOf(settings.limitObjects) + ' OFFSET 0';

    //     return wear;
    // }
    
}

public with sharing class SqlCondition {
    private String field;
    private String op = Sql.OPERATOR_EQUALS;
    private String value;
    private String format = '{0} {1} \'\'%{2}%\'\'';

    public SqlCondition(Object[] condition) {

        if(condition.size() < 3) {
            this.field = (String)condition[0];
            this.value = (String)condition[1];
        } else if(condition.size() > 3) {
            throw new SqlException();
        } else {
            this.field = (String)condition[0];
            this.op = (String)condition[1];
            this.value = (String)condition[2];
        }

    }
    
    public SqlCondition(String fName, Object value) {
    	this(fName,value,Sql.OPERATOR_EQUALS);
    }
    public SqlCondition(String fName, Object value, String op) {
    	this.field = fName;
    	this.op = null == op ? Sql.OPERATOR_EQUALS : op;
    	this.value = (String) value;
    }

    public SqlCondition(Map<String, Object> condition) {
        this.field = (String)condition.get('field');
        this.op = (String)(null == condition.get('op') ? this.op : condition.get('op'));
        this.value = null == condition.get('value') ? null : (String)condition.get('value');
    }

    public override string toString() {
    		if(this.op == Sql.OPERATOR_LIKE) {
        	return String.format(this.format, new Object[]{this.field, this.op, this.value});
        } else if((new String[]{Sql.OPERATOR_EQUALS,Sql.OP_NEQ}).contains(this.op)) {
        	if(null == this.value || 'NULL' == this.value) {
        		return String.format('{0} {1} NULL',new String[]{this.field,this.op});
        	}
        }
        
				return String.format('{0} {1}\'\'{2}\'\'',new String[]{this.field,this.op,this.value});
    }

    public class SqlException extends Exception {}
}

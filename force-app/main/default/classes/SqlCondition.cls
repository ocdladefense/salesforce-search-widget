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

    public SqlCondition(Map<String, Object> condition) {
        this.field = (String)condition.get('field');
        this.op = (String)(null == condition.get('op') ? this.op : condition.get('op'));
        this.value = (String)condition.get('value'); // check for int as well
    }

    public override string toString() {
        return String.format(this.format, new Object[]{this.field, this.op, this.value});
    }

    public class SqlException extends Exception {}
}

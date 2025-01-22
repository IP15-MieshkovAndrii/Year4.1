import java.util.List;

public class Transfer {
    private List<Process> nextElements;

    public Transfer(List<Process> nextElements){
        this.nextElements = nextElements;
    }
    public String goNext(Process current, double tCurr, Patient patient){
        int index = this.getIndex(current, tCurr, patient);
        if(index >= 0){
            Process nextElement = nextElements.get(index);
            nextElement.inAct(patient);
            return "free";
        } else if (index == -1){
            return "blocked";
        } else {
            return null;
        }
    }
    public String goNext(Create current, double tCurr, Patient patient){
        Time time = new Time(tCurr);
        double hours = time.getHours();

        if(hours >= 7 && hours <= 16){
            Process nextElement = nextElements.get(0);
            nextElement.inAct(patient);
            return "free";
        } else {
            return "blocked";
        }
    }
    public int getIndex(Process current, double tCurr, Patient patient) {

        Time time = new Time(tCurr);
        double hours = time.getHours();
        int type = patient.getType();
        int flag = patient.getFlag();
        int index = 0;
        int currentElement = 0;

        for(Process element : nextElements ){
            String[][] conditions = element.getConditions();
            String[][] blockers = element.getBlockers();
            String[][] changes = element.getChanges();

            if(blockers.length != 0) {
                for (String[] condition : blockers) {
                    boolean flagCondition = true;
                    boolean timeCondition = true;
        
                    for (int i = 0; i < condition.length; ) {
                        String key = condition[i];
                        
                        if ("flag".equals(key)) {
                            int conditionFlag = Integer.parseInt(condition[i + 1]);
                            flagCondition = (flag == conditionFlag);
                            i += 2;
                        } else if ("time".equals(key)) {
                            double start = Double.parseDouble(condition[i + 1]);
                            double end = Double.parseDouble(condition[i + 2]);
                            timeCondition = (hours >= start && hours <= end);
                            i += 3;
                        } else {
                            i++; 
                        }
                    }
                    if (flagCondition && timeCondition) {
                        index = 0;
                        break; 
                    }
                    return -1;
                }
            }

            if(conditions.length != 0) {
                
                for (String[] condition : conditions) {
                    boolean typeCondition = true;
        
                    for (int i = 0; i < condition.length; ) {
                        String key = condition[i];
                        
                        if ("type".equals(key)) {
                            int conditionFlag = Integer.parseInt(condition[i + 1]);
                            typeCondition = (type == conditionFlag);
                            i += 2;
                        } else if ("!type".equals(key)) {
                            int conditionFlag = Integer.parseInt(condition[i + 1]);
                            typeCondition = (type != conditionFlag);
                            i += 2;
                        } else {
                            i++; 
                        }
                    }
                    if (typeCondition) {
                        index = currentElement;
                        break; 
                    } 
                    if(nextElements.size() == 1) {
                        return -2;
                    }
                }
            }
        
            if(changes.length != 0) {
                for (String[] change : changes) {
                    for (int i = 0; i < change.length; ) {
                        String key = change[i];
                        
                        if ("type".equals(key)) {
                            int changeValue = Integer.parseInt(change[i + 1]);
                            patient.setType(changeValue);
                            i += 2;
                        } else if ("flag".equals(key)) {
                            int changeValue = Integer.parseInt(change[i + 1]);
                            patient.setFlag(changeValue);
                            i += 2;
                        } else {
                            i++; 
                        }
                    }
                }
            }
            
            currentElement++;
        }
        return index;

    }
    public Process getNext(){
        return nextElements.get(0);
    } 

    
}

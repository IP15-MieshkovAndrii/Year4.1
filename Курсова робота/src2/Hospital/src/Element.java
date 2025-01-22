import java.util.ArrayList;
import java.util.List;

public class Element {
    private String name;
    private int id;
    private int nextId = 0;
    private List<Device> devices;
    private Transfer transfer;
    private String[][] blockers = new String[0][0];
    private String[][] changes = new String[0][0];
    private String[][] conditions = new String[0][0];
    int maxQueue = 0;

    private double tNext;
    private double tCurr;
    private int quantity;

    double deltaNow = 0;
    List<Double> type1 = new ArrayList<>();
    List<Double> type2 = new ArrayList<>();
    List<Double> type3 = new ArrayList<>();
    List<Double> entryTimes = new ArrayList<>();
    

    public Element(String nameOfElement, List<Double> delays, List<String> distributions, int numberOfDevices){
        this.name = nameOfElement;
        this.tNext = 0.0;
        this.tCurr = tNext;
        this.devices = new ArrayList<>();
        for (int i = 0; i < numberOfDevices; i++) {
            this.devices.add(new Device(delays, distributions));
        }
        this.id = nextId;
        nextId++;
    }

    public void inAct(Patient patient){
    }
    public void outAct(){
        quantity++;
    }

    public void setDelay(int index, double delayDev){
        Device device = devices.get(index);
        device.setDelayDev(delayDev);
    }

    public void printResult(){
        System.out.println("\n" + this.name+ "\nquantity = "+ quantity);
        if(type1.size() > 0){
            double average = average(type1);
            double variance = variance(average, type1);
            double stdDev = Math.sqrt(variance);
            System.out.println("\nType 1: Average Duration = " + average + ", Standard Deviation = " + stdDev);
        } 
        if(type2.size() > 0){
            double average = average(type2);
            double variance = variance(average, type2);
            double stdDev = Math.sqrt(variance);
            System.out.println("\nType 2: Average Duration = " + average + ", Standard Deviation = " + stdDev);
        } 
        if(type3.size() > 0){
            double average = average(type3);
            double variance = variance(average, type3);
            double stdDev = Math.sqrt(variance);
            System.out.println("\nType 3: Average Duration = " + average + ", Standard Deviation = " + stdDev);
        } 

        if(entryTimes.size()>0){
            List<Double> intervals = new ArrayList<>();
            for (int i = 1; i < entryTimes.size(); i++) {
                double interval = entryTimes.get(i) - entryTimes.get(i - 1);
                intervals.add(interval);
            }

            double average = average(intervals);
            double variance = variance(average, intervals);
            double stdDev = Math.sqrt(variance);
            System.out.println("\nAverage Interval = " + average + ", Standard Deviation = " + stdDev);
        }
    }
    public double getTcurr() {
        return tCurr;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public void setTcurr(double tCurr) {
        this.tCurr = tCurr;
    }
    public void doStatistics(double delta){
        this.deltaNow = delta;
    }

    public List<Device> getDevices(){
        return devices;
    }

    public void setTransfer(List<Process> nextElements){
        this.transfer = new Transfer(nextElements);
    }
    public Transfer getTransfer() {
        return transfer;
    }
    public void setBlockers(String[][] blockers){
        this.blockers = blockers;
    }
    public String[][] getBlockers() {
        return blockers;
    }
    public void setChanges(String[][] changes){
        this.changes = changes;
    }
    public String[][] getChanges() {
        return changes;
    }
    public void setConditions(String[][] conditions){
        this.conditions = conditions;
    }
    public String[][] getConditions() {
        return conditions;
    }
    public void setTnext(double tNext) {
        this.tNext = tNext;
    }
    public double getTnext() {    
        return this.tNext;
    }

    public void updateTnext(){
        this.tNext = devices.stream()
                            .mapToDouble(Device::getTNext) 
                            .min()                       
                            .orElse(this.tNext);
    }

    public double average(List<Double> list){
        return list.stream().mapToDouble(Double::doubleValue).average().orElse(0);
    }

    public double variance(double average, List<Double> list){
        return list.stream()
                    .mapToDouble(x -> Math.pow(x - average, 2))
                    .average()
                    .orElse(0);
    }

}

import java.util.List;

public class Device {
    private List<Double> delaysAverage;
    private List<String> distributions;
    private double delayDev;

    private double tNext = Double.MAX_VALUE;
    private double tCurr = 0;

    private int state;
    private Patient patient;

    public Device(List<Double> delays, List<String> distributions) {
        this.delaysAverage = delays;
        this.distributions = distributions;
        this.state = 0;
    }

    public double getDelayAverage(int index) {
        double delay = delaysAverage.get(index);
        String distribution = distributions.get(index);

        switch (distribution.toLowerCase()) {
            case "exp":
                return FunRand.Exp(delay);
            case "erl":
                return FunRand.Erl(delay, this.delayDev);
            case "unif":
                return FunRand.Unif(delay, this.delayDev);
            default:
                return delay; 
        }
    }

    public void inAct(Patient patient, int index) {
        state = 1;
        this.patient = patient;
        this.tNext = tCurr + this.getDelayAverage(index);
        
    }

    public Patient outAct() {
        state = 0;
        Patient result = this.patient;
        this.patient = null;
        return result;
    }

    public void setTNext(double tNext) {
        this.tNext = tNext;
    }
    public double getTNext() {
        return tNext;
    }

    public void setTcurr(double tCurr) {
        this.tCurr = tCurr;
    }

    public int getState() {
        return state;
    }

    public void setDelayDev(double delayDev) {
        this.delayDev = delayDev;
    }

    public void setPatient(Patient patient){
        this.patient = patient;
    }
    public Boolean isPatient() {
        return this.patient != null;
    }

    public void addWaiting(int index) {
        state = 1;
        this.patient = null;
        this.tNext = tCurr + this.getDelayAverage(index);
    }

    public int getDelayNumber() {
        return delaysAverage.size();
    }
}
